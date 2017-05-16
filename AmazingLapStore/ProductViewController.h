//
//  ProductViewController.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/12/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController
@property (nonatomic) NSString *productURL;
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@end
