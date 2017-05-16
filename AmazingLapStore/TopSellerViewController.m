//
//  TopSellerViewController.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/15/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "TopSellerViewController.h"
#import "ApiHandler.h"
#import "TopSeller.h"
#import "TopSellerTableViewCell.h"

@interface TopSellerViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic)NSMutableArray *topSellerArray;
@end

@implementation TopSellerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topSellerArray = [[NSMutableArray alloc]init];
    [self findTopSeller];
    // Do any additional setup after loading the view.
}
- (IBAction)backBtn:(id)sender {
    [self popoverPresentationController];
}

-(void) findTopSeller{
    NSString *str= @"http://rjtmobile.com/ansari/shopingcart/androidapp/shop_top_sellers.php";
    NSURL *url = [NSURL URLWithString:str];
    [[ApiHandler sharedApiHandler]getServiceJsonApiHandlerWithCallBack:url withCallBack:^(id data, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(error ==nil){
                if([data isKindOfClass:[NSArray class]]){
                    NSLog(@"Array data---->%@", data);
                }
                else if ([data isKindOfClass:[NSDictionary class]]){
                    for(NSDictionary * dict in data[@"Top Sellers"]){
                        TopSeller *t = [[TopSeller alloc]initWithId:dict[@"SellerId"] withName:dict[@"SellerName"] withDeal:dict[@"SellerDeal"] withRate:dict[@"SellerRating"] withLogo:dict[@"SellerLogo"]];
                        [self.topSellerArray addObject:t];
                        [self.tblView reloadData];
                    }
                }
            }
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.topSellerArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopSellerTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"TopSellerTableViewCell"];
    TopSeller *t = [self.topSellerArray objectAtIndex:indexPath.row];
    cell.productName.text = t.sellerName;
    cell.productDeller.text = t.sellerDeal;
    cell.productRate.value = [t.sellerRate floatValue];
    [cell.productRate setEnabled:NO];
    NSString *imageName= t.sellerLogo;
    NSURL *url = [NSURL URLWithString:imageName];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.productImage.image = [UIImage imageWithData:data];
    return cell;
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
