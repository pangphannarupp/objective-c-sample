//
//  GPSPlugin.h
//  sample
//
//  Created by Pang Phanna on 13/4/23.
//

#import <Foundation/Foundation.h>
#import "Plugin.h"
#import <CoreLocation/CoreLocation.h>

@interface GPSPlugin : Plugin <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end
