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
	if(itemType == @"chinemy"){
		ChinemyView *chinemyView = [[ChinemyView alloc] init];
		chinemyView.position = ccp(700, 300);
	}
	else if(itemType == @"dog"){
		DogView *dogView = [[DogView alloc] init];
		dogView.position = ccp(650,450);
	}
	else if(itemType == @"bowls"){
		double foodEndTime = (double)[DataEnvironment sharedDataEnvironment].playerFarmInfo.farm_foodEndTime;
		NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
		double intervalTime = foodEndTime - (double)currentTime;
		[[BowlsView alloc] initWithFoodEndTime:intervalTime];
	}
	else {
		return;
	}

}


@end
