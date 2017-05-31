//
//  HomeViewController.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/11/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "HomeViewController.h"
#import <LLSlideMenu.h>
#import "SignInViewController.h"
#import "ApiHandler.h"
#import "HomeCollectionViewCell.h"
#import "SubCategoryViewController.h"

@interface HomeViewController ()
@property (nonatomic)LLSlideMenu *slideMenu;
@property (nonatomic)NSMutableArray *categoryArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *idArray;
@property (nonatomic) NSString* subUrl;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"Welcome to Amazing Laptop";
    self.slideMenu = [[LLSlideMenu alloc] init];
    [self.view addSubview:self.slideMenu];
    self.slideMenu.ll_menuWidth = 150.f;
    self.slideMenu.ll_menuBackgroundColor = [UIColor colorWithRed:0.96 green:0.76 blue:0.76 alpha:1.0];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(10, 100, 100, 100)];
    [button1 setTitle:@"LOGIN IN" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(SignInPage:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setFrame:CGRectMake(10, 150, 100, 100)];
    [button2 setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(SignUpPage:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setFrame:CGRectMake(10, 200, 150, 100)];
    [button3 setTitle:@"TOP SELLERS" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(TopSellers:) forControlEvents:UIControlEventTouchUpInside];
    [self.slideMenu addSubview:button1];
    [self.slideMenu addSubview:button2];
    [self.slideMenu addSubview:button3];
    self.categoryArray = [[NSMutableArray alloc]init];
    self.idArray = [[NSMutableArray alloc]init];
    [self findAllCategory];
    
    // Do any additional setup after loading the view.
}
-(void) viewWillAppear:(BOOL)animated {
    //[self findAllCategory];
    [super viewWillAppear:NO];
     self.navigationController.navigationBarHidden = YES;
}

-(void)SignInPage:(UIButton *)sender{
    UIViewController *signIn = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self presentViewController:signIn animated:YES completion:nil];
}

-(void)SignUpPage:(UIButton *)sender{
    UIViewController *signIn = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self presentViewController:signIn animated:YES completion:nil];
}
-(void)TopSellers:(UIButton *)sender{
    UIViewController *topSellers = [self.storyboard instantiateViewControllerWithIdentifier:@"TopSellerViewController"];
    [self.navigationController pushViewController:topSellers animated:YES];
}
- (IBAction)openSliding:(id)sender {
    [self.slideMenu ll_openSlideMenu];
}

-(void) findAllCategory{
    NSString *urlStr = @"http://rjtmobile.com/ansari/shopingcart/androidapp/cust_category.php";
    NSURL* url = [NSURL URLWithString:urlStr];
    [[ApiHandler sharedApiHandler]getServiceJsonApiHandlerWithCallBack:url withCallBack:^(id data, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
        if(error ==nil){
            if([data isKindOfClass:[NSArray class]]){
            //NSLog(@"data---->%@", data);
            }
            else if ([data isKindOfClass:[NSDictionary class]]){
                //NSLog(@"data ---->%@",data);
                for(NSDictionary * dict in data[@"Category"]){
                    //NSLog(@"%@",dict);
                    [self.categoryArray addObject:dict];
                    [self.collectionView reloadData];
                }
            }
        }
        });
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.categoryArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdetifier = @"HomeCollectionViewCell";
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdetifier forIndexPath:indexPath];
    NSString *imageName = [[self.categoryArray objectAtIndex:indexPath.item]valueForKey:@"CatagoryImage"];
    NSURL *url = [NSURL URLWithString:imageName];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.categoryImageView.image =[UIImage imageWithData:data];
    cell.categoryName.text = [[self.categoryArray objectAtIndex:indexPath.item]valueForKey:@"CatagoryName"];
    cell.categoryDescription.text = [[self.categoryArray objectAtIndex:indexPath.item]valueForKey:@"CatagoryDiscription"];
    NSString *id =[[self.categoryArray objectAtIndex:indexPath.row]valueForKey:@"Id"];
    [self.idArray addObject:id];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%ld",indexPath.row);
    //UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    /*cell.layer.backgroundColor = [UIColor colorWithRed:0.96 green:0.76 blue:0.76 alpha:1.0].CGColor;*/
    NSString *ID = [self.idArray objectAtIndex:indexPath.row];
    self.subUrl = [NSString stringWithFormat: @"http://rjtmobile.com/ansari/shopingcart/androidapp/cust_sub_category.php?Id=%@",ID];
    SubCategoryViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubCategoryViewController"];
    [vc setSubUrl:self.subUrl];
    [self.navigationController pushViewController:vc animated:NO];
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
