//
//  Category.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/12/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject
@property (nonatomic)NSString *id;
@property (nonatomic) NSString *categoryName;
@property (nonatomic) NSString *categoryDiscription;
@property (nonatomic) NSString *categoryImage;

-(Category *)initWithId: (NSString*)id withName: (NSString *)name withDiscription:(NSString *)discription withImage: (NSString *)image;
@end
