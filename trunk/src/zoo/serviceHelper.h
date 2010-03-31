//
//  serviceHelper.h
//  zoo
//
//  Created by Darcy on 3/30/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface serviceHelper : NSObject {
	NSMutableDictionary *CallBacks;
}

+ (serviceHelper *)sharedService;
- (void) restore;
-(ASIFormDataRequest *)BuildRequestWithURL:(NSString *)URLString AndRequestFlag:(NSString *)requestFlag AndCallBackScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector;
-(void)connectivityTest;
@end
