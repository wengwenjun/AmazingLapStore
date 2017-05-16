//
//  SubCategoryViewController.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/12/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "SubCategoryViewController.h"
#import "ApiHandler.h"
#import "SubCategoryCollectionViewCell.h"
#import "ProductViewController.h"

@interface SubCategoryViewController ()
@property (nonatomic) NSMutableArray *subCategoryArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSString *productURL;
@property (nonatomic) NSMutableArray *idArray;
@end

@implementation SubCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Category";
    self.navigationController.navigationBarHidden = NO;
    self.subCategoryArray = [[NSMutableArray alloc]init];
    self.idArray  = [[NSMutableArray alloc]init];
    [self findSubCategory];
    // Do any additional setup after loading the view.
}
-(void)findSubCategory {
    NSURL* url = [NSURL URLWithString:self.subUrl];
    [[ApiHandler sharedApiHandler]getServiceJsonApiHandlerWithCallBack:url withCallBack:^(id data, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(error ==nil){
                if([data isKindOfClass:[NSArray class]]){
                    NSLog(@"Array data---->%@", data);
                }
                else if ([data isKindOfClass:[NSDictionary class]]){
                   // NSLog(@"Dictionary data ---->%@",[data valueForKey:@"SubCategory"]);
                    for(NSDictionary * dict in data[@"SubCategory"]){
                        NSLog(@"%@",dict);
                        [self.subCategoryArray addObject:dict];
                        [self.collectionView reloadData];
                    }
                }
            }
        });
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.subCategoryArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdetifier = @"SubCategoryCollectionViewCell";
    SubCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdetifier forIndexPath:indexPath];
    NSString *imageName = [[self.subCategoryArray objectAtIndex:indexPath.item]valueForKey:@"CatagoryImage"];
    NSURL *url = [NSURL URLWithString:imageName];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.subCategoryImage.image =[UIImage imageWithData:data];
    cell.subCategoryName.text = [[self.subCategoryArray objectAtIndex:indexPath.item]valueForKey:@"SubCatagoryName"];
    cell.subCategoryDiscription.text = [[self.subCategoryArray objectAtIndex:indexPath.item]valueForKey:@"SubCatagoryDiscription"];
    NSString *id =[[self.subCategoryArray objectAtIndex:indexPath.row]valueForKey:@"Id"];
    [self.idArray addObject:id];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    NSString *ID = [self.idArray lastObject];
    self.productURL = [NSString stringWithFormat: @"http://rjtmobile.com/ansari/shopingcart/androidapp/cust_product.php?Id=%@",ID];
    ProductViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductViewController"];
    [vc setProductURL:self.productURL];
    [self.navigationController pushViewController:vc animated:YES];
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
