//
//  ShoppingCartViewController.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/13/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "Product.h"
#import "ShoppingCart.h"
#import "ApiHandler.h"

@interface ShoppingCartViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic) NSMutableArray *unarchiveArray;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UIButton *checkOut;
@property (nonatomic) NSMutableArray *indexArray;
@property (strong, nonatomic) ShoppingCart *shoppingCart;
@property (nonatomic, strong, readwrite) PayPalConfiguration *payPalConfiguration;


@end

float sum;
@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Shopping Cart";
    self.indexArray = [[NSMutableArray alloc]init];
    self.tblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.shoppingCart = [ShoppingCart sharedInstance];
    self.cartArray = self.shoppingCart.cartList;
    _payPalConfiguration = [[PayPalConfiguration alloc] init];
    _payPalConfiguration.acceptCreditCards = false;
    _payPalConfiguration.merchantName = @"Thank you for shopping with AmazingLaptop!";
    _payPalConfiguration.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfiguration.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    _payPalConfiguration.languageOrLocale = [NSLocale preferredLanguages][0];
    _payPalConfiguration.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;

    
    // Do any additional setup after loading the view.
}
-(void) viewDidAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //self.unarchiveArray  = [[NSUserDefaults standardUserDefaults]valueForKey:@"cartArray"];
    sum = 0;
    /*self.cartArray = [NSMutableArray arrayWithCapacity:self.unarchiveArray.count];
    for(NSData *data in self.unarchiveArray){
        Product *p = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        //sum = sum + [p.Price intValue];
        //self.totalPrice.text = [NSString stringWithFormat:@"%ld",(long)sum];
        [self.cartArray addObject:p];
        [self.tblView reloadData];
    }*/
    [self.tblView reloadData];
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentNoNetwork];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cartArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCartTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartTableViewCell"];
    Product *p = [self.cartArray objectAtIndex:indexPath.row];
    int quant = [p.Quantity intValue];
    float price = [p.Price intValue] *0.016;
    float singlePrice = quant * price;
    sum = sum + singlePrice;
    self.totalPrice.text = [NSString stringWithFormat:@"$%.2f",sum];
    cell.productName.text = p.ProductName;
    NSString *imageName = p.Image;
    NSURL *url = [NSURL URLWithString:imageName];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.productImage.image = [UIImage imageWithData:data];
    cell.productPrice.text = [NSString stringWithFormat:@"$%0.2f",[p.Price intValue]*0.016];
    cell.productQuantity.text = p.Quantity;
    [self.indexArray addObject:indexPath];
    cell.minusQuantity.tag = indexPath.row;
    [cell.minusQuantity addTarget:self action:@selector(lessQuantity:) forControlEvents:UIControlEventTouchUpInside];
    cell.addQuantity.tag = indexPath.row;
    [cell.addQuantity addTarget:self action:@selector(moreQuantity:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)lessQuantity :(UIButton *)sender {
    Product *product = [self.cartArray objectAtIndex:sender.tag];
    int quant = [product.Quantity intValue];
    quant = quant -1;
    product.Quantity = [NSString stringWithFormat:@"%d",quant];
    sum = 0;
    if (quant == 0) {
        [self.cartArray removeObjectAtIndex:sender.tag];
    }
    if (self.cartArray.count == 0) {
        self.totalPrice.text = @"0";
    }
   /* NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:[self.cartArray count]];
    for (Product *p in self.cartArray) {
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:p];
        [archiveArray addObject:data];
    }
    NSUserDefaults *productData = [NSUserDefaults standardUserDefaults];
    [productData setObject:archiveArray forKey:@"cartArray"];*/
    [self.tblView reloadData];
    

}
-(void)moreQuantity: (UIButton *)sender {
    Product *product = [self.cartArray objectAtIndex:sender.tag];
    int quant = [product.Quantity intValue];
    quant += 1;
    product.Quantity = [NSString stringWithFormat:@"%d",quant];
    sum = 0;
    /*NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:[self.cartArray count]];
    for (Product *p in self.cartArray) {
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:p];
        [archiveArray addObject:data];
    }
    NSUserDefaults *productData = [NSUserDefaults standardUserDefaults];
    [productData setObject:archiveArray forKey:@"cartArray"];*/
    [self.tblView reloadData];
    
}

- (IBAction)checkOut:(id)sender {
    NSMutableArray *itemsList = [[NSMutableArray alloc] init];
    for (Product *p in self.cartArray) {
        int quant = [p.Quantity intValue];
        PayPalItem *item = [PayPalItem itemWithName: p.ProductName withQuantity:quant withPrice:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%0.2f", [p.Price intValue]*0.016]] withCurrency:@"USD"withSku:[NSString stringWithFormat:@"SKU-%@", p.ProductName]];
         [itemsList addObject:item];
    }
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:itemsList];
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"4.99"];
    NSDecimalNumber *tax = [subtotal decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithString:@"0.1"]];
    
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal withShipping:shipping withTax:tax];
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    // Create a PayPalPayment
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    
    // Amount, currency, and description
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = @"Product Total";
    payment.items = itemsList;
    payment.paymentDetails = paymentDetails;
    payment.payeeEmail = @"rebecce@gmail.com";
    
    payment.intent = PayPalPaymentIntentSale;
    
    //    payment.shippingAddress = address; // a previously-created PayPalShippingAddress object
    
    if (!payment.processable) {
        // If, for example, the amount was negative or the shortDescription was empty, then
        // this payment would not be processable. You would want to handle that here.
    }
    
    
    
    // Create a PayPalPaymentViewController.
    PayPalPaymentViewController *paymentViewController;
    paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                   configuration:self.payPalConfiguration
                                                                        delegate:self];
    
    // Present the PayPalPaymentViewController.
    [self presentViewController:paymentViewController animated:YES completion:^{
        NSLog(@"completion");
    }];

}

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                 didCompletePayment:(PayPalPayment *)completedPayment {
    
    NSLog(@"Payment Success !!");
    // Payment was processed successfully; send to server for verification and fulfillment.
    //    [self verifyCompletedPayment:completedPayment];
    
    [self sendOrder];
    
    // Dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    
    NSLog(@"Payment Cancel !!");
    // The payment was canceled; dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sendOrder {
    NSString *mobile = [[NSUserDefaults standardUserDefaults]valueForKey:@"mobile"];
    for(Product *p in self.cartArray){
         float finalPrice = [p.Quantity intValue] * [p.Price intValue]*0.016;
        NSString *str = [NSString stringWithFormat: @"http://rjtmobile.com/ansari/shopingcart/androidapp/orders.php?mobile=%@&item_names=%@&final_price=%@&item_quantity=%@&item_id=%@",mobile, p.ProductName, [NSString stringWithFormat:@"%.2f",finalPrice],p.Quantity, p.Id];
        NSURL *url = [NSURL URLWithString:str];
        [[ApiHandler sharedApiHandler]getServiceJsonApiHandlerWithCallBack:url withCallBack:^(id data, NSError *error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(error == nil){
                    NSLog(@"%@",data);
                    [self.cartArray removeAllObjects];
                    [self.tblView reloadData];
                    self.totalPrice.text = @"0";
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert"message:@"Order Confirmed!" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
            }
            });
        }];
    }
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
