//
//  User.h
//  APITest
//
//  Created by Stepan Paholyk on 1/23/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *imageURL;

- (id)initWithServerResponse:(NSDictionary*) responseObject; 

@end
