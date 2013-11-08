//
//  CBGPSEngine.h
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-30.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InsertScreen.h"
typedef void (^CBLocationNameBlock)(BOOL aState);
@interface CBGPSEngine : NSObject<CLLocationManagerDelegate,MKReverseGeocoderDelegate>
{
    CLLocationCoordinate2D _coordinate;
    CLGeocoder *_geoCoder;
    MKReverseGeocoder *_reverseGeocoder;
}

@property (nonatomic,strong) CLLocationManager* locationManage;
@property (nonatomic, strong) CLGeocoder *geoCoder;
@property (nonatomic, strong) MKReverseGeocoder *reverseGeocoder;

- (id)init;
- (void)startLocation:(CBLocationNameBlock)locatBlock;
-(void) stopLocation;

@end
