//
//  FriendsToolbar.m
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FriendsToolbar.h"
#import "AnimalController.h"
#import "EggController.h"
#import "ItemController.h"
#import "DejectaController.h"
#import "AntController.h"
#import "SnakeController.h"


@implementation FriendsToolbar

-(id) init
{
	self = [super init];
	
	if (self)
	{
		Button *button;
		
		button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"好友图标.png" setTarget:self
								   setSelector:@selector(btnButtonHandler) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
		button.position = ccp(20, 20);
		[self addChild:button];
	}
	
	return self;
}

-(void) btnButtonHandler
{
	[[EggController sharedEggController] clearEgg];
	[[AnimalController sharedAnimalController] clearAnimal];
	[[ItemController sharedItemController] clearItems];
	[[DejectaController sharedDejectaController] clearDejectas];
	[[AntController sharedAntController] clearAnts];
	[[SnakeController sharedSnakeController] clearSnakes];
}

@end
