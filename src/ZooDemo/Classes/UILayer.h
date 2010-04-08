//
//  UILayer.h
//  ZooDemo
//
//  Created by Gu Lei on 10-4-7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "GameMainScene.h"
#import "PlayerInfo.h"
#import "PlayerManager.h"
#import "ZooManager.h"
#import "FriendsList.h"

@interface UILayer : CCLayer
{
	MessageDialog *friendsPopupList;
	MessageDialog *shopPopupList;
	PlayerManager *playerManager;
	
	Boolean isSelf;
}

@end
