//
//  Product.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/13/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject <NSCoding>
@property (nonatomic) NSString *Id;
@property (nonatomic) NSString* ProductName;
@property (nonatomic) NSString *Quantity;
@property (nonatomic) NSString* Price;
@property (nonatomic) NSString *Discription;
@property (nonatomic) NSString * Image;

-(Product *)initWithId: (NSString*)ID withName: (NSString*)name withQuantity: (NSString *)quantity withPrice:(NSString *)price withDiscription: (NSString *)discription withImage: (NSString *)image;

-(Product *)productViewWithId:(NSString *)ID withName: (NSString *)name withImage: (NSString *)image;

-(void) encodeWithCoder:(NSCoder *)aCoder;
-(instancetype) initWithCoder:(NSCoder *)aDecoder;
@end
