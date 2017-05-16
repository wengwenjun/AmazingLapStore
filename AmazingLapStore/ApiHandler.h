//
//  ApiHandler.h
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/10/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiHandler : NSObject
+(ApiHandler *) sharedApiHandler;
typedef void(^GetUserServiceApiCallBack)(id data, NSError *error);
-(void)getServiceStringApiHandlerWithCallBack:(NSURL *)url withCallBack:(GetUserServiceApiCallBack)getServiceCallBack;
-(void)getServiceJsonApiHandlerWithCallBack:(NSURL *)url withCallBack:(GetUserServiceApiCallBack)getServiceCallBack;
@end
