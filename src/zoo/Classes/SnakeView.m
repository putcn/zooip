//
//  SnakeView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "SnakeView.h"


@implementation SnakeView
@synthesize snakeId;
-(id) initWithID: (NSString *)sId
{
	if ((self = [super init])) {
		snakeId = sId;
		CCTexture2D *snake = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_0.png" ofType:nil]]];
		CGRect rect = CGRectZero;
		rect.size = snake.contentSize;
		[self setTexture: snake];
		[self setTextureRect: rect]; 
		DataModelSnake *dataModelSnake =  (DataModelSnake *)[[DataEnvironment sharedDataEnvironment].snakes objectForKey:snakeId];
		NSString *eggId = dataModelSnake.eggId;
		[dataModelSnake dealloc];
		EggView *eggView = (EggView *)[[EggController sharedEggController].allEggs objectForKey:eggId];
		CGPoint eggPos = eggView.position;
		[eggView dealloc];
		self.position = eggPos;
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
	[self optAnimationPlay];
}

-(CGPoint)countCoordinate: (CGPoint)clickPoint
{
	return ccp(self.position.x + clickPoint.x - self.contentSize.width/2, self.position.y + clickPoint.y - self.contentSize.height/2);
}

-(void)optAnimationPlay
{
	int type = OPERATION_KILL_SNAKE;
	if (type == OPERATION_DEFAULT) {
		[self schedule:@selector(tick:) interval:4.0];
	}
	else 
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
	
}

@end
