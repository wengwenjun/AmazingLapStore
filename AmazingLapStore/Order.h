//
//  Order.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/14/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
@property (nonatomic)NSString *orderID;
@property (nonatomic)NSString *itemName;
@property (nonatomic)NSString *itemQuantity;
@property (nonatomic)NSString *finalPrice;
@property (nonatomic)NSString *orderStatus;
-(Order *)initWithId: (NSString*)ID withName: (NSString*)name withQuantity: (NSString *)quantity withPrice:(NSString *)price withStatus: (NSString *)status;
@end
