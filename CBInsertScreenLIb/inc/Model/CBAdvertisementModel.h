//
//  CBAdvertisementModel.h
//  CBInsertScreen
//
//  Created by EinFachMann on 13-11-4.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "InsertScreen.h"
#import "SvIncrementallyImage.h"
//    [{"position":"left",
//        "anonymous":"yes",
//        "appName":"sohu游戏中心",
//        "isMorrowStart":"no",
//        "packageName":"",
//        "clean":"no",
//        "adId":"0050",
//        "clickText":"",
//        "appURL":"https://itunes.apple.com/cn/app/sou-hu-ying-yong-zhong-xin/id495099169?mt=8",
//        "powerclick":"yes",
//        "pic3URL":"http://myimages.qiniudn.com/1382602663849.jpg",
//        "appDesc1":""}]

@interface CBAdvertisementModel : NSObject

@property (nonatomic,strong) NSString* position;  //位置
@property (nonatomic,strong) NSString* anonymous; //
@property (nonatomic,strong) NSString* appName;    //应用名称
@property (nonatomic,strong) NSString* isMorrowStart;
@property (nonatomic,strong) NSString* packageName;
@property (nonatomic,strong) NSString* clean;
@property (nonatomic,strong) NSString* adId;   //广告Id
@property (nonatomic,strong) NSString* clickText;
@property (nonatomic,strong) NSString* appURL;
@property (nonatomic,strong) NSString* powerclick;
@property (nonatomic,strong) NSString* pic3URL;
@property (nonatomic,strong) NSString* appDesc1;
@property (nonatomic,strong) SvIncrementallyImage* svIncrementallyImg;

@end
