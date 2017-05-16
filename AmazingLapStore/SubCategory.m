//
//  SubCategory.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/12/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "SubCategory.h"

@implementation SubCategory
-(SubCategory *)initWithId:(NSString *)ID withName:(NSString *)name withDiscription:(NSString *)discription withImage:(NSString *)image{
    self = [super init];
    self.ID = ID;
    self.SubCategoryName = name;
    self.SubCategoryDiscription = discription;
    self.SubCategoryImage = image;
    return self;
}
@end
