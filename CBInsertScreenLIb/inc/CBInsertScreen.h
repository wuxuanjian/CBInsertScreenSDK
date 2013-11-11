//
//  CBInsertScreen.h
//  CBInsertScreen
//
//  Created by EinFachMann on 13-11-1.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InsertScreen.h"

@interface CBInsertScreen : NSObject


- (id)init;

/*
 * 打开sdk
 */
-(void) openInserScreenSDK;

//点击广告返回
-(void) adDownSelector:(CBAdvertisementModel*)adItem;

@end
