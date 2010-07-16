//
//  AntView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AntView.h"
#import "GameMainScene.h"
#import "RandomHelper.h"

@implementation AntView
@synthesize antId;

-(id) initWithID: (NSString *)sId
{
	if ((self = [super init])) 
	{
		self.position = ccp([RandomHelper getRandomNum:300 to:400],[RandomHelper getRandomNum:100 to:200]);
		killAntsController = [[KillAntsController alloc] init];
		antId = sId;
		animation = [[CCAnimation animationWithName:@"animal" delay:0.5] retain];
		for (int i = 1; i <= 4; i++) 
		{
			[animation addFrameWithFilename:[NSString stringWithFormat:@"ant_%02d.png", i]];
		}
		[[GameMainScene sharedGameMainScene] addSpriteToStage:self z:5];
	}
	return self;
}

-(void)update:(int)currDirectionValue status:(int)currStatusValue
{
	NSString *direction= [dirctions objectForKey: [NSString stringWithFormat:@"%d",currDirectionValue]];
	CCRepeatForever *repeatAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
	[self stopAllActions];
	self.rotation = 0;
	if (direction == @"left") 
	{
		[self runAction:repeatAction];
	}
	if (direction == @"leftUp") 
	{
		[self runAction:repeatAction];
	}
	else if(direction == @"up")
	{
		self.rotation = 90;
		[self runAction:repeatAction];
	}
	else if(direction == @"rightUp")
	{
		self.rotation = 135;
		[self runAction:repeatAction];
	}
	else if(direction == @"right")
	{
		self.rotation = 180;
		[self runAction:repeatAction];
	}
	else if(direction == @"rightDown")
	{
		self.rotation = 225;
		[self runAction:repeatAction];
	}
	else if(direction == @"down")
	{
		self.rotation = 270;
		[self runAction:repeatAction];
	}
	else if(direction == @"leftDown")
	{
		self.rotation = 325;
		[self runAction:repeatAction];
	}
}

- (CGRect)rect
{
	CGSize s = [self contentSize];
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
	[self optAnimationPlay];
	[self callServerController];
}

-(CGPoint)countCoordinate: (CGPoint)clickPoint
{
	return ccp(self.position.x + clickPoint.x - self.contentSize.width/2, self.position.y + clickPoint.y - self.contentSize.height/2);
}

-(void)optAnimationPlay
{
	int type = [[UIController sharedUIController] getOperation];
	if(type == OPERATION_KILL_ANTS){
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"pesticide" setPosition:location];
	}
	else {
		return;
	}
	
}

-(void)callServerController
{
	int type = [[UIController sharedUIController] getOperation];
	
	if (type == OPERATION_KILL_ANTS)
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:antId,@"releaseAntsId",
								[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"killerId",
								[DataEnvironment sharedDataEnvironment].friendFarmerInfo.farmerId,@"farmerId",nil];
		killAntsController.antId = self.antId;
		[killAntsController execute:params];
	}
}

-(void) dealloc
{
	// Add by Hunk on 2010-06-29
	[dirctions release];
	[animation release];
	[antId release];
	[killAntsController release];
	
	
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}


@end
