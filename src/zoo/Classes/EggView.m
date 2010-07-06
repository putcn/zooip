//
//  EggView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "EggView.h"
#import "GameMainScene.h"


@implementation EggView
@synthesize eggId;
-(id) init
{
	if ((self = [super init])) {
		pickEggController = [[PickEggToStorageController alloc] init];
		stealEggsController = [[StealEggsFromFarmController alloc] init];
		releaseSnakeController = [[ToReleaseSnakeController alloc] init];
		[[GameMainScene sharedGameMainScene] addSpriteToStage:self z:4];
	}
	return self;
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
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:60 swallowsTouches:YES];
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
	[self callServerController];
	[self optAnimationPlay];
}

-(CGPoint)countCoordinate: (CGPoint)clickPoint
{
	return ccp(self.position.x + clickPoint.x - self.contentSize.width/2, self.position.y + clickPoint.y - self.contentSize.height/2);
}

-(void) postPickEggRequest
{
	
}

-(void)optAnimationPlay
{
	int type = [[UIController sharedUIController] getOperation];
	if (type == OPERATION_DEFAULT) {
		return;
	}
	else 
	if(type == OPERATION_PICK_EGG || type == OPERATION_STEAL_EGG){
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"pickup" setPosition:location];
		
		
	}
	else if(type == OPERATION_RELEASE_SNAKE)
	{
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"put_snake" setPosition:location];
	}
	else {
		return;
	}

	
}

-(void)callServerController
{
	int type = [[UIController sharedUIController] getOperation];
	
	if(type == OPERATION_PICK_EGG)
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
								self.eggId,@"birdEggId",nil];
		pickEggController.eggId = self.eggId;
		[pickEggController execute:params];
	}
	else if(type == OPERATION_STEAL_EGG)
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"thiefId",eggId,@"birdEggId",@"0",@"bodyguard",nil];
		stealEggsController.eggId = self.eggId;
		[stealEggsController execute:params];
	}
	else if(type == OPERATION_RELEASE_SNAKE)
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmId,@"farmId",
								[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"releaserId", @"0",@"bodyguard",nil];
		releaseSnakeController.eggId = self.eggId;
		[releaseSnakeController execute:params];
	}
}

-(void) dealloc
{
	// Add by Hunk on 2010-06-29
	[eggId release];
	[pickEggController release];
	[stealEggsController release];
	[releaseSnakeController release];
	
	
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end
