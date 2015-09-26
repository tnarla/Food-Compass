//
//  WFLocator.m
//  ActionKit
//
//  Created by Conrad Kramer on 7/19/14.
//  Copyright (c) 2014 Conrad Kramer. All rights reserved.
//

#import "WFLocator.h"

@interface WFLocator () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *bestEffortLocation;
@property (nonatomic, strong) void (^completionHandler)(CLLocation *, NSError *);
@property (nonatomic) NSTimeInterval timeout;

@end

@implementation WFLocator

+ (void)determineLocationWithDesiredAccuracy:(CLLocationAccuracy)accuracy timeout:(NSTimeInterval)timeout completion:(void (^)(CLLocation *location, NSError *error))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        WFLocator *locator = [[WFLocator alloc] init];
        locator.locationManager.desiredAccuracy = accuracy;
        locator.timeout = timeout;
        
        __block __typeof(locator) strongLocator = locator;
        locator.completionHandler = ^(CLLocation *location, NSError *error) {
            if (completion)
                completion(location, error);
            
            strongLocator = nil;
        };
        
        [locator start];
    });
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)dealloc {
    self.locationManager.delegate = nil;
}

- (void)start {
    [self.locationManager startUpdatingLocation];
    [self performSelector:@selector(finishUpdatingLocation) withObject:nil afterDelay:self.timeout];
}

- (void)finishUpdatingLocation {
    [self.locationManager stopUpdatingLocation];
    
    if (self.completionHandler) {
        CLLocation *bestEffortLocation = self.bestEffortLocation;
        if (bestEffortLocation)
            self.completionHandler(bestEffortLocation, nil);
        else
            self.completionHandler(bestEffortLocation, [NSError errorWithDomain:kCLErrorDomain code:kCLErrorLocationUnknown userInfo:@{NSLocalizedFailureReasonErrorKey: @"Food Compass was unable to find your current location.", NSLocalizedDescriptionKey: @"Make sure your device isn't in Airplane Mode and try again; turning Wi-Fi on may help."}]);
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *latestLocation = [locations lastObject];
    
    // Don't rely on cached measurements
    NSTimeInterval locationAge = -[latestLocation.timestamp timeIntervalSinceNow];
    if (locationAge > self.timeout)
        return;
    
    // Test that the horizontal accuracy does not indicate an invalid measurement
    if (latestLocation.horizontalAccuracy < 0)
        return;
    
    // Test the measurement to see if it is more accurate than the previous measurement
    if (!self.bestEffortLocation || self.bestEffortLocation.horizontalAccuracy > latestLocation.horizontalAccuracy) {
        self.bestEffortLocation = latestLocation;
        
        if (latestLocation.horizontalAccuracy <= kCLLocationAccuracyNearestTenMeters) {
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishUpdatingLocation) object:nil];
            [self finishUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // CoreLocation will keep trying to find the location even if it complains that the location is currently unknown
    if ([error.domain isEqualToString:kCLErrorDomain] && error.code == kCLErrorLocationUnknown)
        return;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishUpdatingLocation) object:nil];
    [manager stopUpdatingLocation];
    if (self.completionHandler)
        self.completionHandler(self.bestEffortLocation, error);
}

@end
