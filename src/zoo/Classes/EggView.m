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
//	if (type == OPERATION_DEFAULT) {
//		[self schedule:@selector(tick:) interval:4.0];
//	}
//	else 
		if(type == OPERATION_PICK_EGG){
			CGPoint location = ccp(self.position.x, self.position.y);
			[[OperationViewController sharedOperationViewController] play:@"pickup" setPosition:location];
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
}

-(void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end
