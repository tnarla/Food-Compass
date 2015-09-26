//
//  WFLocator.h
//  ActionKit
//
//  Created by Conrad Kramer on 7/19/14.
//  Copyright (c) 2014 Conrad Kramer. All rights reserved.
//

#ifndef WFLocator_h
#define WFLocator_h
#import <CoreLocation/CoreLocation.h>

@interface WFLocator : NSObject

+ (void)determineLocationWithDesiredAccuracy:(CLLocationAccuracy)accuracy timeout:(NSTimeInterval)timeout completion:(void (^)(CLLocation *location, NSError *error))completion;

@end

#endif /* WFLocator_h */
