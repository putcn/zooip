//
//  UILayer.m
//  ZooDemo
//
//  Created by Gu Lei on 10-4-7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UILayer.h"

@implementation UILayer

-(id) init
{
	if ((self = [super init]))
	{
		PlayerInfo *playerInfo = [[PlayerInfo alloc] init];
		playerInfo.position = ccp(140, 302);
		[self addChild:playerInfo];
		
		PlayerManager *playerManager = [[PlayerManager alloc] init];
		playerManager.position = ccp(10, 10);
		[self addChild:playerManager];
		
		ZooManager *zooManage = [[ZooManager alloc] init];
		zooManage.position = ccp(356, 280);
		[self addChild:zooManage];
		
		FriendsList *friendList = [[FriendsList alloc] init];
		friendList.position = ccp(436, 6);
		[self addChild:friendList];
		
		friendsPopupList = [[MessageDialog alloc] initDialog:@"FriendList.png" setTarget:self setSelector:@selector(switchZoo)];
		[self addChild:friendsPopupList];
		
		shopPopupList = [[MessageDialog alloc] initDialog:@"store_info.png" setTarget:nil setSelector:nil];
		[self addChild:shopPopupList];
	}
	
	return self;
}

-(void) popupFriendList
{
	[friendsPopupList popUp:@""];
}

-(void) switchZoo
{
	
}

-(void) popupShopList
{
	[shopPopupList popUp:@""];
}

@end
