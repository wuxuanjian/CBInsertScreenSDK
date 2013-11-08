//
//  CBInsertUtils.h
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-31.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InsertScreen.h"

//适配屏幕
//BGview的宽度和高度配置
CGFloat backgroundframeW(SCREEN_DIRECTION screenDirection);
CGFloat backgroundframeH(SCREEN_DIRECTION screenDirection);
//插入view的高度和宽度配置
CGFloat screenViewW(SCREEN_DIRECTION screenDirection);
CGFloat screenViewH(SCREEN_DIRECTION screenDirection);
//插入view的X和Y配置
CGFloat screenViewX(SCREEN_DIRECTION screenDirection);
CGFloat screenViewY(SCREEN_DIRECTION screenDirection);

//设置参数
//设置adId：上一次获取的最后一个广告的ID
void setCbAdId(NSString* adid);
//设置经纬度
void setLocation(CLLocation* aLocation);
//定位省市设置
void setLocationCity(NSString* aProvince, NSString* aCity);
//定位成功与失败的状态
void setLocationState(BOOL aState);


//appId：后期分配的应用唯一标示码
NSString* cbAppId();
//ua：user-agent
NSString* cbUserAgent();
//mac地址获取
NSString* cbMacaddress();
//sendCount：需要获取的广告数
NSString* cbSendCount();
//adId：上一次获取的最后一个广告的ID
NSString* getCbAdId();
//adType：广告类型
NSString* cbAdType();

//获取运营商
NSString* cbCheckCarrier();
//sdkVersion：sdk版本号
NSString* cbSdkVersion();
//idfa:  广告标示符
NSString* cbIdfa();
//openUdid:可以替代UDID
NSString* cbOpenUDid();
//os：设备操作系统
NSString* cbSysOS();
//packageName：应用唯一标示
NSString* cbPackageName();
//应用包 版本号
NSString* cbVersionCode();
//latitude纬度
NSString* cbLatitudeStr();
//longitude经度
NSString* cbLongitudeStr();
//定位省名称
NSString* cbProvinceStr();
//定位市名称
NSString* cbCityStr();
//定位状态
BOOL cbLocationState();

