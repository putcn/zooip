//
//  ItemController.m
//  zoo
//
//  Created by Rainbow on 5/17/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ItemController.h"


@implementation ItemController

static ItemController *_itemController = nil;

+(ItemController *) sharedItemController
{
	@synchronized([ItemController class])
	{
		if (!_itemController)
		{
			_itemController = [[ItemController alloc] init];
		}
		
		return _itemController;
	}
	
	return nil;
}

-(void) addItem:(NSString *)itemType
{
	if (itemType == @"snake") {
		[[SnakeView alloc] init];
	}
	else if(itemType == @"ant"){
		[[AntView alloc] init];
	}
	else if(itemType == @"chinemy"){
		[[ChinemyView alloc] init];
	}
	else if(itemType == @"dog"){
		[[DogView alloc] init];
	}
	else if(itemType == @"bowls"){
		[[BowlsView alloc] init];
	}
	else if(itemType == @"dejecta"){
		[[DejectaView alloc] initWithPosition:ccp(400,200)];
	}
	else {
		return;
	}

}


@end
