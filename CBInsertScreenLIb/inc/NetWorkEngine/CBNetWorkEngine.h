//
//  CBNetWorkEngine.h
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-30.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InsertScreen.h"
typedef void (^CBNetWorkComplete)(NSString* responseString);
typedef void (^CBNetWorkError)(NSError* err);
@interface CBNetWorkEngine : MKNetworkEngine

-(MKNetworkOperation*) postDataToServer:(CBNetWorkComplete)completeblock netWorkError:(CBNetWorkError)errorblock;


@end
