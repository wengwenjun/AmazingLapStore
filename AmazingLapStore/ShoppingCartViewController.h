//
//  ShoppingCartViewController.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/13/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PayPalMobile.h>
#import <PayPalConfiguration.h>
#import <PayPalPaymentViewController.h>
#import <MACTableView.h>

@interface ShoppingCartViewController : UIViewController<PayPalPaymentDelegate>
@property (nonatomic)NSMutableArray *cartArray;
@end
