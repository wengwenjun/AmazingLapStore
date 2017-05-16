//
//  ProductViewController.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/12/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "ProductViewController.h"
#import "ApiHandler.h"
#import "ProductTableViewCell.h"
#import "Product.h"
#import "ShoppingCart.h"
#import "ShoppingCartViewController.h"


@interface ProductViewController ()
@property (nonatomic) NSMutableArray* productArray;
@property (nonatomic) NSMutableArray *cartArray;
@property (nonatomic) NSURL *url;
@property (strong, nonatomic) ShoppingCart *cart;
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Product";
    self.productArray = [[NSMutableArray alloc]init];
    self.cartArray= [[NSMutableArray alloc]init];
    self.url = [NSURL URLWithString:self.productURL];
    self.cart = [ShoppingCart sharedInstance];
    self.tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tblView.estimatedRowHeight = 320;
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    [self findProduct];
    // Do any additional setup after loading the view.
}

-(void) findProduct{
    [[ApiHandler sharedApiHandler]getServiceJsonApiHandlerWithCallBack:self.url withCallBack:^(id data, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(error ==nil){
                if([data isKindOfClass:[NSArray class]]){
                    NSLog(@"Array data---->%@", data);
                }
                else if ([data isKindOfClass:[NSDictionary class]]){
                    for(NSDictionary * dict in data[@"Product"]){
                        //NSLog(@"%@",dict);
                        NSString *description = @"";
                        if([dict[@"Discription"] isKindOfClass:[NSNull class]]){
                          description = @"No Description";
                        }else{
                            description = dict[@"Discription"];
                        }
                        Product *p = [[Product alloc]initWithId:dict[@"Id"] withName: dict[@"ProductName"] withQuantity:dict[@"Quantity"] withPrice:dict[@"Prize"] withDiscription:description withImage:dict[@"Image"]];
                        [self.productArray addObject:p];
                       // [self.collectionView reloadData];
                        [self.tblView reloadData];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.productArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     ProductTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"ProductTableViewCell"];
    Product *p = [self.productArray objectAtIndex:indexPath.row];
    cell.productName.text = p.ProductName;
    NSString *imageName = p.Image;
    NSURL *url = [NSURL URLWithString:imageName];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.productImage.image = [UIImage imageWithData:data];
    float price = [p.Price intValue]*0.016;
    cell.productPrice.text = [NSString stringWithFormat:@"Price: %.2f",price];
    cell.productDescription.text = [NSString stringWithFormat:@"Description: %@",p.Discription];
    cell.addToCart.tag = indexPath.row;
    [cell.addToCart addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)addToCart: (UIButton *)sender{
    Product *product = [self.productArray objectAtIndex:sender.tag];
    [self.cart.cartList addObject:product];
    //ShoppingCartViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShoppingCartViewController"];
    //[vc setCartArray:self.cartArray];
    /*NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:[self.cartArray count]];
    for (Product *p in self.cartArray) {
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:p];
        [archiveArray addObject:data];
    }
    NSUserDefaults *productData = [NSUserDefaults standardUserDefaults];
    [productData setObject:archiveArray forKey:@"cartArray"];*/
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Good Choice!"message:@"Added To Cart" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
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
