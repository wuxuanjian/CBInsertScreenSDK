//
//  CBGPSEngine.m
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-30.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBGPSEngine.h"

@interface CBGPSEngine()
{
    CBLocationNameBlock locationBlock;
}
@end

@implementation CBGPSEngine
@synthesize locationManage = _locationManage;
@synthesize geoCoder = _geoCoder;
@synthesize reverseGeocoder = _reverseGeocoder;

- (id)init
{
    self = [super init];
    if (self)
    {
        _locationManage = nil;
    }
    return self;
}

- (void)startLocation:(CBLocationNameBlock)locatBlock
{
    locationBlock = locatBlock;
    
//    BOOL locationBool  = cbLocationState();
//    if(locationBool == YES)
//    {
//        locationBlock(locationBool);
//        return;
//    }
    
    if(_locationManage == nil)
    {
        _locationManage = [[CLLocationManager alloc] init];
        _locationManage.delegate = self; //self所指的类需要实现<CLLocationManagerDelegate>协议
        _locationManage.desiredAccuracy = kCLLocationAccuracyBest;//精度，越精确越费电
        _locationManage.distanceFilter = 1.0f;
//        _locationManage.desiredAccuracy = kCLLocationAccuracyHundredMeters;
//        _locationManage.distanceFilter = 50.0f;
    }
    [_locationManage startUpdatingLocation]; //开始刷
}

-(void) stopLocation
{
    [_locationManage stopUpdatingLocation];
}

#pragma mark - location Delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
//    NSLog(@"定位出错");
    setLocationState(NO);
    locationBlock(NO);
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if (!newLocation) {
        [self locationManager:manager didFailWithError:(NSError *)NULL];
        return;
    }
    
    if (signbit(newLocation.horizontalAccuracy)) {
		[self locationManager:manager didFailWithError:(NSError *)NULL];
		return;
	}
    
    [manager stopUpdatingLocation];
    //latitude 维度 longitude 经度 设置
    setLocation(newLocation);
    
    //解析并获取当前坐标对应得地址信息
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [self locationAddressWithLocation:newLocation];
    }else {
        [self startedReverseGeoderWithLatitude:newLocation.coordinate.latitude
                                     longitude:newLocation.coordinate.longitude];
    }
}

#pragma mark - 获取城市名称
//   iso  5.0 以下版本使用此方法
- (void)startedReverseGeoderWithLatitude:(double)latitude longitude:(double)longitude{
    CLLocationCoordinate2D coordinate2D;
    coordinate2D.longitude = longitude;
    coordinate2D.latitude = latitude;
    MKReverseGeocoder *geoCoder = [[MKReverseGeocoder alloc] initWithCoordinate:coordinate2D];
    self.reverseGeocoder = geoCoder;
    
    self.reverseGeocoder.delegate = self;
    [self.reverseGeocoder start];
}

#pragma mark -
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    locationBlock(YES);
    NSString* pronince = placemark.locality;
    NSString* ciyt = placemark.locality;
    setLocationState(YES);
    setLocationCity(pronince, ciyt);
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
//    NSLog(@"获取失败");
    setLocationState(NO);
    locationBlock(NO);
}

//  IOS 5.0 及以上版本使用此方法
- (void)locationAddressWithLocation:(CLLocation *)locationGps
{
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    self.geoCoder = clGeoCoder;
    
    [self.geoCoder reverseGeocodeLocation:locationGps completionHandler:^(NSArray *placemarks, NSError *error)
     {
         NSLog(@"error %@ placemarks count %d",error.localizedDescription,placemarks.count);
         if (placemarks.count == 0)
         {
             setLocationState(NO);
             locationBlock(NO);
         }
         else
         {
             for (CLPlacemark *placeMark in placemarks)
             {
                 locationBlock(YES);
                 NSString* pronince = placeMark.locality;
                 NSString* ciyt = placeMark.locality;
                 setLocationState(YES);
                 setLocationCity(pronince, ciyt);
             }
         }
     }];
}


@end
