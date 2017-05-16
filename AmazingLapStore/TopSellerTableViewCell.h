//
//  TopSellerTableViewCell.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/15/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface TopSellerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productDeller;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *productRate;

@end
