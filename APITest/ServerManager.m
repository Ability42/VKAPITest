//
//  ServerManager.m
//  APITest
//
//  Created by Stepan Paholyk on 1/21/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

#import "ServerManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation ServerManager

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
    /*** to call a VK API method you need to make a POST or GET method to specify URL by passing HTTPS protocol ***/

    
    // @"friends.get"
    // @"user_ids"
    // @"fields"
    // @"name_case "
    
    /***** Request Serialization *****/
    
    NSString *URLString = @"https://api.vk.com/method/friends.get";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"138593392", @"user_id",
                            @"hints", @"order",
                            @(count), @"count",
                            @(offset), @"offset",
                            @"photo_100", @"fields",
                            @"nom", @"name_case",
                            nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URLString parameters:params progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
             NSLog(@"JSON: %@", responseObject);
             // may store responseObject
             NSArray *friendsArray = [responseObject objectForKey:@"response"];
             
             if (success) {
                 success(friendsArray);
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"ERROR: %@", [error localizedDescription]);
             
             if (failure) {
                 failure(error, task.state);
             }
             
         }];
    
}
@end
