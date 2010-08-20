//
//  UILayer.m
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UILayer.h"
#import "OperationViewController.h"

@implementation UILayer

-(id) init
{
	if ((self = [super init]))
	{
		playerInfo = [[PlayerInfo alloc] init];
		playerInfo.position = ccp(132, 295);
		[self addChild:playerInfo];
//		[self addChild:playerInfo z:2 tag:999];
		
		zooManageToolbar = [[ZooManageToolbar alloc] init];
		zooManageToolbar.position = ccp(10, 10);
		[self addChild:zooManageToolbar];
		
		storageManageToolbar = [[StorageManageToolbar alloc] init];
		storageManageToolbar.position = ccp(356, 280);
		[self addChild:storageManageToolbar];
		
		friendsToolbar = [[FriendsToolbar alloc] init];
		friendsToolbar.position = ccp(436, 6);
		[self addChild:friendsToolbar];
		
//		friendsPopupList = [[MessageDialog alloc] initDialog:@"FriendList.png" setTarget:self setSelector:@selector(switchFriendZoo)];
//		[self addChild:friendsPopupList];
//		
//		shopPopupList = [[MessageDialog alloc] initDialog:@"store_info.png" setTarget:nil setSelector:nil];
//		[self addChild:shopPopupList];
		
		//Lancy
		purchaseToolbar = [[PurchaseToolbar alloc] init];
		purchaseToolbar.position = ccp(318, 282);
		[self addChild:purchaseToolbar];
		
		
		// Ad by Hunk
		m_SendMailBtn = [[SendMailButton alloc]init];
		m_SendMailBtn.position = ccp(400, 225);
		[self addChild:m_SendMailBtn];
		
	}
	
	return self;
}

-(void) popupFriendList
{
//	[friendsPopupList popUp:@""];
}

-(void) switchPlayerZoo
{
	//[[UIController sharedUIController] swithZoo:NO];
	//isSelf = YES;
	[zooManageToolbar switchZoo:YES];
}
-(void) switchFriendZoo
{
	//[[GameMainScene sharedGameMainScene] swithZoo:YES];
	//isSelf = NO;
	[zooManageToolbar switchZoo:NO];
}


-(void) updateUserInfo
{
	[playerInfo updateUserInfo];
}


// Add by Hunk on 2010-06-29
-(void)dealloc
{
//	[friendsPopupList release];
//	[shopPopupList release];
	[playerInfo release];
	[storageManageToolbar release];
	[zooManageToolbar release];
	[friendsToolbar release];
	
	
	[m_SendMailBtn release];
	
	[super dealloc];
}


@end
