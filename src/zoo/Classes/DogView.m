//
//  DogView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DogView.h"


@implementation DogView
@synthesize dogId;
-(id) initWithID: (NSString *)sId
{
	if((self = [super init]))
	{
		dogId = sId;
		NSArray *dirkeys = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
		NSArray *dirvalues = [NSArray arrayWithObjects:@"up",@"rightUp",@"right",@"rightDown",@"down",@"leftDown",@"left",@"leftUp",nil];
		dirctions = [[NSDictionary dictionaryWithObjects:dirvalues forKeys:dirkeys] retain];
		//walk animations
		CCAnimation* walkUpAnimation = [CCAnimation animationWithName:@"walkUp" delay:0.04f];
		CCAnimation* walkDownAnimation = [CCAnimation animationWithName:@"walkRight" delay:0.04f];
		CCAnimation* walkLeftAnimation = [CCAnimation animationWithName:@"walkDown" delay:0.04f];
		
		CCAnimation* restAnimation = [CCAnimation animationWithName:@"rest" delay:0.04f];
		
		for (int i = 1; i<=21; i++) {
			[walkUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"tibentanmastiff_walk_up_%02d.png", i]];
			[walkDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"tibentanmastiff_walk_down_%02d.png", i]];
			[walkLeftAnimation addFrameWithFilename:[NSString stringWithFormat:@"tibentanmastiff_walk_left_%02d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkUpAnimation]] forKey:@"walk_up"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkDownAnimation]] forKey:@"walk_down"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnimation]] forKey:@"walk_left"];
		
		for (int i = 1; i<= 10; i++) {
			[restAnimation addFrameWithFilename:[NSString stringWithFormat:@"tibentanmastiff_rest_%02d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:restAnimation] ] forKey:@"rest"];
	}
	return self;
}

-(void) update:(int)currDirectionValue status:(int)currStatusValue
{
	NSString *status = @"walk";
	NSString *direction= [dirctions objectForKey: [NSString stringWithFormat:@"%d",currDirectionValue]];
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
	NSString *showKey;
	
	if (currDirectionValue == -1) {
		showKey = status;
	}
	else {
		showKey = [[status stringByAppendingString:@"_"] stringByAppendingFormat:direction];
	}
	
	[self stopAllActions];
	[self runAction:[animationTable objectForKey:showKey]];
			
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
	int type = OPERATION_DEFAULT;
	if (type == OPERATION_DEFAULT) {
		[self schedule:@selector(tick:) interval:4.0];
	}

	else {
		return;
	}
	
}

-(void)callServerController
{
	
}
								   
-(void) dealloc
	{
		[dirctions dealloc];
		[statuses dealloc];
		[super dealloc];
	}
								   

@end
