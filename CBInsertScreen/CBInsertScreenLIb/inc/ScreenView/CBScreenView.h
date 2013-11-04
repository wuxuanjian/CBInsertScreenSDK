//
//  CBScreenView.h
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-30.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsertScreen.h"

#define BG_COLOR_CLEAR   [UIColor clearColor]    //完全透明

@interface CBScreenView : UIView <UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView*   screenScrollView; //插屏view
@property (nonatomic,strong) UIView*         closeBgView;
@property (nonatomic,strong) UIPageControl*  screenPageControl;

@property (nonatomic,strong) NSMutableArray* imageArray;

@property (nonatomic,strong)  UIImageView *  oneScrollImageView;
@property (nonatomic,strong)  UIImageView *  twoScrollImageView;
@property (nonatomic,strong)  UIImageView *  threeScrollImageView;

@property (nonatomic,readwrite)  NSInteger     focus; //焦点

-(void) showImage;
- (void)setFrameRect:(SCREEN_DIRECTION)direction;

@end
