//
//  FarmAnimal.m
//  zoo
//
//  Created by Rainbow on 7/5/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "FarmAnimal.h"
#import "RandomHelper.h"
#import "GameMainScene.h"

@implementation FarmAnimal

-(id) initWithView:(FarmAnimalView*) viewValue setSpeed:(CGFloat) speedValue setLimitRect:(CGRect) limitRectValue
{
	if ( (self=[super init]) )
	{
		view = [viewValue retain];
		speed = speedValue;
		targetPosition = ccp(view.position.x, view.position.y);
		currSpeed = ccp(0 ,0);
		currStatus = 0;
		standRemain = 0;
		limitRect = limitRectValue;
		
		[[CCScheduler sharedScheduler] scheduleTimer: [CCTimer timerWithTarget:self selector:@selector(tick:)]];
	}
	return self;
}

@end

@implementation FarmAnimal (Private)

-(void) tick: (ccTime) dt
{
	CGPoint point = view.position;
	forwardStatus = currStatus;
	if(standRemain <= 0){
		int randomInt = [RandomHelper getRandomNum:1 to:100];
		if (randomInt > 5) {
			currStatus = 5;
			if ((fabs(point.x - targetPosition.x) <= speed) &&
				(fabs(point.y - targetPosition.y) <= speed))
			{
				[self findTarget];
				[view update:currDirection status:currStatus];
				//NSLog(@"当前方向: %d", currDirection);
			}
			else
			{
				if (forwardStatus != 5) {
					[view update:currDirection status:currStatus];
				}
				view.position = ccpAdd(point, currSpeed);
			}
		}
		else if(randomInt == 5)
		{
			currStatus = 4;
			[view update:currDirection status:currStatus];
			standRemain = [RandomHelper getRandomNum:2000 to:10000];
		}
		else {
			currStatus = 4;
			[view stopAllActions];
			standRemain = [RandomHelper getRandomNum:100 to:500];
		}
	}
	else {
		standRemain--;
	}

}

-(void) findTarget
{
	CGPoint point = view.position;
	
	int currX = (int)point.x;
	int currY = (int)point.y;
	
	BOOL isFound = NO;
	
	while (!isFound)
	{
		targetPosition.x = [RandomHelper getRandomNum:currX - 50 to:currX + 50];
		targetPosition.y = [RandomHelper getRandomNum:currY - 50 to:currY + 50];
		
		if (CGRectContainsPoint(limitRect, targetPosition)) isFound = YES;
	}
	
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
	if ((currSpeed.x >= -0.09 && currSpeed.x <= 0.09) && currSpeed.y > 0)
	{
		currDirection = 0; // up
	}
	else if (currSpeed.x >= 0.09 && currSpeed.y >= 0.09)
	{
		currDirection = 1; // up right
	}
	else if (currSpeed.x > 0 && (currSpeed.y <= 0.09 && currSpeed.y >= -0.09))
	{
		currDirection = 2; // right
	}
	else if (currSpeed.x > 0.09 && currSpeed.y < -0.09)
	{
		currDirection = 3; // down right
	}
	else if ((currSpeed.x >= -0.09 && currSpeed.x <= 0.09) && currSpeed.y < 0)
	{
		currDirection = 4; // down
	}
	else if (currSpeed.x < -0.09 && currSpeed.y < -0.09)
	{
		currDirection = 5; // down left
	}
	else if (currSpeed.x < 0 && (currSpeed.y <= 0.09 && currSpeed.y >= -0.09))
	{
		currDirection = 6; // left
	}
	else if (currSpeed.x < -0.09 && currSpeed.y > 0.09)
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
