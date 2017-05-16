//
//  HistoryTableViewCell.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/15/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *ItemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ItemQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalPriceLabel;

@end
