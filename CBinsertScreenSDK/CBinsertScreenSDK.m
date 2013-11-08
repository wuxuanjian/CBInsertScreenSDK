//
//  CBinsertScreenSDK.m
//  CBinsertScreenSDK
//
//  Created by EinFachMann on 13-11-8.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBinsertScreenSDK.h"
#import "InsertScreen.h"

@interface CBinsertScreenSDK()
{
    CBInsertScreen* insertScreen;
}
@end

@implementation CBinsertScreenSDK

+(CBinsertScreenSDK*) insertScreenSDK
{
    CBinsertScreenSDK* inssdk = [[CBinsertScreenSDK alloc] init];
    [inssdk openInserScreen];
    return inssdk;
}

-(void) openInserScreen
{
    if (insertScreen == nil)
    {
        insertScreen = [[CBInsertScreen alloc] init];
    }
    
    [insertScreen openInserScreenSDK];

}

@end
