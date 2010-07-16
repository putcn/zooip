//
//  ChinemyView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ChinemyView.h"
#import "AnimalImageProperty.h"

@implementation ChinemyView

-(id) init
{
	if((self = [super init]))
	{
		AnimalImageProperty *imageProperty = [[AnimalImageProperty alloc] init];
		animationTable = [[imageProperty animationTable:@"_chinemy.png" plistName:@"_chinemy.plist"] retain];
		NSLog(@"dog---%@", animationTable);
		[[GameMainScene sharedGameMainScene] addSpriteToStage:self z:5];
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
	
	NSString *showKey = [[status stringByAppendingString:@"_"] stringByAppendingFormat:direction];
	showKey = [showKey lowercaseString];
	[self stopAllActions];
	[self runAction:[animationTable objectForKey:showKey]];

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
}

-(CGPoint)countCoordinate: (CGPoint)clickPoint
{
	return ccp(self.position.x + clickPoint.x - self.contentSize.width/2, self.position.y + clickPoint.y - self.contentSize.height/2);
}

-(void)optAnimationPlay
{
	int type = OPERATION_CURE_ANIMAL;
	if (type == OPERATION_DEFAULT) {
		[self schedule:@selector(tick:) interval:4.0];
	}
	else 
		if(type == OPERATION_CURE_ANIMAL){
			CGPoint location = ccp(self.position.x, self.position.y);
			[[OperationViewController sharedOperationViewController] play:@"infusion" setPosition:location];
		}
		else {
			return;
		}
	
}

-(void)callServerController
{
	
}

-(void)dealloc
{
	// Add by Hunk on 2010-06-29
	[animationTable release];
	[dirctions release];
	
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end

