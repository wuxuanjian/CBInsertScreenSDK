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

/*初始化函数
 *direction   屏幕方向
 */
- (id)init:(SCREEN_DIRECTION)direction;

/*
 * 打开sdk
 */
-(void) openInserScreenSDK;

/*设置当前屏幕的方向 是横屏 还是竖屏
 *direction   屏幕方向 
 */
-(void) setScreenSirection:(SCREEN_DIRECTION)direction;

@end
