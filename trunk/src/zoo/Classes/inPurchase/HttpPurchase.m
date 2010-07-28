//
//  HttpPurchase.m
//  zoo
//
//  Created by shen lancy on 10-7-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HttpPurchase.h"
#import "CJSONDeserializer.h"


@interface HttpPurchase(SubviewFrames)
- (void) RequestParams:(NSDictionary*)params RequestURL:(NSString*) RequestURL;
@end

@implementation HttpPurchase

@synthesize clientProtocol;

- (void) RequestParams:(NSDictionary*)params RequestURL:(NSString*) RequestURL{
	
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
											  requestWithURL:[NSURL URLWithString:RequestURL]];
	[connectionRequest setHTTPMethod:@"POST"];
	[connectionRequest setTimeoutInterval:100.0];
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
	NSString *stringFromUnichar = [NSString stringWithCharacters:(unichar*)[data bytes] length:[data length] / sizeof(unichar)];
	//	NSLog(stringFromUnichar);
	return;
}


//成功调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	//取到字符串
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
	NSString *stringFromUnichar = [NSString stringWithCString:(char*)[receivedData bytes] length:[receivedData length] / sizeof(char)];
	//	NSLog(stringFromUnichar);
	
	[receivedData release];
	receivedData = nil;
	
	//字符串转换
	NSData *jsonData = [stringFromUnichar dataUsingEncoding:NSUTF32BigEndianStringEncoding];
	NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
	
	NSLog(@"%@",dictionary);
	
	NSString* resp = [dictionary objectForKey:@"resp"];
	//报错处理
	if([resp compare:@"fail"] == NSOrderedSame){
		
	}
	else {
				
		switch (clientProtocol) {
				
			case MJBank_Store_Protocol:{
	//			pInstance->SetHttpBack(dictionary,MJBank_Store_Protocol);
			}
				break;
				
		
			case Server_Chk:{				
	//			pInstance->SetHttpBack(dictionary,MJBank_Consumer_store);				
			}
				break;
				
			default:
				break;
		}
	}	
}

@end
