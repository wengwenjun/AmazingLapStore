
//
//  HistoryViewController.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/15/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "HistoryViewController.h"
#import "Order.h"
#import "ApiHandler.h"
#import "HistoryTableViewCell.h"

@interface HistoryViewController ()
@property (nonatomic) NSMutableArray *orderArray;
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Order History";
    self.orderArray = [[NSMutableArray alloc]init];
    self.tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
    [self findAllOrder];
}
-(void)viewWillAppear:(BOOL)animated {
    [self.tblView reloadData];
}
-(void) findAllOrder {
    NSString * mobile =[[NSUserDefaults standardUserDefaults]valueForKey:@"mobile"];
    NSString *str= [NSString stringWithFormat: @"http://rjtmobile.com/ansari/shopingcart/androidapp/order_history.php?mobile=%@",mobile];
    NSURL *url = [NSURL URLWithString:str];
    [[ApiHandler sharedApiHandler]getServiceJsonApiHandlerWithCallBack:url withCallBack:^(id data, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(error ==nil){
                if([data isKindOfClass:[NSArray class]]){
                    NSLog(@"Array data---->%@", data);
                }
                else if ([data isKindOfClass:[NSDictionary class]]){
                    for(NSDictionary * dict in data[@"Order History"]){
                        Order *o = [[Order alloc]initWithId:dict[@"OrderID"] withName:dict[@"ItemName"] withQuantity:dict[@"ItemQuantity"] withPrice:dict[@"FinalPrice"] withStatus:dict[@"OrderStatus"]];
                        [self.orderArray addObject:o];
                        [self.tblView reloadData];
                    }
                }
            }
        });
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.orderArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryTableViewCell"];
    Order *o = [self.orderArray objectAtIndex:indexPath.row];
    cell.orderIDLabel.text = o.orderID;
    cell.ItemNameLabel.text = o.itemName;
    cell.ItemQuantityLabel.text =o.itemQuantity;
    cell.finalPriceLabel.text = o.finalPrice;
    if([o.orderStatus isEqualToString: @"1"]){
    cell.orderStatusLabel.text = @"Order has been placed";
    }
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
