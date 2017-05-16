//
//  TopSeller.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/15/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopSeller : NSObject
@property (nonatomic) NSString *sellerId;
@property (nonatomic) NSString *sellerName;
@property (nonatomic)NSString *sellerDeal;
@property (nonatomic) NSString *sellerRate;
@property (nonatomic) NSString *sellerLogo;
-(TopSeller *)initWithId: (NSString*)ID withName: (NSString*)name withDeal:(NSString *)deal withRate: (NSString *)rate withLogo: (NSString *)logo;
@end
