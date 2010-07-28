//
//  UILayer.h
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "UIController.h"
#import "PlayerInfo.h"
#import "ZooManageToolbar.h"
#import "StorageManageToolbar.h"
#import "FriendsToolbar.h"
#import "PurchaseToolbar.h"

@interface UILayer : CCLayer
{	
	PlayerInfo *playerInfo;
	StorageManageToolbar *storageManageToolbar;
	ZooManageToolbar *zooManageToolbar;
	FriendsToolbar *friendsToolbar;
	
	//Lancy
	PurchaseToolbar *purchaseToolbar;
}

-(void) updateUserInfo;
-(void) switchPlayerZoo;
-(void) switchFriendZoo;

@end
