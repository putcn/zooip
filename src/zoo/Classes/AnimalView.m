//
//  AnimalView.m
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AnimalView.h"
#import "GameMainScene.h"

@implementation AnimalView

@synthesize animalId;

-(id) init
{
	if ( (self=[super init]) )
	{
		//uiController = [[UIController sharedUIController] alloc];
		NSArray *dirkeys = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
		NSArray *dirvalues = [NSArray arrayWithObjects:@"up",@"rightUp",@"right",@"rightDown",@"down",@"leftDown",@"left",@"leftUp",nil];
		dirctions = [[NSDictionary dictionaryWithObjects:dirvalues forKeys:dirkeys] retain];
		
		NSArray *stakeys = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",nil];
		NSArray *stavalues = [NSArray arrayWithObjects:@"stop",@"eat",@"ill",@"sleep",@"stand",@"walk",@"fly",@"swimming",@"spread",@"crow",@"transition",@"landing",nil];
		statuses = [[NSDictionary dictionaryWithObjects:stavalues forKeys:stakeys] retain];
		
		animationTable = [[[NSMutableDictionary alloc] init] retain];
		toolTip = [[AnimalToolTip alloc] initWithAnimalId:animalId];
		toolTip.position = ccp(toolTip.contentSize.width/2, 80);
		NSLog(@"toolTip x:%d, y:%d", self.position.x, self.position.y);
		
		[self addChild:toolTip z:5];
		// 在子类中实现这个方法
		// 根据传入的prefix初始化8个方向的动画，
		// 比如prefix是bird，向上走的动画第一帧图片可能就是bird_walk_up_001
		// 初始化后存储到animationTable中
		// [animationTable setObject:动画对象 forKey:键];
		// 使用时通过 [animationTable objectForKey:键] 得到动画对象，之后播发即可
	}
	return self;
}

-(void) update:(int)currDirectionValue status:(int)currStatusValue
{
	
	//映射动物的方向和状态参数
	NSString *direction= [dirctions objectForKey: [NSString stringWithFormat:@"%d",currDirectionValue]];
	NSString *status = [statuses objectForKey: [NSString stringWithFormat:@"%d", currStatusValue]];
	
	CCTexture2D *bg;
	CGRect rect;
	//NSLog(@"当前的动物状态为 ***** %@ *****", [[status stringByAppendingString:@"_"] stringByAppendingFormat:direction]);
	if ([direction isEqualToString:@"right"]) 
	{
		self.flipX =YES;
		direction = @"left";
	}
	else if ([direction isEqualToString:@"rightUp"]) {
		self.flipX =YES;
		direction = @"leftUp";
	}
	else if ([direction isEqualToString:@"rightDown"]){
		self.flipX =YES;
		direction = @"leftDown";
	}
	else 
	{
		self.flipX = NO;
	}
	if ([status isEqualToString:@"stand"] || [status isEqualToString:@"eat") {
		direction = @"left";
	}
	
	NSString *showKey;
	if (currDirectionValue == -1) {
		showKey = status;
	}
	else {
		showKey = [[status stringByAppendingString:@"_"] stringByAppendingFormat:direction];
	}

	//方向: 0-up, 1-rightUp, 2-right, 3-rightDown, 4-down, 5-leftDown, 6-left, 7-leftUp
	//状态: 0-stop(静止动画), 1-eat(吃食), 2-ill(生病), 3-sleep(睡觉), 4-stand(站立图片), 5-walk(行走), 6-fly(飞), 7-swimming(游泳),
	//     8-spread(孔雀开屏),9-crow(公鸡打鸣), 10-trasition(起飞), 11-landing(降落)
	
	if ([status isEqualToString:@"ill"] || [status isEqualToString:@"sleep"] || [status isEqualToString:@"stand"] || [status isEqualToString:@"swimming"])
	{
		[self stopAllActions];
		bg = [animationTable objectForKey:showKey];
		rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture: bg];
		[self setTextureRect: rect];
	}
	else {
		[self stopAllActions];
		[self runAction:[animationTable objectForKey:showKey]];
	}

}

- (CGRect)rect
{
	CGSize s = [self.texture contentSize];
	return CGRectMake(-s.width/2, -s.height/2, s.width, s.height);
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if ( ![self containsTouchLocation:touch] || !self.visible ) return NO;
	self.scale = 1;
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self optAnimationPlay];
	[self callServerController];
}

-(void) popDown
{
	toolTip.visible = false;	 
}

-(void) tick : (ccTime)dt
{
	[self popDown];
	[self unschedule:@selector(tick:)];
}

-(CGPoint)countCoordinate: (CGPoint)clickPoint
{
	return ccp(self.position.x + clickPoint.x - self.contentSize.width/2, self.position.y + clickPoint.y - self.contentSize.height/2);
}

-(void)optAnimationPlay
{
	int type = [[UIController sharedUIController] getOperation];
	if (type == OPERATION_DEFAULT) {
		toolTip.visible = true;
		[self schedule:@selector(tick:) interval:4.0];
	}
	else 
	if(type == OPERATION_CURE_ANIMAL){
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"infusion" setPosition:location];
	}
	else if (type == OPERATION_FEED_POWER)
	{
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"power_food" setPosition:location];
	}
	else if (type == OPERATION_FEED_PRODUCT_YIELD)
	{
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"product_yield_food" setPosition:location];
	}
	else {
		return;
	}

}

-(void)callServerController
{
	int type = [[UIController sharedUIController] getOperation];
	
	if (type == OPERATION_CURE_ANIMAL)
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:animalId,@"animalId",
								[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmerId,@"friendId",nil];
		[cureAnimalController execute:params];
	}
	else if (type == OPERATION_FEED_POWER)
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:animalId,@"animalId",
								[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmerId,@"farmerId",
								[[UIController sharedUIController] getSelectFoodId],@"foodId",nil];
		[feedPowerFoodsController execute:params];
	}
	else if (type == OPERATION_FEED_PRODUCT_YIELD)
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:animalId,@"animalId",
								[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmerId,@"farmerId",
								[[UIController sharedUIController] getSelectFoodId],@"foodId",nil];
		[feedProductYieldFoodController execute:params];
	}
}

-(void) dealloc
{
	[[GameMainScene sharedGameMainScene] removeSpriteFromStage:self];
	[self removeAllChildrenWithCleanup:YES];
	[animationTable release];
	[dirctions release];
	[animationTable release];
	[super dealloc];
}

@end




