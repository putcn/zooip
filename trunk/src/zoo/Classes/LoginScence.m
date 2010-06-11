//
//  LoginScence.m
//  zoo
//
//  Created by Gu Lei on 10-6-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoginScence.h"
#import "ASIHTTPRequest.h"
#import "GameMainScene.h"

static NSString* kApiKey = @"b856de458be342f4a80a4e2cc824f146";
static NSString* kApiSecret = @"8426c76e6db84d70bb6516fdf3a4ec34";

@implementation LoginScence

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LoginScence *layer = [LoginScence node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] ))
	{
		NSHTTPCookie* renrenConnectCookie = [NSHTTPCookie cookieWithProperties:
											 [NSDictionary dictionaryWithObjectsAndKeys:
											  @"beta", NSHTTPCookieValue,
											  @"iphone-connect", NSHTTPCookieName,
											  @".renren.com", NSHTTPCookieDomain,
											  @"/", NSHTTPCookiePath,
											  nil]];
		
		[[ASIHTTPRequest sessionCookies] addObject:renrenConnectCookie];
		
		[[Session sessionForApplication:kApiKey secret:kApiSecret delegate:self] retain];
		
		LoginDialog * dialog = [[LoginDialog alloc] init];
		[dialog show];
		[dialog release];
	}
	
	return self;
}

- (void)session:(Session*)session didLogin:(RRUID)uid
{
	
	[[CCDirector sharedDirector] replaceScene:[GameMainScene scene]];
	//[[Request requestWithDelegate:self] call:@"users.getInfo" params:nil];
}

- (void)request:(Request*)request didLoad:(id)result
{
	if([request.method isEqualToString:@"users.getInfo"])
	{
		NSArray* users = result;
		NSDictionary* user = [users objectAtIndex:0];
		NSString* name = [user objectForKey:@"name"];
		NSString* originheadUrl = [user objectForKey:@"tinyurl"];
		NSMutableString* headUrl = [NSMutableString string];
		
		//[[CCDirector sharedDirector] popScene];
		[[CCDirector sharedDirector] replaceScene:[GameMainScene scene]];
	}
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
