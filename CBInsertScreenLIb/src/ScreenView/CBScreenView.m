//
//  CBScreenView.m
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-30.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBScreenView.h"
#import "sys/utsname.h"
#import "UIImageView+WebCache.h"

@interface CBScreenView()
{
    SCREEN_DIRECTION screenDirection;  //屏幕横竖
}
@end


@implementation CBScreenView
@synthesize screenScrollView = _screenScrollView;
@synthesize screenPageControl = _screenPageControl;
@synthesize imageArray = _imageArray;
@synthesize oneScrollImageView = _oneScrollImageView;
@synthesize twoScrollImageView = _twoScrollImageView;
@synthesize threeScrollImageView = _threeScrollImageView;
@synthesize focus = _focus;
@synthesize closeBgView = _closeBgView;
@synthesize adButton = _adButton;
@synthesize screenViewDeleage = _screenViewDeleage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViewDate];
    }
    return self;
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 10, 10)];
    if (self)
    {
        [self initViewDate];
    }
    return self;
}

-(void) initViewDate
{
    screenDirection = SCREEN_DIRECTION_VERTICAL;
    _focus = 0;
    _imageArray = [[NSMutableArray alloc] initWithCapacity:3];
    self.frame = CGRectMake(0, 0, backgroundframeW(screenDirection), backgroundframeH(screenDirection));
    self.backgroundColor = BG_COLOR_CLEAR;
    [self createScrollView];
}

- (void)setFrameRect:(SCREEN_DIRECTION)direction
{
    [self setNeedsDisplay];
    screenDirection = direction;
//    [_screenScrollView removeFromSuperview];
    self.frame = CGRectMake(0, 0, backgroundframeW(screenDirection), backgroundframeH(screenDirection));
    
    CGFloat dateViewH = screenViewH(screenDirection);
    CGFloat dateViewW = screenViewW(screenDirection);
    CGFloat dateViewX = screenViewX(screenDirection);
    CGFloat dateViewY = screenViewY(screenDirection);
    _screenScrollView.frame = CGRectMake(dateViewX, dateViewY, dateViewW, dateViewH);
    [_screenScrollView setContentSize:CGSizeMake(dateViewW*3, dateViewH)];
    
    _oneScrollImageView.frame = CGRectMake(0*dateViewW, 0, dateViewW, dateViewH);
    _twoScrollImageView.frame = CGRectMake(1*dateViewW, 0, dateViewW, dateViewH);
    _threeScrollImageView.frame = CGRectMake(2*dateViewW, 0, dateViewW, dateViewH);
    
    _screenPageControl.frame = CGRectMake(dateViewX,(dateViewY + dateViewH - 30), dateViewW, 30);
    [_screenScrollView setContentOffset:CGPointMake(dateViewW, 0.0)];
    _closeBgView.frame = CGRectMake(dateViewX + dateViewW - 50, dateViewY, 50, 50) ;
    _adButton.frame = CGRectMake(1*dateViewW, 0, dateViewW, dateViewH);
}

-(void) createScrollView
{
    CGFloat dateViewH = screenViewH(screenDirection);
    CGFloat dateViewW = screenViewW(screenDirection);
    CGFloat dateViewX = screenViewX(screenDirection);
    CGFloat dateViewY = screenViewY(screenDirection);
    
    //图片
    _oneScrollImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0*dateViewW, 0, dateViewW, dateViewH)];
//    _oneScrollImageView.backgroundColor = [UIColor brownColor];
    
    _twoScrollImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1*dateViewW, 0, dateViewW, dateViewH)];
//    _twoScrollImageView.backgroundColor = [UIColor greenColor];
    
    _threeScrollImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2*dateViewW, 0,  dateViewW, dateViewH)];
//    _threeScrollImageView.backgroundColor = [UIColor blueColor];
    
    //scrollView
    _screenScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(dateViewX, dateViewY, dateViewW, dateViewH)];
    _screenScrollView.delegate = self;
    _screenScrollView.frame = CGRectMake(dateViewX, dateViewY, dateViewW, dateViewH);
	[_screenScrollView setCanCancelContentTouches:NO];
	_screenScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	_screenScrollView.clipsToBounds = YES;
	_screenScrollView.scrollEnabled = YES;
	_screenScrollView.pagingEnabled = YES;
    _screenScrollView.bounces = NO;
    [_screenScrollView setShowsHorizontalScrollIndicator:NO];
    [_screenScrollView setContentSize:CGSizeMake(dateViewW*3, dateViewH)];
    
    [_screenScrollView addSubview:_oneScrollImageView];
    [_screenScrollView addSubview:_twoScrollImageView];
    [_screenScrollView addSubview:_threeScrollImageView];
    
    _adButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _adButton.frame = CGRectMake(1*dateViewW, 0, dateViewW, dateViewH);
    [_adButton addTarget:self action:@selector(adDownloadSelector) forControlEvents:UIControlEventTouchDown];
//    _adButton.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    [_screenScrollView addSubview:_adButton];
    [self addSubview:_screenScrollView];
    
    
    
    //pageControl
    _screenPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(dateViewX,(dateViewY + dateViewH - 30), dateViewW, 30)];
    _screenPageControl.backgroundColor = [UIColor clearColor];
    _screenPageControl.currentPage = _focus;
    _screenPageControl.enabled = NO;
    _screenPageControl.numberOfPages = 0;
    [self addSubview:_screenPageControl];
    [_screenScrollView setContentOffset:CGPointMake(dateViewW, 0.0)];
    [self closeButton];
}

-(void) closeButton
{
//    CGFloat dateViewH = screenViewH(screenDirection);
    CGFloat dateViewW = screenViewW(screenDirection);
    CGFloat dateViewX = screenViewX(screenDirection);
    CGFloat dateViewY = screenViewY(screenDirection);
    _closeBgView = [[UIView alloc] initWithFrame:CGRectMake(dateViewX + dateViewW - 50, dateViewY, 50, 50)];
    UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [closeBut setTitle:@"X" forState:UIControlStateNormal];
    [closeBut setBackgroundImage:[UIImage imageNamed:@"ad_dtop_closebtn"] forState:UIControlStateNormal];
    [closeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    closeBut.frame = CGRectMake(0, 0, 50, 50);
    [closeBut addTarget:self action:@selector(closeButtonSelector) forControlEvents:UIControlEventTouchDown];
    
    [_closeBgView addSubview:closeBut];
    [self addSubview:_closeBgView];
}




-(NSInteger) oneImageItem
{
    NSInteger oneItem = _focus - 1;
    if(oneItem < 0)
    {
        if ([_imageArray count] > 0)
        {
            oneItem = [_imageArray count] - 1;
        }
        else
        {
            oneItem = 0;
        }
    }
    return oneItem;
}

-(NSInteger) twoImageItem
{
    return _focus;
}

-(NSInteger) threeImageItem
{
    NSInteger item = _focus + 1;
    if ([_imageArray count] > 0)
    {
        if(item > ([_imageArray count] - 1))
        {
            item = 0;
        }
    }
    else
    {
        item = 0;
    }

    return item;
}

-(void) focusAdd
{
    _focus++;
    if ([_imageArray count] > 0)
    {
        if(_focus > ([_imageArray count] - 1))
        {
            _focus = 0;
        }
    }
    else
    {
        _focus = 0;
    }

}

-(void) focusApp
{
    _focus--;
    if(_focus < 0)
    {
        if ([_imageArray count] > 0)
        {
            _focus = [_imageArray count] - 1;
        }
        else
        {
            _focus = 0;
        }
    }
}

-(void) showImage
{
    if([_imageArray count] > [self oneImageItem])
    {
        NSString* urlStr = [_imageArray objectAtIndex:[self oneImageItem]];
        NSURL *url = [NSURL URLWithString:urlStr];
        [_oneScrollImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ad_sc_circle"]];
    }
    
    if([_imageArray count] > [self twoImageItem])
    {
        NSString* urlStr = [_imageArray objectAtIndex:[self twoImageItem]];
        NSURL *url = [NSURL URLWithString:urlStr];
        [_twoScrollImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ad_sc_circle"]];
    }
    if([_imageArray count] > [self threeImageItem])
    {
        NSString* urlStr = [_imageArray objectAtIndex:[self threeImageItem]];
        NSURL *url = [NSURL URLWithString:urlStr];
        [_threeScrollImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ad_sc_circle"]];
    }
    
//    if([_imageArray count] > [self oneImageItem])
//    {
//        NSString* urlStr = [_imageArray objectAtIndex:[self oneImageItem]];
//        _oneScrollImageView.image = [UIImage imageNamed:urlStr];
//    }
//    
//    if([_imageArray count] > [self twoImageItem])
//    {
//        NSString* urlStr = [_imageArray objectAtIndex:[self twoImageItem]];
//        _twoScrollImageView.image = [UIImage imageNamed:urlStr];
//    }
//    if([_imageArray count] > [self threeImageItem])
//    {
//        NSString* urlStr = [_imageArray objectAtIndex:[self threeImageItem]];
//        _threeScrollImageView.image = [UIImage imageNamed:urlStr];
//    }
//    
    if([_imageArray count] > 0)
    {
        _screenPageControl.currentPage = _focus;
        _screenPageControl.numberOfPages = [_imageArray count];
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)crollView
{
    CGFloat dateViewW = screenViewW(screenDirection);
    if (_screenScrollView.contentOffset.x > (dateViewW + 10))
    {
        [self focusAdd];
        [self showImage];
    }
    else if (_screenScrollView.contentOffset.x < (dateViewW - 10))
    {
        [self focusApp];
        [self showImage];
    }
    else
    {
		//没有换页，则主imageview仍然为之前的图片
	}
    [_screenScrollView setContentOffset:CGPointMake(dateViewW, 0.0)];
    
}

-(void)closeButtonSelector
{
    [self removeFromSuperview];
}

-(void)adDownloadSelector
{
    if(_screenViewDeleage && [_screenViewDeleage respondsToSelector:@selector(adDownSelector:)])
    {
        [_screenViewDeleage adDownSelector:nil];
    }
}


@end
