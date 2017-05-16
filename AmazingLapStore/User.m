//
//  User.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/10/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "User.h"

@implementation User

-(User *)initWithUsername:(NSString *)name withEmail:(NSString *)em withPassword:(NSString *)pw withMobile:(NSString *)mo{
    self = [super init];
    self.username = name;
    self.email = em;
    self.password = pw;
    self.mobile = mo;
    return self;
}

-(User *)loginWithMobile :(NSString *)mo withPassword:(NSString *)pw{
    self.mobile = mo;
    self.password = pw;
    return self;
}
@end
