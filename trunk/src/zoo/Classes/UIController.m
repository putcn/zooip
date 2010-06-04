//
//  UIController.m
//  zoo
//
//  Created by Gu Lei on 10-4-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UIController.h"


@implementation UIController

static UIController *_sharedUIController = nil;

+(UIController *)sharedUIController
{
	@synchronized([UIController class])
	{
		if (!_sharedUIController)
		{
			_sharedUIController = [[UIController alloc] init];
		}
		
		return _sharedUIController;
	}
	
	return nil;
}

-(void) notify:(NSNotification *)notification
{
	//id notificationSender = [notification object];
}

-(int) getOperation
{
	return operation;
}

-(void) switchOperation:(int)op
{
	operation = op;
}

-(NSString *) getSelectFoodId
{
	return selectFoodId;
}

-(void) setSelectFoodId:(NSString *)foodId
{
	selectFoodId = foodId;
	
	//TODO: 根据食物ID进行操作分类
	if (selectFoodId == @"1")
	{
		operation = OPERATION_FEED_ALL;
	}
	else if (selectFoodId == @"2" || selectFoodId == @"3" || selectFoodId == @"4")
	{
		operation = OPERATION_FEED_POWER;
	}
	else if (selectFoodId == @"5")
	{
		operation = OPERATION_FEED_PRODUCT_YIELD;
	}
}

@end
