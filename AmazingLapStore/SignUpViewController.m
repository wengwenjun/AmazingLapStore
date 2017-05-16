//
//  SignUpViewController.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/9/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "SignUpViewController.h"
#import "User.h"
#import "ApiHandler.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)alreadyHaveAccountBtn:(id)sender {
    UIViewController *signInVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self presentViewController:signInVC animated:YES completion:nil];
}
- (IBAction)signupBtn:(id)sender {
    User *user = [[User alloc]initWithUsername:self.usernameTextField.text withEmail:self.emailTextField.text withPassword:self.passwordTextField.text withMobile:self.mobileTextField.text];
    NSString *urlStr = [NSString stringWithFormat:@"http://rjtmobile.com/ansari/shopingcart/androidapp/shop_reg.php?name=%@&email=%@&mobile=%@&password=%@", user.username, user.email, user.mobile, user.password];
    NSURL *url = [NSURL URLWithString:urlStr];
    [[ApiHandler sharedApiHandler] getServiceStringApiHandlerWithCallBack:url withCallBack:^(id data, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(error == nil){
                NSLog(@"data ---->%@",data);
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert"message:[NSString stringWithFormat:@"%@",data]preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        });
    }];
 
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
