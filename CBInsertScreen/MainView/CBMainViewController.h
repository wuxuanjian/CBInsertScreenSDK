//
//  CBMainViewController.h
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-30.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBGPSEngine;
@interface CBMainViewController : UIViewController

@property (nonatomic, strong) CBGPSEngine* gpsEngine;

- (IBAction)textButton:(id)sender;
- (IBAction)textButton1:(id)sender;

@end
