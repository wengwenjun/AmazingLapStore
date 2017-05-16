//
//  ShoppingCartTableViewCell.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/13/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productQuantity;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UIButton *addQuantity;
@property (weak, nonatomic) IBOutlet UIButton *minusQuantity;
@end
