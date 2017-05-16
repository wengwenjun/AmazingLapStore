//
//  ShoppingCart.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/14/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "ShoppingCart.h"

@implementation ShoppingCart
+( instancetype )sharedInstance
{
    static ShoppingCart* mfs_Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mfs_Instance = [ [ ShoppingCart alloc ] init ];
        mfs_Instance.cartList = [[NSMutableArray alloc] init];
    });
    return mfs_Instance;
}
@end
