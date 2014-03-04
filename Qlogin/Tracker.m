//
//  Tracker.m
//  Qlogin
//
//  Created by Eric MILLS on 3/4/14.
//  Copyright (c) 2014 westmason. All rights reserved.
//

#import "Tracker.h"

@implementation Tracker

+ (id)sharedTracker
{
	static CLLocationManager *_locationManager;
	
	@synchronized(self) {
		if (_locationManager == nil) {
			_locationManager = [[CLLocationManager alloc] init];
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		}
	}
	return _locationManager;
}

- (id)init
{
    if (self == [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        taskArray = [NSMutableArray new];
    }
    return self;
}

- (UIBackgroundTaskIdentifier)applicationEnterBackground{
    UIApplication* application = [UIApplication sharedApplication];
    
    UIBackgroundTaskIdentifier taskID = UIBackgroundTaskInvalid;
    if([application respondsToSelector:@selector(beginBackgroundTaskWithExpirationHandler:)]){
        taskID = [application beginBackgroundTaskWithExpirationHandler:^{
            [self flushTasks];
            [application endBackgroundTask:taskID];
        }];
        [taskArray addObject:@(taskID)];
    }
    return taskID;
}

-(void)flushTasks{
    UIApplication *application = [UIApplication sharedApplication];
    if([application respondsToSelector:@selector(endBackgroundTask:)]){
        for(NSNumber *task in taskArray){
            UIBackgroundTaskIdentifier taskID = [task integerValue];

            [application endBackgroundTask:taskID];
        }
        [taskArray removeAllObjects];
    }
}

- (void)startTracking
{
    if ([CLLocationManager locationServicesEnabled] == NO) {
        NSLog(@"Location Services is turned OFF");
    }else{
        [_locationManager startUpdatingLocation];
    }
}

- (void)stopTracking
{
    if ([CLLocationManager locationServicesEnabled] == NO) {
        NSLog(@"Location Services is turned OFF");
    }else{
        [_locationManager stopUpdatingLocation];
    }
}

#pragma mark - CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    for(int i = 0; i < locations.count; i++){
        CLLocation *newLocation = [locations objectAtIndex:i];
        CLLocationCoordinate2D theLocation = newLocation.coordinate;
        
        NSMutableDictionary *locDict = [[NSMutableDictionary alloc]init];
        [locDict setObject:[NSNumber numberWithFloat:theLocation.latitude] forKey:@"latitude"];
        [locDict setObject:[NSNumber numberWithFloat:theLocation.longitude] forKey:@"longitude"];
    }
    
    [self applicationEnterBackground];
    
    timeInterval = [NSTimer scheduledTimerWithTimeInterval:60 target:self
                                                           selector:@selector(startTracking)
                                                           userInfo:nil
                                                            repeats:NO];
    
}


@end
