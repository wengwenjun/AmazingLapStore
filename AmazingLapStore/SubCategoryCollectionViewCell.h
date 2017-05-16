//
//  SubCategoryCollectionViewCell.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/12/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubCategoryCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *subCategoryImage;
@property (weak, nonatomic) IBOutlet UILabel *subCategoryName;
@property (weak, nonatomic) IBOutlet UILabel *subCategoryDiscription;
@end
