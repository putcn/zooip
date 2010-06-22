//
//  FriendsToolbar.h
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Button.h"
#import "MessageDialog.h"
#import "FriendMangePanel.h"

@interface FriendsToolbar : CCSprite
{
	FriendMangePanel *friendView;
	NSString *localMark;
	
}

@end
