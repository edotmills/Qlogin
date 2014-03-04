//
//  Tracker.h
//  Qlogin
//
//  Created by Eric MILLS on 3/4/14.
//  Copyright (c) 2014 westmason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Tracker : NSObject <CLLocationManagerDelegate>
{
    NSMutableArray *taskArray;
    NSTimer *timeInterval;
}
@property(nonatomic, strong)CLLocationManager *locationManager;

+ (id)sharedTracker;
- (void)startTracking;
- (void)stopTracking;
- (void)enterBackground;

@end
