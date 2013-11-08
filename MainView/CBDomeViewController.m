//
//  CBDomeViewController.m
//  CBInsertScreenSDKDome
//
//  Created by EinFachMann on 13-11-6.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBDomeViewController.h"
#import "InsertScreen.h"

@interface CBDomeViewController ()
{
    SCREEN_DIRECTION direction;
    CBInsertScreen* insertScreen;
    CBScreenView *screenView;
}
@end

@implementation CBDomeViewController

@synthesize gpsEngine = _gpsEngine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        screenView = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _gpsEngine = [[CBGPSEngine alloc] init];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)textButton:(id)sender
{
    if (insertScreen == nil)
    {
        insertScreen = [[CBInsertScreen alloc] init:direction];
    }
    
    [insertScreen openInserScreenSDK];
    //    [_gpsEngine startLocation:^(BOOL aState)
    //     {
    //         NSLog(@"LocationOk");
    //     }];
}

- (IBAction)textButton1:(id)sender
{
    
    
//    screenView = [[CBScreenView alloc] init];
//    //    [screenView.imageArray addObject:@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=83ccb19ef91986184147e8847ed52c73/a1ec08fa513d269769393ca254fbb2fb4216d862.jpg"];
//    //    [screenView.imageArray addObject:@"http://h.hiphotos.baidu.com/album/w%3D2048/sign=730e7fdf95eef01f4d141fc5d4c69825/94cad1c8a786c917b8bf9482c83d70cf3ac757c9.jpg"];
//    //    [screenView.imageArray addObject:@"http://e.hiphotos.baidu.com/album/w%3D2048/sign=0eb3e73dd6ca7bcb7d7bc02f8a316963/9213b07eca806538706a7aed96dda144ac348248.jpg"];
//    
//    [screenView.imageArray addObject:@"500-500_1.jpg"];
//    [screenView.imageArray addObject:@"500-500_2.jpg"];
//    [screenView.imageArray addObject:@"500-500_3.jpg"];
//    
//    [screenView showImage];
//    [self.view addSubview:screenView];
    //    [[UIApplication sharedApplication].keyWindow addSubview:screenView];
    
    CBNetWorkEngine* networkEng = [[CBNetWorkEngine alloc] initWithHostName:NET_WORK_SERVER_URL customHeaderFields:nil];
    [networkEng postDataToServer:^(NSString *responseString)
     {
    
     }
    netWorkError:^(NSError *err)
     {
         
     }];
    
}


-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;  // 可以修改为任何方向
}
-(BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{    
    if (UIInterfaceOrientationIsPortrait(interfaceOrientation))
    {
        direction = SCREEN_DIRECTION_VERTICAL;
        if(insertScreen != nil)
        {
            [insertScreen setScreenSirection:direction];
        }
        if(screenView != nil)
        {
            [screenView setFrameRect:SCREEN_DIRECTION_VERTICAL];
        }
    }
    else
    {
        direction = SCREEN_DIRECTION_ACROSS;
        if(insertScreen != nil)
        {
            [insertScreen setScreenSirection:direction];
        }
        if(screenView != nil)
        {
            [screenView setFrameRect:SCREEN_DIRECTION_ACROSS];
        }
    }
    
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval) duration
{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        direction = SCREEN_DIRECTION_VERTICAL;
        if(insertScreen != nil)
        {
            [insertScreen setScreenSirection:direction];
        }
        if(screenView != nil)
        {
            [screenView setFrameRect:SCREEN_DIRECTION_VERTICAL];
        }
    }
    else
    {
        direction = SCREEN_DIRECTION_ACROSS;
        if(insertScreen != nil)
        {
            [insertScreen setScreenSirection:direction];
        }
        if(screenView != nil)
        {
            [screenView setFrameRect:SCREEN_DIRECTION_ACROSS];
        }
    }
}


@end
