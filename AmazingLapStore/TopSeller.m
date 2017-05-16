//
//  TopSeller.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/15/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "TopSeller.h"

@implementation TopSeller
-(TopSeller *)initWithId: (NSString*)ID withName: (NSString*)name withDeal:(NSString *)deal withRate: (NSString *)rate withLogo: (NSString *)logo{
    self = [super init];
    self.sellerId = ID;
    self.sellerName = name;
    self.sellerDeal = deal;
    self.sellerRate = rate;
    self.sellerLogo = logo;
    return self;
}
@end
