//
//  CBDomeViewController.h
//  CBInsertScreenSDKDome
//
//  Created by EinFachMann on 13-11-6.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBinsertScreenSDK.h"

@class CBGPSEngine;
@interface CBDomeViewController : UIViewController <CBInsertScreenDeleage>
@property (nonatomic, strong) CBGPSEngine* gpsEngine;
- (IBAction)textButton:(id)sender;
- (IBAction)textButton1:(id)sender;


@end
