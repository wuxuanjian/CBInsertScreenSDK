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
    
    
    CGAffineTransform rotationTransform;
    
}
@end


@implementation CBScreenView
@synthesize showBgView = _showBgView;
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

-(void) notificationCenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(detectShowOrientation)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:)
												 name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)detectShowOrientation
{
    if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft ||[UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
    {//
        DLog(@"videolist 横屏");
        screenDirection = SCREEN_DIRECTION_ACROSS;
    }
    else
    {//
        DLog(@"videoList 竖屏");
        screenDirection = SCREEN_DIRECTION_VERTICAL;
    }
//    [self setNeedsDisplay];
    [self setFrameRect:screenDirection];
}


-(void) initViewDate
{
    [self detectShowOrientation];
    _focus = 0;
    _imageArray = [[NSMutableArray alloc] initWithCapacity:3];
    self.frame = CGRectMake(0, 0, backgroundframeW(SCREEN_DIRECTION_VERTICAL), backgroundframeH(SCREEN_DIRECTION_VERTICAL));
    self.backgroundColor = BG_COLOR_CLEAR;
    [self createScrollView];
}

- (void)setFrameRect:(SCREEN_DIRECTION)direction
{
//    self.frame = CGRectMake(0, 0, backgroundframeW(screenDirection), backgroundframeH(screenDirection));
    
    CGFloat dateViewH = screenViewH(screenDirection);
    CGFloat dateViewW = screenViewW(screenDirection);
    CGFloat dateViewX = screenViewX(screenDirection);
    CGFloat dateViewY = screenViewY(screenDirection);
    _showBgView.frame = CGRectMake(dateViewX, dateViewY, dateViewW, dateViewH);
    
    _screenScrollView.frame = CGRectMake(0, 0, dateViewW, dateViewH);
    [_screenScrollView setContentSize:CGSizeMake(dateViewW*3, dateViewH)];
    
    _oneScrollImageView.frame = CGRectMake(0*dateViewW, 0, dateViewW, dateViewH);
    _twoScrollImageView.frame = CGRectMake(1*dateViewW, 0, dateViewW, dateViewH);
    _threeScrollImageView.frame = CGRectMake(2*dateViewW, 0, dateViewW, dateViewH);
    
    _screenPageControl.frame = CGRectMake(0, dateViewH, dateViewW, 30);
    [_screenScrollView setContentOffset:CGPointMake(dateViewW, 0.0)];
    _closeBgView.frame = CGRectMake(dateViewW - (dateViewW/10 + 3), 3, dateViewW/10, dateViewW/10) ;
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
    
    //_showBgView
    _showBgView = [[UIView alloc] initWithFrame:CGRectMake(dateViewX, dateViewY, dateViewW, dateViewH)];
    
    //scrollView
    _screenScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, dateViewW, dateViewH)];
    _screenScrollView.delegate = self;
    _screenScrollView.frame = CGRectMake(0, 0, dateViewW, dateViewH);
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
    [_showBgView addSubview:_screenScrollView];
    
    
    
    //pageControl
    _screenPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, dateViewH , dateViewW, 30)];
    _screenPageControl.backgroundColor = [UIColor clearColor];
    _screenPageControl.currentPage = _focus;
    _screenPageControl.enabled = NO;
    _screenPageControl.numberOfPages = 0;
    [_showBgView addSubview:_screenPageControl];
    [_screenScrollView setContentOffset:CGPointMake(dateViewW, 0.0)];
    [self closeButton];
    
    [self addSubview:_showBgView];
}

-(void) closeButton
{
//    CGFloat dateViewH = screenViewH(screenDirection);
    CGFloat dateViewW = screenViewW(screenDirection);
    _closeBgView = [[UIView alloc] initWithFrame:CGRectMake(dateViewW - (dateViewW/10 + 3), 3, dateViewW/10, dateViewW/10)];
    UIButton* closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [closeBut setTitle:@"X" forState:UIControlStateNormal];
    [closeBut setBackgroundImage:[UIImage imageNamed:@"ad_dtop_closebtn"] forState:UIControlStateNormal];
    [closeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    closeBut.frame = CGRectMake(0, 0, dateViewW/10, dateViewW/10);
    [closeBut addTarget:self action:@selector(closeButtonSelector) forControlEvents:UIControlEventTouchDown];
    
    [_closeBgView addSubview:closeBut];
    [_showBgView addSubview:_closeBgView];
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
        CBAdvertisementModel* adModel = [_imageArray objectAtIndex:[self oneImageItem]];
        NSURL *url = [NSURL URLWithString:adModel.pic3URL];
        [_oneScrollImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ad_sc_circle"]];
    }
    
    if([_imageArray count] > [self twoImageItem])
    {
        CBAdvertisementModel* adModel = [_imageArray objectAtIndex:[self twoImageItem]];
        NSURL *url = [NSURL URLWithString:adModel.pic3URL];
        [_twoScrollImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ad_sc_circle"]];
    }
    if([_imageArray count] > [self threeImageItem])
    {
        CBAdvertisementModel* adModel = [_imageArray objectAtIndex:[self threeImageItem]];
        NSURL *url = [NSURL URLWithString:adModel.pic3URL];
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
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(detectShowOrientation)
//                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:)
//												 name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeFromSuperview];
}

-(void)adDownloadSelector
{
    if(_screenViewDeleage && [_screenViewDeleage respondsToSelector:@selector(adDownSelector:)])
    {
        CBAdvertisementModel* adModel = [_imageArray objectAtIndex:_focus];
        [_screenViewDeleage adDownSelector:adModel];
    }
}






#pragma mark -
#pragma mark 屏幕旋转

#define RADIANS(degrees) ((degrees * (float)M_PI) / 180.0f)

- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    DLog(@"device 屏幕旋转");
	if (!self.superview)
    {
		return;
	}
	
	if ([self.superview isKindOfClass:[UIWindow class]])
    {
		[self setTransformForCurrentOrientation:YES];
	} else
    {
		self.bounds = self.superview.bounds;
		[self setNeedsDisplay];
	}
}

- (void)setTransformForCurrentOrientation:(BOOL)animated
{
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	NSInteger degrees = 0;
	
	// Stay in sync with the superview
	if (self.superview)
    {
		self.bounds = self.superview.bounds;
		[self setNeedsDisplay];
	}
	
	if (UIInterfaceOrientationIsLandscape(orientation))
    {
		if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            degrees = -90;
        }
		else
        {
            degrees = 90;
        }
		// Window coordinates differ!
		self.bounds = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.width);
	}
    else
    {
		if (orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            degrees = 180;
        }
		else
        {
            degrees = 0;
        }
	}
	
	rotationTransform = CGAffineTransformMakeRotation(RADIANS(degrees));
    
	if (animated)
    {
		[UIView beginAnimations:nil context:nil];
	}
	[self setTransform:rotationTransform];
	if (animated)
    {
		[UIView commitAnimations];
	}
}






@end
