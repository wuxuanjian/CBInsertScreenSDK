//
//  CBMainViewController.m
//  CBiPhoneDome
//
//  Created by EinFachMann on 13-10-30.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBMainViewController.h"
#import "InsertScreen.h"


@interface CBMainViewController ()

@end

@implementation CBMainViewController

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
    
    CBInsertScreen* ins = [[CBInsertScreen alloc] init:SCREEN_DIRECTION_VERTICAL];
    [ins openInserScreenSDK];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
