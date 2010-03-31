//
//  serviceHelper.m
//  zoo
//
//  Created by Darcy on 3/30/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "serviceHelper.h"
#import "ASIFormDataRequest.h"


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
}

-(void)requestWentWrong:(ASIFormDataRequest *)request{
	NSLog(@"request %@ went wrong with status code %d, and feedback body %@",request.requestFlagMark, [request responseStatusCode], [request responseString]);
}

-(ASIFormDataRequest *)BuildRequestWithURL:(NSString *)URLString AndRequestFlag:(NSString *)requestFlag AndCallBackScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector{
	
	NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:CallBackDelegate, @"delegate", SuccessSelector, @"onsuccess", FailedSelector, @"onfailed", nil];
	[tempDic retain];
	[CallBacks setObject:tempDic forKey:requestFlag];
	
	NSURL *url = [NSURL URLWithString:URLString];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	request.requestFlagMark = requestFlag;
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestWentWrong:)];
	return request;
}

-(void)connectivityTest{
	//save selector and delegate
	NSString *flagMark = @"connectivityTest";
	NSString *urlString = @"http://zoo.hotpod.jp/fplatform/farmv4/mixi/php/remoteService.php?method=addNewUserInfo&uid=111&pid=11&name=test&pic=http://img.user.head.jpg";
	
	ASIFormDataRequest *request = [self BuildRequestWithURL:urlString AndRequestFlag:flagMark AndCallBackScope:self AndSuccessSel:@"" AndFailedSel:@""];
	
	[request startAsynchronous];
	
}


@end
