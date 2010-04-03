//
//  Animal.m
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Animal.h"
#import "RandomHelper.h"


@implementation Animal

-(id) initWithView:(AnimalView*) viewValue setSpeed:(CGFloat) speedValue
{
	if ( (self=[super init]) )
	{
		view = [viewValue retain];
		speed = speedValue;
		targetPosition = ccp(view.position.x, view.position.y);
		currSpeed = ccp(0 ,0);
		currStatus = 0;
		
		[[CCScheduler sharedScheduler] scheduleTimer: [CCTimer timerWithTarget:self selector:@selector(tick:)]];
	}
	return self;
}

@end

@implementation Animal (Private)

-(void) tick: (ccTime) dt
{
	CGPoint point = view.position;
	
	if ((fabs(point.x - targetPosition.x) <= speed) &&
		(fabs(point.y - targetPosition.y) <= speed))
	{
		[self findTarget];
		[view update:currDirection status:currStatus];
		NSLog(@"当前方向: %d", currDirection);
	}
	else
	{
		view.position = ccpAdd(point, currSpeed);
	}	
}

-(void) findTarget
{
	CGPoint point = view.position;
	
	int currX = (int)point.x;
	int currY = (int)point.y;
	
	targetPosition.x = [RandomHelper getRandomNum:currX - 30 to:currX + 30];
	targetPosition.y = [RandomHelper getRandomNum:currY - 30 to:currY + 30];
	
	[self calculateSpeed];
	[self findDirection];
}

-(void) calculateSpeed
{
	CGPoint point = view.position;
	
	float a = atanf((targetPosition.y - point.y) / (targetPosition.x - point.x));
	if ((targetPosition.x - point.x) < 0)
	{
		a += M_PI;
	}
	
	currSpeed.x = speed * cosf(a);
	currSpeed.y = speed * sinf(a);
}

-(void) findDirection
{
	if (currSpeed.x == 0 && currSpeed.y > 0)
	{
		currDirection = 0; // up
	}
	else if (currSpeed.x > 0 && currSpeed.y > 0)
	{
		currDirection = 1; // up right
	}
	else if (currSpeed.x > 0 && currSpeed.y == 0)
	{
		currDirection = 2; // right
	}
	else if (currSpeed.x > 0 && currSpeed.y < 0)
	{
		currDirection = 3; // down right
	}
	else if (currSpeed.x == 0 && currSpeed.y < 0)
	{
		currDirection = 4; // down
	}
	else if (currSpeed.x < 0 && currSpeed.y < 0)
	{
		currDirection = 5; // down left
	}
	else if (currSpeed.x < 0 && currSpeed.y == 0)
	{
		currDirection = 6; // left
	}
	else if (currSpeed.x < 0 && currSpeed.y > 0)
	{
		currDirection = 7; // up left
	}
	else
	{
		currDirection = 3;
	}
}

-(void) dealloc
{
	[view release];
	[name release];
	[type release];
	[super dealloc];
}

@end
