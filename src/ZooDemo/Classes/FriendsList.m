//
//  FriendsList.m
//  ZooDemo
//
//  Created by Gu Lei on 10-4-7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FriendsList.h"


@implementation FriendsList

-(id) init
{
	self = [super init];
	
	if (self)
	{
		Button *button;
		
		//拖拽
		button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"好友图标.png" setTarget:self
								   setSelector:@selector(btnButtonHandler) setPriority:0 offsetX:-1 offsetY:2];
		button.position = ccp(20, 20);
		[self addChild:button];
	}
	
	return self;
}

-(void) btnButtonHandler
{
	[self.parent popupFriendList];
}

@end
