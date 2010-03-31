//
//  serviceHelper.m
//  zoo
//
//  Created by Darcy on 3/30/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "serviceHelper.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"


@implementation serviceHelper
static serviceHelper *sharedInst = nil;

+ (id)sharedService{
    @synchronized( self ) {
        if ( sharedInst == nil ) {
            /* sharedInst set up in init */
            [[self alloc] init];
        }
    }
	
    return sharedInst;
}

- (id)init{
    if ( sharedInst != nil ) {
		
	} else if ( (self = [super init]) ) {
		CallBacks = [[NSMutableDictionary alloc] init];
		sharedInst = self;
		[self restore];
		
	}
	return sharedInst;
}


- (NSUInteger)retainCount{
	return NSUIntegerMax;
}

- (oneway void)release{
}

- (id)retain{
	return sharedInst;
}

- (id)autorelease{
	return sharedInst;
}

- (void) restore{
	
}

-(void)requestDone:(ASIFormDataRequest *)request{
	NSLog(@"feed back for action : %@, is : %@",request.requestFlagMark,[request responseString]);
	
	NSData *jsonData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *result = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
	NSDictionary *targetCallBack = [CallBacks objectForKey:request.requestFlagMark];
	
	BOOL shouldTriggerErrorHandler = NO;
	
	if ([[result objectForKey:@"error_code"] intValue] == 100) {
		shouldTriggerErrorHandler = YES;
	}
	
	if(shouldTriggerErrorHandler){
		[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"onfailed"]) withObject:[result objectForKey:@"error_code"]];
	}else {
		[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"onsuccess"]) withObject:result];
	}
	
	//clean up
	[targetCallBack release];

}

-(void)requestWentWrong:(ASIFormDataRequest *)request{
	NSLog(@"request %@ went wrong with status code %d, and feedback body %@",request.requestFlagMark, [request responseStatusCode], [request responseString]);
	NSDictionary *targetCallBack = [CallBacks objectForKey:request.requestFlagMark];
	[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"onfailed"]) withObject:[request responseString]];
}

-(ASIFormDataRequest *)BuildRequestWithURL:(NSString *)URLString AndRequestFlag:(NSString *)requestFlag AndCallBackScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector{
	
	NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:CallBackDelegate, @"delegate", SuccessSelector, @"onsuccess", FailedSelector, @"onfailed", nil];
	[tempDic retain];
	[CallBacks setObject:tempDic forKey:requestFlag];
	
	NSURL *url = [NSURL URLWithString:URLString];
	
	NSLog(@"%@",url);
	
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	request.requestFlagMark = requestFlag;
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestWentWrong:)];
	return request;
}

-(void)connectivityTestWithScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector{
	//save selector and delegate
	NSString *flagMark = @"connectivityTest";
	NSString *urlString = @"http://zoo.hotpod.jp/fplatform/farmv4/mixi/php/remoteService.php";
	ASIFormDataRequest *request = [self BuildRequestWithURL:urlString AndRequestFlag:flagMark AndCallBackScope:CallBackDelegate AndSuccessSel:SuccessSelector AndFailedSel:FailedSelector];
	[request setPostValue:@"getFarmerInfo" forKey:@"method"];
	[request setPostValue:@"25313321" forKey:@"uid"];
	[request setPostValue:@"11" forKey:@"pid"];
	[request setRequestMethod:@"POST"]; 
	[request startAsynchronous];
}


@end
