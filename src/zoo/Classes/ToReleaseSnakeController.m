//
//  ToReleaseSnakeController.m
//  zoo
//
//  Created by Rainbow on 6/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ToReleaseSnakeController.h"
#import "ServiceHelper.h"
#import "DataEnvironment.h"
#import "DataModelSnake.h"
#import "SnakeController.h"
#import "EggController.h"
#import "GameMainScene.h"


@implementation ToReleaseSnakeController
@synthesize eggId;
-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoReleaseSnake WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if (code == 1) {
		NSString *snakeId = [result objectForKey:@"releaseSnakeId"];
		DataModelSnake *dataModelSnake = [[DataModelSnake alloc] init];
		dataModelSnake.eggId = eggId;
		dataModelSnake.releaseSnakeId = snakeId;
		[[DataEnvironment sharedDataEnvironment].snakes setObject:dataModelSnake forKey:snakeId];
		[[SnakeController sharedSnakeController] addSnakes:[NSArray arrayWithObject:snakeId]];
	
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"放蛇成功"];
	}
	if(code == 2)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"今天放蛇数量超标"];
	}
	if(code == 3)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"蛇没放成功，逃跑了"];
		[self fleeAnimation];
	}
	if(code == 4)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不能在自己农场放蛇"];
	}
	if(code == 5)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"掉金币"];
	}
	if(code == 6)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"偷窃者无金蛋"];
	}
	if(code == 7)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"蛇吃了一个蛋，跑掉了"];
	}
	if(code == 8)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"蛇数量超过农场最大量"];
	}
	if(code == 0)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"农场蛇数量超标"];
	}
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

-(CGPoint) eggPosition
{
	EggView *eggView = (EggView *)[[EggController sharedEggController].allEggs objectForKey:eggId];
	return eggView.position;
	
}

-(void) releaseAnimation
{
	CCSprite *sprite = [CCSprite node];
	[sprite setAnchorPoint:CGPointMake(0, 0.5)];
	CCAnimation* animation = [CCAnimation animationWithName:@"releaseSanke" delay:0.04f];
	for (int i = 1; i<=3; i++) {
		[animation addFrameWithFilename:[NSString stringWithFormat:@"snake_sleep_%02d.png", i]];
	}
	CCAnimate *animate = [CCAnimate actionWithAnimation:animation];
	sprite.position = [self eggPosition];
	[sprite runAction:animate]; 
	[[GameMainScene sharedGameMainScene] addSpriteToStage:sprite z:10];
}

-(void) fleeAnimation
{
	CCSprite *sprite = [CCSprite node];
	[sprite setAnchorPoint:CGPointMake(0, 0.5)];
	CCAnimation* animation = [CCAnimation animationWithName:@"releaseSanke" delay:0.1f];
	for (int i = 1; i<=16; i++) {
		[animation addFrameWithFilename:[NSString stringWithFormat:@"snake_walk_left_%02d.png", i]];		
	}
	CCAnimate *animate = [CCAnimate actionWithAnimation:animation];
	sprite.position = [self eggPosition];
	CCMoveTo *moveTo = [CCMoveTo actionWithDuration:2.0f position:ccp(sprite.position.x + 50, sprite.position.y)];
	[sprite runAction:[CCSpawn actions:animate, moveTo, nil]];
	[[GameMainScene sharedGameMainScene] addSpriteToStage:sprite z:10];
	
}


@end
