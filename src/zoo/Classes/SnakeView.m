//
//  SnakeView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "SnakeView.h"
#import "RandomHelper.h"
#import "GameMainScene.h"

@implementation SnakeView
@synthesize snakeId;
-(id) initWithID: (NSString *)sId
{
	if ((self = [super init])) {
		killSnakeController = [[KillSnakeController alloc] init];
		snakeId = sId;
		CCTexture2D *snake = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"snake.png" ofType:nil]]];
		CGRect rect = CGRectZero;
		rect.size = snake.contentSize;
		[self setTexture: snake];
		[self setTextureRect: rect]; 
		self.position = ccp([RandomHelper getRandomNum:500 to:700],[RandomHelper getRandomNum:100 to:300]);
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
	if(type == OPERATION_KILL_SNAKE){
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"net" setPosition:location];
	}
	else {
		return;
	}
	
}

-(void)callServerController
{
	int type = [[UIController sharedUIController] getOperation];
	
	if (type == OPERATION_KILL_SNAKE)
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:snakeId,@"releaseSnakeId",
								[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"killerId",
								[DataEnvironment sharedDataEnvironment].friendFarmerInfo.farmerId,@"farmerId",nil];
		killSnakeController.snakeId = snakeId;
		[killSnakeController execute:params];
	}
}

-(void) dealloc
{
	// Add by Hunk on 2010-06-29
	[killSnakeController release];
	
	
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end
