//
//  SubCategory.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/12/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubCategory : NSObject
@property (nonatomic) NSString *ID;
@property (nonatomic) NSString * SubCategoryName;
@property (nonatomic) NSString * SubCategoryDiscription;
@property (nonatomic) NSString * SubCategoryImage;
-(SubCategory *)initWithId: (NSString*)ID withName: (NSString *)name withDiscription:(NSString *)discription withImage: (NSString *)image;
@end



