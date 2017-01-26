//
//  AccessToken.h
//  APITest
//
//  Created by Stepan Paholyk on 1/26/17.
//  Copyright © 2017 Stepan Paholyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessToken : NSObject

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSData *expirationDate;
@property (nonatomic, strong) NSString *userID;

@end
