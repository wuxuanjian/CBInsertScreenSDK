//
//  CBInsert.h
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-31.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#ifndef CBInsertScreen_CBInsert_h
#define CBInsertScreen_CBInsert_h

//屏幕方向
typedef enum
{
    SCREEN_DIRECTION_VERTICAL = 1111, //竖向
    SCREEN_DIRECTION_ACROSS, //横向
}SCREEN_DIRECTION;

//NSUserDefaults存储key
#define USERDEFAULTS_CB_LAST_ADID_KEY @"USERDEFAULTS_SDK_CB_LAST_ADID"       //adId：上一次获取的最后一个广告的ID
#define USERDEFAULTS_CB_GPS_STATE_KEY @"USERDEFAULTS_SDK_CB_GPS_STATE"       //定位状态
#define USERDEFAULTS_CB_LONGITUDE_KEY @"USERDEFAULTS_SDK_CB_LONGITUDE"       //longitude 经度
#define USERDEFAULTS_CB_LATITUDE_KEY  @"USERDEFAULTS_SDK_CB_LATITUDE"       //latitude 纬度
#define USERDEFAULTS_CB_CITY_NAME_KEY @"USERDEFAULTS_SDK_CB_CITY_NAME"       //城市名city
#define USERDEFAULTS_CB_PROVINCE_KEY  @"USERDEFAULTS_SDK_CB_PROVINCE"        //省份名


//服务端访问URL
#define NET_WORK_SERVER_URL @"push.hi6yx.com:8090" //测试地址

#endif
