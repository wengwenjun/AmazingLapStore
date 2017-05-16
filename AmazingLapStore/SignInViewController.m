//
//  SignInViewController.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/9/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "SignInViewController.h"
#import "User.h"
#import "ApiHandler.h"
#import "TabBarViewController.h"


@interface SignInViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic) NSMutableArray *infoArray;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}
- (IBAction)backBtn:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.mobileTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.mobileTextField){
        [self.passwordTextField becomeFirstResponder];
    }else if(textField == self.passwordTextField){
        [self.mobileTextField becomeFirstResponder];
    }
    return YES;
}
- (IBAction)signInBtn:(id)sender {
    User *user =[[User alloc]loginWithMobile:self.mobileTextField.text withPassword:self.passwordTextField.text];
    NSString *urlStr = [NSString stringWithFormat:@"http://rjtmobile.com/ansari/shopingcart/androidapp/shop_login.php?mobile=%@&password=%@",user.mobile, user.password];
    NSURL *url = [NSURL URLWithString:urlStr];
    [[ApiHandler sharedApiHandler]getServiceJsonApiHandlerWithCallBack:url withCallBack:^(id data, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
        if(error == nil){
            NSLog(@"data ----> %@",data);
            if([data isKindOfClass:[NSArray class]]){
                [self.infoArray addObjectsFromArray:data];
                for(NSDictionary *dict in self.infoArray){
                    NSString *msg = dict[@"msg"];
                    NSLog(@"%@",msg);
                    if([msg isEqualToString:@"success"]){
                        //present to another view controller
                        [[NSUserDefaults standardUserDefaults]setObject:self.mobileTextField.text forKey:@"mobile"];
                        UITabBarController * homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
                        [self presentViewController:homeVC animated:YES completion:nil];
                        //[self.navigationController pushViewController:homeVC animated:YES];
                    }else{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert"message:[NSString stringWithFormat:@"%@",msg]preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                }
            }
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
