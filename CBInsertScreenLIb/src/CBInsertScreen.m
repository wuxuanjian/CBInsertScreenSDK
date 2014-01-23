//
//  CBInsertScreen.m
//  CBInsertScreen
//
//  Created by EinFachMann on 13-11-1.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBInsertScreen.h"

@interface CBInsertScreen() <SCrreenViewDeleage>
{
    
}
@property (nonatomic,strong) CBGPSEngine*  gpsEngine;      //定位引擎
@property (nonatomic,strong) CBScreenView* screenView;    //view
@property (nonatomic,strong) CBNetWorkEngine* networkEng; //网络
@property (nonatomic,strong) NSMutableArray* adArray;

@property (nonatomic,assign) id<CBInsertScreenDeleage> addeleage;
@property (nonatomic,strong) UIView   *fatherView;

@end

@implementation CBInsertScreen
@synthesize  gpsEngine = _gpsEngine;      //定位引擎
@synthesize screenView = _screenView;    //view
@synthesize networkEng = _networkEng; //网络
@synthesize adArray = _adArray; //返回的广告数组广告
@synthesize addeleage = _addeleage;
@synthesize fatherView = _fatherView;

-(id)initDeleage:(id)deleage fatheview:(UIView*)view
{
    self = [super init];
    if (self)
    {
        _addeleage = deleage;
        _fatherView = view;
        _gpsEngine = [[CBGPSEngine alloc] init];
        _screenView = [[CBScreenView alloc] init];
        [self gpsLocation];
        _adArray = [[NSMutableArray alloc] initWithCapacity:3];
        _networkEng = [[CBNetWorkEngine alloc] initWithHostName:NET_WORK_SERVER_URL customHeaderFields:nil];
    }
    return self;
}

-(void) loadAdData
{
    setCbAdId(@"");
    [self adToObtain:YES];
}


-(void) gpsLocation
{
    [_gpsEngine startLocation:^(BOOL aState)
     {
         ADLog(@"LocationOk");
     }];
}

-(BOOL) showScreenView
{
    if(_adArray == nil || [_adArray count] == 0)
    {
        return NO;
    }
    
    if(_screenView == nil)
    {
        _screenView = [[CBScreenView alloc] init];
    }
    [_screenView notificationCenter];
    [_screenView.imageArray removeAllObjects];
    [_screenView.imageArray addObjectsFromArray:_adArray];
     _screenView.screenViewDeleage = self;
//    [_screenView.imageArray addObject:@"500-500_1.jpg"];
//    [_screenView.imageArray addObject:@"500-500_2.jpg"];
//    [_screenView.imageArray addObject:@"500-500_3.jpg"];
    [_screenView showImage];
//    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_screenView];
    
    if(_fatherView)
    {
        [_fatherView addSubview:_screenView];
    }
    else
    {
        [[UIApplication sharedApplication].keyWindow addSubview:_screenView];
    }
    
    
    [_screenView deviceOrientationDidChange:nil];
    [_screenView detectShowOrientation];
    
    [self adToObtain:NO];
    if(_addeleage && [_addeleage respondsToSelector:@selector(showInsertScreenAD)])
    {
        [_addeleage showInsertScreenAD];
    }
    return YES;
}

//广告获取
-(void) adToObtain:(BOOL)theFirst
{
    [_networkEng postDataToServer:^(NSString *responseString)
    {
        
        [self adToobtainComplete:responseString];
    }
    netWorkError:^(NSError *err)
    {
        ADLog(@"广告获取失败");
    }
    first:theFirst];
}

-(void) adToobtainComplete:(NSString*)responseString
{
//    [{"position":"left",
//        "anonymous":"yes",
//        "appName":"sohu游戏中心",
//        "isMorrowStart":"no",
//        "packageName":"",
//        "clean":"no",
//        "adId":"0050",
//        "clickText":"",
//        "appURL":"https://itunes.apple.com/cn/app/sou-hu-ying-yong-zhong-xin/id495099169?mt=8",
//        "powerclick":"yes",
//        "pic3URL":"http://myimages.qiniudn.com/1382602663849.jpg",
//        "appDesc1":""}]
    if([_adArray count] > 0)
    {
        [_adArray removeObjectAtIndex:0];
    }
    id obj = [responseString JSONValue];
    if (obj && [obj isKindOfClass:[NSArray class]])
    {
        
        NSArray* arr = obj;
        if([arr count] > 0)
        {
            if(_addeleage && [_addeleage respondsToSelector:@selector(loadDateInsertScreenAD)])
            {
                [_addeleage loadDateInsertScreenAD];
            }
        }
        for (int i = 0; i < [arr count]; i++)
        {
            NSDictionary* dic = [arr objectAtIndex:i];
            CBAdvertisementModel* adModel = [[CBAdvertisementModel alloc] init];
            adModel.position = [dic objectForKey:@"position"];
            adModel.anonymous = [dic objectForKey:@"anonymous"];
            adModel.appName = [dic objectForKey:@"appName"];
            adModel.isMorrowStart = [dic objectForKey:@"isMorrowStart"];
            adModel.packageName = [dic objectForKey:@"packageName"];
            adModel.clean = [dic objectForKey:@"clean"];
            adModel.adId = [dic objectForKey:@"adId"];
            adModel.clickText = [dic objectForKey:@"clickText"];
            adModel.appURL = [dic objectForKey:@"appURL"];
            adModel.powerclick = [dic objectForKey:@"powerclick"];
            adModel.pic3URL = [dic objectForKey:@"pic3URL"];
            adModel.appDesc1 = [dic objectForKey:@"appDesc1"];
            
            NSURL *url = [[NSURL alloc] initWithString:adModel.pic3URL];
            SvIncrementallyImage *webImage = [[SvIncrementallyImage alloc] initWithURL:url];
            adModel.svIncrementallyImg = webImage;
            
            if (i == ([arr count] - 1))
            {
                setCbAdId(adModel.adId);
            }
            [_adArray addObject:adModel];
        }
    }
//    [self showScreenView]; //展示页面
}




//点击广告返回
-(void) adDownSelector:(CBAdvertisementModel*)adItem
{
    [_networkEng postInstallation:adItem];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:adItem.appURL]];
    if(_addeleage && [_addeleage respondsToSelector:@selector(clickInsertScreenAD)])
    {
        [_addeleage clickInsertScreenAD];
    }
}

//关闭广告
-(void)adCloseSelector
{
    if(_addeleage && [_addeleage respondsToSelector:@selector(closeInsertScreenAD)])
    {
        [_addeleage closeInsertScreenAD];
    }
}

@end
