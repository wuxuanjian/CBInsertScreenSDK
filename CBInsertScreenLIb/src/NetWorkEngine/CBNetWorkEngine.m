//
//  CBNetWorkEngine.m
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-30.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBNetWorkEngine.h"

@implementation CBNetWorkEngine

-(MKNetworkOperation*) postDataToServer:(CBNetWorkComplete)completeblock netWorkError:(CBNetWorkError)errorblock
{
    //appId：后期分配的应用唯一标示码
    NSString* appid = cbAppId();
    //ua：user-agent
    NSString* userAgent = cbUserAgent();
    //mac地址获取
    NSString* macaddress = cbMacaddress();
    //sendCount：需要获取的广告数
    NSString* sendCount = cbSendCount();
    //adId：上一次获取的最后一个广告的ID
    NSString* adid = @"";
//    NSString* adid = getCbAdId();
    //adType：广告类型
    NSString* adtype = cbAdType();
    
    //获取运营商
    NSString* checkCarrier = cbCheckCarrier();
    //sdkVersion：sdk版本号
    NSString* sdkVersion = cbSdkVersion();
    //idfa:  广告标示符
    NSString* idfa = cbIdfa();
    //openUdid:可以替代UDID
    NSString* openUdid = cbOpenUDid();
    //os：设备操作系统
    NSString* sysOs = cbSysOS();
    //packageName：应用唯一标示
    NSString* packageName = cbPackageName();
    //应用包 版本号
    NSString* versioncod = cbVersionCode();
    
    //latitude纬度
    NSString* latitude = cbLatitudeStr();
    //longitude经度
    NSString* longitude = cbLongitudeStr();
    //定位省名称
    NSString* province = cbProvinceStr();
    //定位市名称
    NSString* city = cbCityStr();
    
//    http://push.hi6yx.com:8090/androidService/advertisingIos/findAdverByClient.h?
//    appId=09090200
//    &uuid=865864011308056
//    &ua=ZTE%20V970
//    &os=4.0.4
//    &safe=1
//    &versionCode=1.0
//    &packageName=com.test.up_soft
//    &adType=chaping
//    &sdkVersion=1.1.4
//    &province=%E5%8C%97%E4%BA%AC
//    &city=%E5%8C%97%E4%BA%AC
//    &longitude=116.365744
//    &latitude=39.952118
//    &sendCount=9
//    &adId=
    
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                appid,@"appId",
                                openUdid,@"uuid",
                                idfa,@"idfa",              // 
                                userAgent,@"ua",
                                macaddress,@"mac",         //
                                checkCarrier,@"carrier",   //
                                sysOs,@"os",
                                versioncod,@"versionCode",
                                packageName,@"packageName",
                                adtype,@"adType",
                                sdkVersion,@"sdkVersion", 
                                province,@"province",
                                city,@"city",
                                longitude,@"longitude",
                                latitude,@"latitude",
                                sendCount,@"sendCount",
                                adid,@"adId",
                                nil];
    MKNetworkOperation *op = [self operationWithPath:@"androidService/advertisingIos/findAdverByClient.h"
                                              params:dic
                                          httpMethod:@"POST"];
    //[op setUsername:@"bobs@thga.me" password:@"12345678"];
    
    [op onCompletion:^(MKNetworkOperation *operation)
    {
        NSString* responseStr = operation.responseString;
        DLog(@"%@", responseStr);
        completeblock(responseStr);
    }
    onError:^(NSError *error)
    {
        DLog(@"%@", error);
        errorblock(error);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}

-(MKNetworkOperation*) postInstallation:(CBAdvertisementModel*)adInst
{
//    http://push.hi6yx.com:8090/androidService/clientStatusVisitIos/add.h?
//    uuid=01010101
//    &appId=01010101
//    &action=push
//    &adId=0006
//    &adType=push
    //appId：后期分配的应用唯一标示码
    NSString* appid = cbAppId();
    //openUdid:可以替代UDID
    NSString* openUdid = cbOpenUDid();
    //idfa:  广告标示符
    NSString* idfa = cbIdfa();
    
    //adType：广告类型
    NSString* adtype = cbAdType();
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                appid,@"appId",
                                openUdid,@"uuid",
                                idfa,@"idfa",
                                @"download",@"action",   //下载事件
                                adInst.adId,@"adId",
                                adtype,@"adType",
                                nil];
    MKNetworkOperation *op = [self operationWithPath:@"androidService/clientStatusVisitIos/add.h"
                                              params:dic
                                          httpMethod:@"POST"];
    //[op setUsername:@"bobs@thga.me" password:@"12345678"];
    
    [op onCompletion:^(MKNetworkOperation *operation)
     {
         NSString* responseStr = operation.responseString;
         DLog(@"%@", responseStr);
     }
             onError:^(NSError *error)
     {
         DLog(@"%@", error);
     }];
    [self enqueueOperation:op];
    
    return op;

    
}

@end
