//
//  ScaleControlLayer.m
//  ZooDemo
//
//  Created by Niu Darcy on 4/7/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ScaleControlLayer.h"


@implementation ScaleControlLayer

-(id)initWithTarget:(CCSprite*) targetValue
{
	if( (self=[super init] ))
	{
		self.isTouchEnabled = YES;
		dX = 0;
		dY = 0;
		target = targetValue;
	}
	return self;
}

-(void) onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touches began");
	NSArray *arrToucher = [touches allObjects];
	if ([arrToucher count] == 2)
	{
		CGPoint point0 = [self convertTouchToNodeSpaceAR:[arrToucher objectAtIndex:0]];
		CGPoint point1 = [self convertTouchToNodeSpaceAR:[arrToucher objectAtIndex:1]];
		
		CGFloat x0 = point0.x;
		CGFloat y0 = point0.y;
		CGFloat x1 = point1.x;
		CGFloat y1 = point1.y;
		
		dX = fabs(x0 - x1);
		dY = fabs(y0 - y1);
	}
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSArray *arrToucher = [touches allObjects];
	if ([arrToucher count] == 2)
	{
		CGPoint point0 = [self convertTouchToNodeSpaceAR:[arrToucher objectAtIndex:0]];
		CGPoint point1 = [self convertTouchToNodeSpaceAR:[arrToucher objectAtIndex:1]];
		CGFloat x0 = point0.x;
		CGFloat y0 = point0.y;
		CGFloat x1 = point1.x;
		CGFloat y1 = point1.y;
		
		CGFloat dxTemp = fabs(x0 - x1);
		CGFloat dyTemp = fabs(y0 - y1);
		
		CGFloat scaleIncreament = ((dxTemp - dX) + (dyTemp - dY)) / 300.0f;
			
		target.scale += scaleIncreament;
		
		if (target.scale < 1) target.scale = 1;
		
		NSLog(@"===差值X: %f ===差值Y: %f", dxTemp - dX, dyTemp - dY);
		
		dX = fabs(x0 - x1);
		dY = fabs(y0 - y1);
	}
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return NO;
}

-(void) dealloc
{
	[target release];
	[super dealloc];
}

@end
