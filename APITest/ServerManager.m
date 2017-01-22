//
//  ServerManager.m
//  APITest
//
//  Created by Stepan Paholyk on 1/21/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

#import "ServerManager.h"

@implementation ServerManager

// custom singelton
+ (ServerManager *)sharedManager {
    static ServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    
    return manager;
}

- (void) getFriendsWithOffset:(NSInteger)offset
                        count:(NSInteger)count
                    onSuccess:(void (^)(NSArray *))success
                    onFailure:(void (^)(NSError *, NSInteger))failure {
    
    
    
}
@end
