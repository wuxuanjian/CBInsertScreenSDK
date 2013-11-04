//
//  CBNetWorkEngine.m
//  CBInsertScreen
//
//  Created by EinFachMann on 13-10-30.
//  Copyright (c) 2013年 CB. All rights reserved.
//

#import "CBNetWorkEngine.h"

@implementation CBNetWorkEngine

-(MKNetworkOperation*) postDataToServer {
    
    MKNetworkOperation *op = [self operationWithPath:@"Versions/1.5/login.php"
                                              params:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      @"bobs@thga.me", @"email",
                                                      @"12345678", @"password", nil]
                                          httpMethod:@"POST"];
    
    //[op setUsername:@"bobs@thga.me" password:@"12345678"];
    
    [op onCompletion:^(MKNetworkOperation *operation) {
        
        DLog(@"%@", operation);
    } onError:^(NSError *error) {
        
        DLog(@"%@", error);
    }];
    
    [self enqueueOperation:op];
    
    return op;
}


@end
