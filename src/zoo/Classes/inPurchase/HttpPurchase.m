//
//  HttpPurchase.m
//  zoo
//
//  Created by shen lancy on 10-7-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HttpPurchase.h"
#import "CJSONDeserializer.h"

static HttpPurchase *sharedPur = nil;
static NSString *ServiceBaseURL = @"http://211.166.9.250/fplatform/farmv4/xiaonei/php/remoteServiceiPhone.php";

@implementation HttpPurchase

@synthesize clientProtocol, connectOver, callBacks;

+ (id)sharedPurchase{
    @synchronized( self ) {
        if ( sharedPur == nil ) {
            /* sharedInst set up in init */
            [[self alloc] init];
        }
    }
	
    return sharedPur;
}

- (id)init{
    if ( sharedPur != nil ) {
		
	} else if ( (self = [super init]) ) {
		callBacks = [[NSMutableDictionary alloc] init];
		sharedPur = self;		
	}
	return sharedPur;
}

- (void) RequestParams:(NSDictionary*)params{
	
	NSDictionary* postParams = params;		
	NSLog(@"%@",postParams);
	
	//发送数据
	NSMutableData* body = [NSMutableData data];		
	for (id key in [postParams keyEnumerator]) {
		NSLog(@"%@",key);
		[body appendData:[[NSString
						   stringWithFormat:@"%@=", key]
						  dataUsingEncoding:NSUTF8StringEncoding]];
		NSLog(@"%@",[postParams valueForKey:key]);
		[body appendData:[[postParams valueForKey:key] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"&"]dataUsingEncoding:NSUTF8StringEncoding]];
	}		
	NSLog(@"%@",body);
	
	
	//发送
	NSMutableURLRequest *connectionRequest = [NSMutableURLRequest 
											  requestWithURL:[NSURL URLWithString:ServiceBaseURL]];
	[connectionRequest setHTTPMethod:@"POST"];
	[connectionRequest setTimeoutInterval:10.0];
	[connectionRequest setCachePolicy:NSURLRequestUseProtocolCachePolicy];
	[connectionRequest setHTTPBody:body];
	
	if (nil !=  connection) {
		
		[connection release];
		connection = nil;
	}
	connection = [[NSURLConnection alloc] initWithRequest:connectionRequest delegate:self];
	if (nil != receivedData) {
		[receivedData release];
		receivedData = nil;
	}
	receivedData = [[NSMutableData alloc] initWithLength:0];
}

- (void) getStoreList{
	
	
}

- (void) storeChk{
	
}

- (void) dealloc{
	
	[connection release];
	[receivedData release];
	[callBacks release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSURLConnection Delegate

//错误处理
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error {  
	
	UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:@"交易失败" message:@"请确认网络状态" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
	[addAlert show];
	[addAlert release];
}

//构造一个NSURLResponse对象
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	if (receivedData != nil) {
		[receivedData release];
		receivedData = nil;
	}
	receivedData=[[NSMutableData data] retain];
    [receivedData setLength:0];
}


//获取数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];
	//  NSString *stringFromUnichar = [NSString stringWithCharacters:(unichar*)[data bytes] length:[data length] / sizeof(unichar)];
	//	NSLog(stringFromUnichar);
	return;
}


//成功调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	//取到字符串
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
	NSString *stringFromUnichar = [NSString stringWithCString:(char*)[receivedData bytes] length:[receivedData length] / sizeof(char)];
	NSLog(@"%@",stringFromUnichar);
	
	[receivedData release];
	receivedData = nil;
	
	//字符串转换
	NSData *jsonData = [stringFromUnichar dataUsingEncoding:NSUTF32BigEndianStringEncoding];
	NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
	
	NSLog(@"%@",dictionary);
	
	switch (clientProtocol) {
			
		case MJBank_Store_Protocol:{
			[callBacks setDictionary:dictionary];
			
		}
			break;
			
		case Server_Chk:{				
			[callBacks setDictionary:dictionary];
		}
			break;
			
		default:
			break;
	}
	
	connectOver = YES;
}

@end
