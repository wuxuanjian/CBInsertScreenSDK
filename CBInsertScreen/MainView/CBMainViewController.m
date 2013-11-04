//
//  CBMainViewController.m
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-30.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBMainViewController.h"
#import "InsertScreen.h"

@interface CBMainViewController ()
{
    SCREEN_DIRECTION direction;
    CBInsertScreen* insertScreen;
    CBScreenView *screenView;
}
@end

@implementation CBMainViewController
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
    
    
    
    
    
    
    //appId：后期分配的应用唯一标示码
    NSString* appid = cbAppId();
    //ua：user-agent
    NSString* userAgent = cbUserAgent();
    //mac地址获取
    NSString* macaddress = cbMacaddress();
    //sendCount：需要获取的广告数
    NSString* sendCount = cbSendCount();
    //adId：上一次获取的最后一个广告的ID
    NSString* adid = getCbAdId();
    //adType：广告类型
    NSString* adtype = cbAdType();
    
    //获取运营商
    NSString* checkCarrier = cbCheckCarrier();
    //sdkVersion：sdk版本号
    NSString* sdkVersion = cbSdkVersion();
    //idfa:  广告标示符
    NSString* idfa = cbIdfa();
    //openUdid:可以替代UDID
    NSString* openUdid = cbOpenUDid();
    //os：设备操作系统
    NSString* sysOs = cbSysOS();
    //packageName：应用唯一标示
    NSString* packageName = cbPackageName();
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)textButton:(id)sender
{
    insertScreen = [[CBInsertScreen alloc] init:direction];
    [insertScreen openInserScreenSDK];
//    [_gpsEngine startLocation:^(BOOL aState)
//     {
//         NSLog(@"LocationOk");
//     }];
}

- (IBAction)textButton1:(id)sender
{


    screenView = [[CBScreenView alloc] init];
    [screenView.imageArray addObject:@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=83ccb19ef91986184147e8847ed52c73/a1ec08fa513d269769393ca254fbb2fb4216d862.jpg"];
    [screenView.imageArray addObject:@"http://h.hiphotos.baidu.com/album/w%3D2048/sign=730e7fdf95eef01f4d141fc5d4c69825/94cad1c8a786c917b8bf9482c83d70cf3ac757c9.jpg"];
    [screenView.imageArray addObject:@"http://e.hiphotos.baidu.com/album/w%3D2048/sign=0eb3e73dd6ca7bcb7d7bc02f8a316963/9213b07eca806538706a7aed96dda144ac348248.jpg"];
    [screenView showImage];
    [self.view addSubview:screenView];
//    [[UIApplication sharedApplication].keyWindow addSubview:screenView];
}


-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;  // 可以修改为任何方向
}
-(BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight;
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
