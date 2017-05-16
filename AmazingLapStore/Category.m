//
//  Category.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/12/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "Category.h"

@implementation Category

-(Category*)initWithId:(NSString *)id withName:(NSString *)name withDiscription:(NSString *)discription withImage:(NSString *)image{
    self = [super init];
    self.id = id;
    self.categoryName = name;
    self.categoryDiscription = discription;
    self.categoryImage = image;
    return self;
}
@end
