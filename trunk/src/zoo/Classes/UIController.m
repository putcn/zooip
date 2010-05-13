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

static NSString *OPERATION_DEFAULT = @"operation_default";//默认
static NSString *OPERATION_FEED_ALL = @"operation_feed_all";//喂食饲料
static NSString *OPERATION_FEED_POWER = @"operation_feed_power";//喂食营养饲料
static NSString *OPERATION_FEED_PRODUCT_YIELD = @"operation_feed_product_yield";//喂食增产饲料
static NSString *OPERATION_PICK_EGG = @"operation_pick_egg";//捡蛋
static NSString *OPERATION_THROW_FIREWORK = @"operation_throw_firework";//放鞭炮
static NSString *OPERATION_CURE_ANIMAL = @"operation_cure_animal";//治疗
static NSString *OPERATION_RELEASE_ANTS = @"operation_release_ants";//放蚂蚁
static NSString *OPERATION_KILL_ANTS = @"operation_kill_ants";//灭蚁
static NSString *OPERATION_RELEASE_SNAKE = @"operation_release_snake";//放蛇
static NSString *OPERATION_KILL_SNAKE = @"operation_kill_snake";//灭蛇
static NSString *OPERATION_CLEAR_DEJECTA = @"operation_clear_dejecta";//清便
static NSString *OPERATION_CALL = @"operation_call";//召唤

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

-(void) switchOperation:(NSString *)op
{
	operation = op;
}

@end
