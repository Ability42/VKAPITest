//
//  User.m
//  APITest
//
//  Created by Stepan Paholyk on 1/23/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithServerResponse:(NSDictionary*) responseObject { // or id
    self = [super init];
    if (self) {
        self.firstName  = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        
        NSString *urlString = [responseObject objectForKey:@"photo_100"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
    }
    return self;
}


@end
