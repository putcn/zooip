//
//  UIController.h
//  zoo
//
//  Created by Gu Lei on 10-4-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
	OPERATION_DEFAULT = 0,//默认
	OPERATION_FEED_ALL,//喂食饲料
	OPERATION_FEED_POWER,//喂食营养饲料
	OPERATION_FEED_PRODUCT_YIELD,//喂食增产饲料
	OPERATION_PICK_EGG,//捡蛋
	OPERATION_STEAL_EGG,//偷蛋
	OPERATION_THROW_FIREWORK,//放鞭炮
	OPERATION_CURE_ANIMAL,//治疗
	OPERATION_RELEASE_ANTS,//放蚂蚁
	OPERATION_KILL_ANTS,//灭蚁
	OPERATION_RELEASE_SNAKE,//放蛇
	OPERATION_KILL_SNAKE,//灭蛇
	OPERATION_CLEAR_DEJECTA,//清便
	OPERATION_CALL,//召唤
} ZooOperationType;

@interface UIController : NSObject
{
	int operation;
	NSString *selectFoodId;
}

+(UIController *) sharedUIController;

-(int) getOperation;
-(void) switchOperation:(int)op;
-(NSString *) getSelectFoodId;
-(void) setSelectFoodId:(NSString *)foodId;

@end
