//
//  CBInsertScreen.h
//  CBInsertScreen
//
//  Created by EinFachMann on 13-11-1.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InsertScreen.h"
#import "CBinsertScreenSDK.h"

@interface CBInsertScreen : NSObject

- (id)initDeleage:(id)deleage fatheview:(UIView*)view;

/*
 * 获取广告数据
 */
-(void) loadAdData;

//点击广告返回
-(void) adDownSelector:(CBAdvertisementModel*)adItem;

//展示sdk
-(BOOL) showScreenView;

@end
