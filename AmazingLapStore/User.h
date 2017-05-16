//
//  User.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/10/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *mobile;

-(User *)initWithUsername: (NSString *)name withEmail: (NSString *)em withPassword: (NSString *)pw withMobile: (NSString *)mo;
-(User *)loginWithMobile :(NSString *)mo withPassword:(NSString *)pw;
@end
