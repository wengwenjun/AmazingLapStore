//
//  Product.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/13/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "Product.h"

@implementation Product 
-(Product *)initWithId: (NSString*)ID withName: (NSString*)name withQuantity: (NSString *)quantity withPrice:(NSString *)price withDiscription: (NSString *)discription withImage: (NSString *)image{
    self = [super init];
    self.Id = ID;
    self.ProductName = name;
    self.Quantity = quantity;
    self.Price = price;
    self.Discription = discription;
    self.Image = image;
    return self;
}

-(Product *)productViewWithId:(NSString *)ID withName: (NSString *)name withImage: (NSString *)image{
    self.Id = ID;
    self.ProductName = name;
    self.Image = image;
    return self;    
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.Id forKey:@"Id"];
    [aCoder encodeObject:self.ProductName forKey:@"ProductName"];
    [aCoder encodeObject:self.Quantity forKey:@"Quantity"];
    [aCoder encodeObject:self.Price forKey:@"Price"];
    [aCoder encodeObject:self.Discription forKey:@"Discription"];
    [aCoder encodeObject:self.Image forKey:@"Image"];
    
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.Id = [aDecoder decodeObjectForKey:@"Id"];
        self.ProductName = [aDecoder decodeObjectForKey:@"ProductName"];
        self.Quantity = [aDecoder decodeObjectForKey:@"Quantity"];
        self.Price = [aDecoder decodeObjectForKey:@"Price"];
        self.Discription = [aDecoder decodeObjectForKey:@"Discription"];
        self.Image = [aDecoder decodeObjectForKey:@"Image"];
    }
    return self;
}

@end
