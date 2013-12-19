//
//  CBinsertScreenSDK.m
//  CBinsertScreenSDK
//
//  Created by EinFachMann on 13-11-8.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBinsertScreenSDK.h"
#import "InsertScreen.h"

static CBinsertScreenSDK*  inssdk = nil;

@interface CBinsertScreenSDK()
{
    CBInsertScreen* insertScreen;
}
@end

@implementation CBinsertScreenSDK

+(CBinsertScreenSDK*) insertScreenSDK
{
    if(inssdk == nil)
    {
        inssdk = [[CBinsertScreenSDK alloc] init];
        [inssdk loadAdData]; //初始化sdk 获取广告数据
    }
    return inssdk;
}

+(BOOL) showInsertScreenSDK
{
    [CBinsertScreenSDK insertScreenSDK];
    return [inssdk showInsertScreen];
}

-(void) loadAdData
{
    if (insertScreen == nil)
    {
        insertScreen = [[CBInsertScreen alloc] init];
    }
    [insertScreen loadAdData];
}

-(BOOL) showInsertScreen
{
    if(insertScreen && insertScreen != nil)
    {
        return [insertScreen showScreenView];
    }
    return NO;
    
}

@end
