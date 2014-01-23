//
//  CBDomeViewController.m
//  CBInsertScreenSDKDome
//
//  Created by EinFachMann on 13-11-6.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBDomeViewController.h"


@interface CBDomeViewController ()
{
}
@end

@implementation CBDomeViewController

@synthesize gpsEngine = _gpsEngine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [CBinsertScreenSDK insertScreenSDKView:self.view adDeleage:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)textButton:(id)sender
{
    [CBinsertScreenSDK showInsertScreenSDK];
}

- (IBAction)textButton1:(id)sender
{
    
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

    
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval) duration
{

}

//获取广告数据
-(void) loadDateInsertScreenAD
{
    NSLog(@"获取广告数据");
}

//显示广告
-(void) showInsertScreenAD
{
    NSLog(@"显示广告");
}

//点击广告
-(void) clickInsertScreenAD
{
    NSLog(@"点击广告");
}

//关闭广告
-(void) closeInsertScreenAD
{
    NSLog(@"关闭广告");
}




@end
