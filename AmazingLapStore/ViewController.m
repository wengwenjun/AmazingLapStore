//
//  ViewController.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/9/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "ViewController.h"
#import "SignInViewController.h"
#import "SignUpViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)SignUpBtn:(id)sender {
    UIViewController *signVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self presentViewController:signVC animated:YES completion:nil];
}
- (IBAction)SignInBtn:(id)sender {
    UIViewController *signVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self presentViewController:signVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
