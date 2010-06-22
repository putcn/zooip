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
#import "DataEnvironment.h"

static NSString* kApiKey = @"6783ae2a188f4367b101a8a669c9f088";
static NSString* kApiSecret = @"204df2c367e148839f33fb2b1e56fcc5";

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
	if (uid > 0)
	{
		[DataEnvironment sharedDataEnvironment].playerUid = [NSString stringWithFormat:@"%d", uid];
		[[Request requestWithDelegate:self] call:@"friends.getAppFriends" params:nil];
	}
}

- (void)request:(Request*)request didLoad:(id)result
{
	if([request.method isEqualToString:@"users.getInfo"])
	{
		NSArray *users = result;
		
		NSMutableDictionary *friendInfosDic = [DataEnvironment sharedDataEnvironment].friendInfos;
		for (NSDictionary *user in users)
		{
			NSString *uid = [user objectForKey:@"uid"];
			NSString *name = [user objectForKey:@"name"];
			NSString *tinyHeadUrl = [user objectForKey:@"tinyurl"];
			
			DataModelFriendInfo *friendInfo = [friendInfosDic objectForKey:uid];
			
			if (friendInfo != nil)
			{
				friendInfo.userName = name;
				friendInfo.tinyurl = tinyHeadUrl;
			}
			else
			{
				continue;
			}
			
//			if ([uid isEqualToString:[DataEnvironment sharedDataEnvironment].playerUid])
//			{
//				
//			}
//			else
//			{
//				
//			}
		}
		
		//[[CCDirector sharedDirector] popScene];
		[[CCDirector sharedDirector] replaceScene:[GameMainScene scene]];
	}
	if([request.method isEqualToString:@"friends.getAppFriends"])
	{
		NSArray *friendIDs = result;
		
		for (NSString *friendID in friendIDs)
		{
			[[DataEnvironment sharedDataEnvironment].friendIDs addObject:friendID];
			
			DataModelFriendInfo *friendInfo = [[DataModelFriendInfo alloc] init];
			friendInfo.uid = friendID;
			[[DataEnvironment sharedDataEnvironment].friendInfos setValue:friendInfo forKey:friendID];
		}
		
		//Add player to friend list...
		[[DataEnvironment sharedDataEnvironment].friendIDs addObject:[DataEnvironment sharedDataEnvironment].playerUid];
		
		DataModelFriendInfo *playerInfo = [[DataModelFriendInfo alloc] init];
		playerInfo.uid = [DataEnvironment sharedDataEnvironment].playerUid;
		[[DataEnvironment sharedDataEnvironment].friendInfos setValue:playerInfo forKey:playerInfo.uid];
		
		NSString *uids = [[DataEnvironment sharedDataEnvironment].friendIDs componentsJoinedByString:@","];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uids,@"uids",nil];
		
		[[Request requestWithDelegate:self] call:@"users.getInfo" params:params];
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
