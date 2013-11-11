//
//  CBInsertUtils.m
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-31.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBInsertUtils.h"

//获取mac地址头文件
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

//获取运营商头文件
#import<CoreTelephony/CTTelephonyNetworkInfo.h>
#import<CoreTelephony/CTCarrier.h>
//获取系统版本号和机型
#import "sys/utsname.h"
//获取idfat头文件
#import <AdSupport/AdSupport.h>
#import "OpenUDID.h"


//*******************************
#define IOS_IPHONE_STATE_BG_H        10    //顶点偏移
//iphone4
#define IOS_IPHONE4_BG_VERTICAL_W    320  //iphone5宽度也是这个
#define IOS_IPHONE4_BG_VERTICAL_H    480
//iphone5
#define IOS_IPHONE5_BG_VERTICAL_H    568
//ipad
#define IOS_IPAD_BG_VERTICAL_W       768
#define IOS_IPAD_BG_VERTICAL_H       1024

//iphone4
#define IOS_IPHONE4_SCREENVIEW_W     ((320.0/10)*8)  //iphone4宽度也是这个
#define IOS_IPHONE4_SCREENVIEW_H     ((320.0/10)*8)  //iphone4高度也是这个
//iphone5
#define IOS_IPHONE5_BG_SCREENVIEW_H  ((320.0/10)*8)  //iphone5高度也是这个
//ipad
#define IOS_IPAD_SCREENVIEW_H        ((768/10.0)*8) //ipad高度也是这个
#define IOS_IPAD_SCREENVIEW_W        ((768.0/10)*8)  //ipad款度也是这个
//*******************************

//*******************************
#define CB_IOS_SDK_APPID             @"09090200"         //appId：后期分配的应用唯一标示码
#define CB_IOS_SDK_SENDCOUNT         @"3"             //sendCount：需要获取的广告数
#define CB_IOS_SDK_ADTYPE            @"chaping"             //adType：广告类型
#define CB_IOS_SDK_PACKAGENAME       @"com.test.up_soft"   //packageName：应用唯一标示
#define CB_IOS_SDK_VERSION           @"1.1.4"           //sdkVersion：sdk版本号
//*******************************

//***********************************************************************************
//适配屏幕
//插入view的高度和宽度配置
CGFloat backgroundframeW(SCREEN_DIRECTION screenDirection)
{
    CGFloat dateViewW = [UIScreen mainScreen].applicationFrame.size.width;
    CGFloat dateViewH = [UIScreen mainScreen].applicationFrame.size.height;
    if(screenDirection == SCREEN_DIRECTION_ACROSS) //横向
    {
        if(dateViewH <= IOS_IPHONE4_BG_VERTICAL_H) //480
        {
            return IOS_IPHONE4_BG_VERTICAL_H;
        }
        else if(dateViewH <= IOS_IPHONE5_BG_VERTICAL_H) //568
        {
            return IOS_IPHONE5_BG_VERTICAL_H;
        }
        else if(dateViewH <= IOS_IPAD_BG_VERTICAL_H) //1136
        {
            return IOS_IPAD_BG_VERTICAL_H;
        }
    }
    else
    {
        if(dateViewH <= IOS_IPHONE4_BG_VERTICAL_H) //480
        {
            return IOS_IPHONE4_BG_VERTICAL_W;
        }
        else if(dateViewH <= IOS_IPHONE5_BG_VERTICAL_H) //568
        {
            return IOS_IPHONE4_BG_VERTICAL_W;
        }
        else if(dateViewH <= IOS_IPAD_BG_VERTICAL_H) //1136
        {
            return IOS_IPAD_BG_VERTICAL_W;
        }
    }
    return dateViewW;
}

CGFloat backgroundframeH(SCREEN_DIRECTION screenDirection)
{
    CGFloat dateViewH = [UIScreen mainScreen].applicationFrame.size.height;
    if(screenDirection == SCREEN_DIRECTION_ACROSS) //横向
    {
        if(dateViewH <= IOS_IPHONE4_BG_VERTICAL_H) //480
        {
            return IOS_IPHONE4_BG_VERTICAL_W;
        }
        else if(dateViewH <= IOS_IPHONE5_BG_VERTICAL_H) //568
        {
            return IOS_IPHONE4_BG_VERTICAL_W;
        }
        else if(dateViewH <= IOS_IPAD_BG_VERTICAL_H) //1136
        {
            return IOS_IPAD_BG_VERTICAL_W;
        }
    }
    else
    {
        if(dateViewH <= IOS_IPHONE4_BG_VERTICAL_H) //480
        {
            return IOS_IPHONE4_BG_VERTICAL_H;
        }
        else if(dateViewH <= IOS_IPHONE5_BG_VERTICAL_H) //568
        {
            return IOS_IPHONE5_BG_VERTICAL_H;
        }
        else if(dateViewH <= IOS_IPAD_BG_VERTICAL_H) //1136
        {
            return IOS_IPAD_BG_VERTICAL_H;
        }
    }
    return dateViewH;
}

//插入view的高度和宽度配置
CGFloat screenViewW(SCREEN_DIRECTION screenDirection)
{
    CGFloat dateViewW = [UIScreen mainScreen].applicationFrame.size.width;
    CGFloat dateViewH = [UIScreen mainScreen].applicationFrame.size.height;
    if(screenDirection == SCREEN_DIRECTION_ACROSS) //横向
    {
        if(dateViewH <= IOS_IPHONE4_BG_VERTICAL_H) //480
        {
            return IOS_IPHONE4_SCREENVIEW_H;
        }
        else if(dateViewH <= IOS_IPHONE5_BG_VERTICAL_H) //568
        {
            return IOS_IPHONE5_BG_SCREENVIEW_H;
        }
        else if(dateViewH <= IOS_IPAD_BG_VERTICAL_H) //1136
        {
            return IOS_IPAD_SCREENVIEW_H;
        }
    }
    else
    {
        if(dateViewH <= IOS_IPHONE4_BG_VERTICAL_H) //480
        {
            return IOS_IPHONE4_SCREENVIEW_W;
        }
        else if(dateViewH <= IOS_IPHONE5_BG_VERTICAL_H) //568
        {
            return IOS_IPHONE4_SCREENVIEW_W;
        }
        else if(dateViewH <= IOS_IPAD_BG_VERTICAL_H) //1136
        {
            return IOS_IPAD_SCREENVIEW_W;
        }
    }
    return dateViewW;
}

CGFloat screenViewH(SCREEN_DIRECTION screenDirection)
{
    CGFloat dateViewH = [UIScreen mainScreen].applicationFrame.size.height;
    if(screenDirection == SCREEN_DIRECTION_ACROSS) //横向
    {
        if(dateViewH <= IOS_IPHONE4_BG_VERTICAL_H) //480
        {
            return IOS_IPHONE4_SCREENVIEW_W;
        }
        else if(dateViewH <= IOS_IPHONE5_BG_VERTICAL_H) //568
        {
            return IOS_IPHONE4_SCREENVIEW_W;
        }
        else if(dateViewH <= IOS_IPAD_BG_VERTICAL_H) //1136
        {
            return IOS_IPAD_SCREENVIEW_W;
        }
    }
    else
    {
        if(dateViewH <= IOS_IPHONE4_BG_VERTICAL_H) //480
        {
            return IOS_IPHONE4_SCREENVIEW_H;
        }
        else if(dateViewH <= IOS_IPHONE5_BG_VERTICAL_H) //568
        {
            return IOS_IPHONE5_BG_SCREENVIEW_H;
        }
        else if(dateViewH <= IOS_IPAD_BG_VERTICAL_H) //1136
        {
            return IOS_IPAD_SCREENVIEW_H;
        }
    }
    return dateViewH;
}

//插入view的X和Y配置
CGFloat screenViewX(SCREEN_DIRECTION screenDirection)
{
    CGFloat screeX = (backgroundframeW(screenDirection) - screenViewW(screenDirection))/2;
    return screeX;
}

CGFloat screenViewY(SCREEN_DIRECTION screenDirection)
{
     CGFloat screey = (backgroundframeH(screenDirection) - screenViewH(screenDirection))/2;
    return screey + IOS_IPHONE_STATE_BG_H;
}

//***********************************************************************************

//***********************************************************************************
//设置参数
//设置adId：上一次获取的最后一个广告的ID
void setCbAdId(NSString* adid)
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setObject:adid forKey:USERDEFAULTS_CB_LAST_ADID_KEY];//定位城市名
}

//设置经纬度
void setLocation(CLLocation* aLocation)
{
    NSString* latitude = [NSString stringWithFormat: @"%f",aLocation.coordinate.latitude];
    NSString* longitude = [NSString stringWithFormat: @"%f",aLocation.coordinate.longitude];
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setObject:longitude forKey:USERDEFAULTS_CB_LONGITUDE_KEY];//经度
    [accountDefaults setObject:latitude forKey:USERDEFAULTS_CB_LATITUDE_KEY];//纬度
}

//定位省市设置
void setLocationCity(NSString* aProvince, NSString* aCity)
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setObject:aProvince forKey:USERDEFAULTS_CB_PROVINCE_KEY];//省
    [accountDefaults setObject:aCity forKey:USERDEFAULTS_CB_CITY_NAME_KEY];//市
}

//定位成功与失败的状态
void setLocationState(BOOL aState)
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setBool:aState forKey:USERDEFAULTS_CB_GPS_STATE_KEY];//定位成功
}

//***********************************************************************************

//***********************************************************************************
//appId：后期分配的应用唯一标示码
NSString* cbAppId()
{
    return CB_IOS_SDK_APPID;
}

//ua：user-agent
NSString* cbUserAgent()
{
    //here use sys/utsname.h
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *model = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if(model == nil)
    {
        return @"";
    }
    return model;
}

//mac地址获取
NSString* cbMacaddress()
{
	int                    mib[6];
	size_t                len;
	char                *buf;
	unsigned char        *ptr;
	struct if_msghdr    *ifm;
	struct sockaddr_dl    *sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0)
    {
		return NULL;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
    {
		return NULL;
	}
	
	if ((buf = malloc(len)) == NULL) {
		return NULL;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	// NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
    
    if(outstring == nil)
    {
        return @"";
    }
	return [outstring uppercaseString];
	
}

//sendCount：需要获取的广告数
NSString* cbSendCount()
{
    return CB_IOS_SDK_SENDCOUNT;
}

//adId：上一次获取的最后一个广告的ID
NSString* getCbAdId()
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString* adid = [accountDefaults objectForKey:USERDEFAULTS_CB_LAST_ADID_KEY];
    if(adid == nil)
    {
        return @"";
    }
    return adid;
}

//adType：广告类型
NSString* cbAdType()
{
    return CB_IOS_SDK_ADTYPE;
}

//获取运营商
//用来辨别设备所使用网络的运营商
NSString* cbCheckCarrier()
{
    NSString *ret = [[NSString alloc]init];
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    if (carrier == nil)
    {
        return @"0";
    }
    NSString *code = [carrier mobileNetworkCode];
    if ([code isEqualToString:@""])
    {
        return @"0";
        
    }
    if ([code isEqualToString:@"00"] || [code isEqualToString:@"02"] || [code isEqualToString:@"07"]) {
        
        ret = @"移动";
    }
    if ([code isEqualToString:@"01"]|| [code isEqualToString:@"06"] )
    {
        ret = @"联通";
    }
    if ([code isEqualToString:@"03"]|| [code isEqualToString:@"05"] ) {  
        ret = @"电信";;  
    }
    if(ret == nil)
    {
        return @"";
    }
    return ret;
}

//sdkVersion：sdk版本号
NSString* cbSdkVersion()
{
    return CB_IOS_SDK_VERSION;
}

//idfa:  广告标示符
NSString* cbIdfa()
{
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if(idfa == nil)
    {
        return @"";
    }
    return idfa;
}

//openUdid:可以替代UDID
NSString* cbOpenUDid()
{
    NSString* openUDID = [OpenUDID value];
    if(openUDID == nil)
    {
        return @"";
    }
    return openUDID;
}

//os：设备操作系统
NSString* cbSysOS()
{
    //返回ios系统版本
    NSString *version =    [[UIDevice currentDevice] systemVersion];
    if(version == nil)
    {
        return @"";
    }
    return version;
}

//packageName：应用唯一标示
NSString* cbPackageName()
{
    return CB_IOS_SDK_PACKAGENAME;
}

//应用包 版本号
NSString* cbVersionCode()
{
    NSString *verson = [[[NSBundle mainBundle] infoDictionary] objectForKey: @"CFBundleShortVersionString"];
    if(verson == nil)
    {
        return @"";
    }
    return verson;
}


//latitude纬度
NSString* cbLatitudeStr()
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString* latitudeStr = [accountDefaults objectForKey:USERDEFAULTS_CB_LATITUDE_KEY];
    if(latitudeStr == nil)
    {
        return @"";
    }
    return latitudeStr;
}

//longitude经度
NSString* cbLongitudeStr()
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString* longitudeStr = [accountDefaults objectForKey:USERDEFAULTS_CB_LONGITUDE_KEY];
    if(longitudeStr == nil)
    {
        return @"";
    }
    return longitudeStr;
}

//定位省名称
NSString* cbProvinceStr()
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString* province = [accountDefaults objectForKey:USERDEFAULTS_CB_PROVINCE_KEY];
    if(province == nil)
    {
        return @"";
    }
    return province;
}

//定位市名称
NSString* cbCityStr()
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString* city = [accountDefaults objectForKey:USERDEFAULTS_CB_CITY_NAME_KEY];
    if(city == nil)
    {
        return @"";
    }
    return city;
}

//定位状态
BOOL cbLocationState()
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    BOOL state = [accountDefaults boolForKey:USERDEFAULTS_CB_GPS_STATE_KEY];
    return state;
}

//***********************************************************************************



