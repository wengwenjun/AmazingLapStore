//
//  ApiHandler.m
//  AmazingLapStore
//
//  Created by Wenjun Weng on 5/10/17.
//  Copyright © 2017 rjt.compquest. All rights reserved.
//

#import "ApiHandler.h"
#import "User.h"

static ApiHandler *apihandler;
@implementation ApiHandler

#pragma singleton
+(ApiHandler *)sharedApiHandler{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apihandler = [[ApiHandler alloc]init];
    });
    return apihandler;
}
-(void)getServiceStringApiHandlerWithCallBack:(NSURL *)url withCallBack:(GetUserServiceApiCallBack)getServiceCallBack{
   [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       if(error){
           getServiceCallBack(nil,error);
       }else{
           NSLog(@"%@",response);
           NSString* str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
              // NSLog(@"%@",data);
               //NSLog(@"str: %@", str);
           getServiceCallBack (str,nil);
       }
   }]resume];
}

-(void)getServiceJsonApiHandlerWithCallBack:(NSURL *)url withCallBack:(GetUserServiceApiCallBack)getServiceCallBack {
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            getServiceCallBack(nil,error);
        }else{
            NSLog(@"%@",response);
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            getServiceCallBack(jsonData, nil);
        }
    }]resume];
}
@end
