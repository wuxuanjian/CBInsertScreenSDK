//
//  CBinsertScreenSDK.h
//  CBinsertScreenSDK
//
//  Created by EinFachMann on 13-11-8.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CB_AD_IOS_SDK_APPID             @"09090200"         //appId：后期分配的应用唯一标示码
#define CB_AD_IOS_SDK_SENDCOUNT         @"3"             //sendCount：需要获取的广告数
#define CB_AD_IOS_SDK_ADTYPE            @"chaping"             //adType：广告类型
#define CB_AD_IOS_SDK_PACKAGENAME       @"com.test.up_soft"   //packageName：应用唯一标示

@interface CBinsertScreenSDK : NSObject

/*
 *sdk 初始化
 */
+(CBinsertScreenSDK*) insertScreenSDK;

/*
 *展示sdk
 */
+(BOOL) showInsertScreenSDK;

@end
