//
//  Order.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/14/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "Order.h"

@implementation Order
-(Order *)initWithId: (NSString*)ID withName: (NSString*)name withQuantity: (NSString *)quantity withPrice:(NSString *)price withStatus: (NSString *)status{
    self = [super init];
    self.orderID = ID;
    self.itemName = name;
    self.itemQuantity = quantity;
    self.finalPrice = price;
    self.orderStatus = status;
    return self;
}
@end
