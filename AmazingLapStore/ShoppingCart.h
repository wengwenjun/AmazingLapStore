//
//  ShoppingCart.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/14/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCart : NSObject
+( instancetype )sharedInstance;

@property (strong, nonatomic) NSMutableArray *cartList;
@end
