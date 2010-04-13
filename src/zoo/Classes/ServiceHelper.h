//
//  ServiceHelper.h
//  zoo
//
//  Created by Darcy on 3/30/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

// testing farmer id : A6215BF61A3AF50A8F72F043A1A6A85C
// testing uid : 25313321
// testing pid : 11
// 

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface ServiceHelper : NSObject {
	NSMutableDictionary *callBacks;
}

+ (ServiceHelper *)sharedService;
- (void) restore;
-(ASIFormDataRequest *)buildRequestWithURL:(NSString *)URLString AndRequestFlag:(NSString *)requestFlag AndCallBackScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector;
-(void)connectivityTestWithScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector;
-(void)getFarmInfoWithFarmerId:(NSString *)farmerId AndIsbodyGarded:(BOOL)IsbodyGarded AndScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector;
-(void)getAllBirdFarmAnimalInfoWithFarmId:(NSString *)farmerId AndFarmerId:(NSString *)farmerId AndScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector;
@end
