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


@implementation ServiceHelper
static ServiceHelper *sharedInst = nil;
static NSString *serviceBaseURL = @"http://zoo.hotpod.jp/fplatform/farmv4/mixi/php/remoteService.php";
static NSString *testingFarmerId = @"A6215BF61A3AF50A8F72F043A1A6A85C";
static NSString *testingFarmId = @"163D7A78682082B36872659C7A9DA8F9";

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
		callBacks = [[NSMutableDictionary alloc] init];
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
	NSDictionary *targetCallBack = [callBacks objectForKey:request.requestFlagMark];
	
	BOOL shouldTriggerErrorHandler = NO;
	
	if ([[result objectForKey:@"error_code"] intValue] == 100) {
		shouldTriggerErrorHandler = YES;
	}
	
	if(shouldTriggerErrorHandler){
		[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"onfailed"]) withObject:result];
	}else {
		[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"onsuccess"]) withObject:result];
	}
	
	//clean up
	[targetCallBack release];

}

-(void)requestWentWrong:(ASIFormDataRequest *)request{ //http error, TBD
	NSLog(@"request %@ went wrong with status code %d, and feedback body %@",request.requestFlagMark, [request responseStatusCode], [request responseString]);
}

-(ASIFormDataRequest *)buildRequestWithURL:(NSString *)URLString AndRequestFlag:(NSString *)requestFlag AndCallBackScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector{
	
	NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:CallBackDelegate, @"delegate", SuccessSelector, @"onsuccess", FailedSelector, @"onfailed", nil];
	[tempDic retain];
	[callBacks setObject:tempDic forKey:requestFlag];
	
	NSURL *url = [NSURL URLWithString:URLString];
	
	NSLog(@"%@",url);
	
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	request.requestFlagMark = requestFlag;
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestWentWrong:)];
	[request setRequestMethod:@"POST"];
	//set testing uid and pid
	[request setPostValue:@"25313321" forKey:@"uid"];
	[request setPostValue:@"11" forKey:@"pid"];
	return request;
}

-(void)connectivityTestWithScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector{
	//save selector and delegate
	NSString *flagMark = @"connectivityTest";
	ASIFormDataRequest *request = [self buildRequestWithURL:serviceBaseURL AndRequestFlag:flagMark AndCallBackScope:CallBackDelegate AndSuccessSel:SuccessSelector AndFailedSel:FailedSelector];
	[request setPostValue:@"getFarmerInfo" forKey:@"method"];
	[request startAsynchronous];
}

-(void)getFarmInfoWithFarmerId:(NSString *)farmerId AndIsbodyGarded:(BOOL)IsbodyGarded AndScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector{
	NSString *flagMark = @"getFarmInfoWithFarmerId";
	ASIFormDataRequest *request = [self buildRequestWithURL:serviceBaseURL AndRequestFlag:flagMark AndCallBackScope:CallBackDelegate AndSuccessSel:SuccessSelector AndFailedSel:FailedSelector];
	[request setPostValue:@"getFarmInfo" forKey:@"method"];
	if (!farmerId) {
		farmerId = testingFarmerId;
	}
	[request setPostValue:farmerId forKey:@"farmerId"];
	NSInteger bodyGarded = 0;
	if (IsbodyGarded) {
		bodyGarded = 1;
	}
	[request setPostValue:[NSString stringWithFormat:@"%d",bodyGarded] forKey:@"bodyguard"];
	[request startAsynchronous];
}

-(void)getAllBirdFarmAnimalInfoWithFarmId:(NSString *)farmId AndFarmerId:(NSString *)farmerId AndScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector{
	NSString *flagMark = @"getAllBirdFarmAnimalInfoWithFarmId";
	ASIFormDataRequest *request = [self buildRequestWithURL:serviceBaseURL AndRequestFlag:flagMark AndCallBackScope:CallBackDelegate AndSuccessSel:SuccessSelector AndFailedSel:FailedSelector];
	[request setPostValue:@"getAllBirdFarmAnimalInfo" forKey:@"method"];
	if (!farmId) {
		farmId = testingFarmId;
	}
	[request setPostValue:farmId forKey:@"farmId"];
	if (!farmerId) {
		farmerId = testingFarmerId;
	}
	[request setPostValue:farmerId forKey:@"farmerId"];
	[request startAsynchronous];
}


@end
