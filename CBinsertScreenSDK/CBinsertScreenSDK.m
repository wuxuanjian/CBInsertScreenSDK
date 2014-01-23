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

+(CBinsertScreenSDK*) insertScreenSDKView:(UIView*)view adDeleage:(id)deleage
{
    if(inssdk == nil)
    {
        inssdk = [[CBinsertScreenSDK alloc] init];
        [inssdk createInsertScreenView:view adDeleage:deleage];
        [inssdk loadAdData]; //初始化sdk 获取广告数据
    }
    return inssdk;
}

+(BOOL) showInsertScreenSDK
{
    if(inssdk != nil)
    {
        return [inssdk showInsertScreen];
    }
    else
    {
        ADLog(@"请调用 insertScreenSDK 初始化 广告sdk");
    }
    return NO;
}

-(void) createInsertScreenView:(UIView*)view adDeleage:(id)deleage
{
    if (insertScreen == nil)
    {
        insertScreen = [[CBInsertScreen alloc] initDeleage:deleage fatheview:view];
    }
}

-(void) loadAdData
{
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
