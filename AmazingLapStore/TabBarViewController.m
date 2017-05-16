//
//  TabBarViewController.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/11/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureTabbar];
}

-(void)configureTabbar{
    [self.tabBar setAlpha:1.0];
    for(int i = 0; i< [self.tabBar.items count]; i++){
        UITabBarItem *item = [self.tabBar.items objectAtIndex:i];
        if(i==0){
        item.title = @"Category";
        item.image = [[UIImage imageNamed:@"Category"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:@"CategorySelected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else if(i ==1){
        item.title = @"Cart";
        item.image = [[UIImage imageNamed:@"ShoppingCart"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:@"ShoppingCartSelected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else if(i ==2){
        item.title = @"Order";
        item.image = [[UIImage imageNamed:@"Order"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:@"OrderSelected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
