//
//  CBScreenView.h
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-30.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsertScreen.h"

@protocol SCrreenViewDeleage <NSObject>

- (void)adDownSelector:(CBAdvertisementModel*)model;

@end


#define BG_COLOR_CLEAR   [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.7]    //

@interface CBScreenView : UIView <UIScrollViewDelegate>

@property (nonatomic,strong) UIView*         showBgView;
@property (nonatomic,strong) UIScrollView*   screenScrollView; //插屏view
@property (nonatomic,strong) UIView*         closeBgView;
@property (nonatomic,strong) UIPageControl*  screenPageControl;

@property (nonatomic,strong) NSMutableArray* imageArray;

@property (nonatomic,strong)  UIImageView *  oneScrollImageView;
@property (nonatomic,strong)  UIImageView *  twoScrollImageView;
@property (nonatomic,strong)  UIImageView *  threeScrollImageView;

@property (nonatomic,strong)  UIButton   *  adButton;

@property (nonatomic,readwrite)  NSInteger     focus; //焦点
@property (nonatomic,assign)id<SCrreenViewDeleage> screenViewDeleage;

-(void) notificationCenter;
-(void) showImage;
- (void)setFrameRect:(SCREEN_DIRECTION)direction;


- (void)deviceOrientationDidChange:(NSNotification *)notification;

@end
