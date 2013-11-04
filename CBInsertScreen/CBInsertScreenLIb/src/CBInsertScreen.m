//
//  CBInsertScreen.m
//  CBInsertScreen
//
//  Created by EinFachMann on 13-11-1.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBInsertScreen.h"


@interface CBInsertScreen()
{
    CBGPSEngine*  _gpsEngine;      //定位引擎
    CBScreenView* _screenView;    //view
    SCREEN_DIRECTION _screenDirection;  //屏幕横竖
}
@end

@implementation CBInsertScreen

- (id)init:(SCREEN_DIRECTION)direction
{
    self = [super init];
    if (self)
    {
        _screenDirection = direction;
        _gpsEngine = nil;
        _screenView = nil;
    }
    return self;
}

-(void) openInserScreenSDK
{
    _gpsEngine = [[CBGPSEngine alloc] init];
    _screenView = [[CBScreenView alloc] init];
    [self gpsLocation];
    
}

/*设置当前屏幕的方向 是横屏 还是竖屏
 *direction   屏幕方向
 */
-(void) setScreenSirection:(SCREEN_DIRECTION)direction
{
    _screenDirection = direction;
    if(_screenView != nil)
    {
        [_screenView setFrameRect:_screenDirection];
    }
}

-(void) gpsLocation
{
    [_gpsEngine startLocation:^(BOOL aState)
     {
         NSLog(@"LocationOk");
         [self showScreenView];
     }];
}

-(void) showScreenView
{
    _screenView = [[CBScreenView alloc] init];
    [_screenView.imageArray addObject:@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=83ccb19ef91986184147e8847ed52c73/a1ec08fa513d269769393ca254fbb2fb4216d862.jpg"];
    [_screenView.imageArray addObject:@"http://h.hiphotos.baidu.com/album/w%3D2048/sign=730e7fdf95eef01f4d141fc5d4c69825/94cad1c8a786c917b8bf9482c83d70cf3ac757c9.jpg"];
    [_screenView.imageArray addObject:@"http://e.hiphotos.baidu.com/album/w%3D2048/sign=0eb3e73dd6ca7bcb7d7bc02f8a316963/9213b07eca806538706a7aed96dda144ac348248.jpg"];
    [_screenView showImage];
    [_screenView setFrameRect:_screenDirection];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_screenView];
}




@end
