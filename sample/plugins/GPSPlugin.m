//
//  GPSPlugin.m
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import "GPSPlugin.h"

@implementation GPSPlugin

- (void)execute:(NSDictionary *)param {
    NSLog(@"GPSPlugin => param => %@", param);
    
    self.util = [[Util alloc] init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    } else {
        [self.util showDialog:self.viewController message:@{
            @"result": @NO,
            @"errorCode": @"-1",
            @"errorMessage": @"Permission denied",
        }];
    }
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations lastObject];
    NSLog(@"Latitude: %f, Longitude: %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    [self.util showDialog:self.viewController message:@{
        @"result": @YES,
        @"latitude": [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude],
        @"longitude": [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude],
    }];
    
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    [self.util showDialog:self.viewController message: @{
        @"result": @NO,
        @"errorCode": [NSString stringWithFormat:@"%ld", (long)error.code],
        @"errorMessage": error.localizedDescription,
    }];
}

@end
