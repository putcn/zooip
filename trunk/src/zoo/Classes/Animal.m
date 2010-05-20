//
//  Animal.m
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Animal.h"
#import "RandomHelper.h"


@implementation Animal

@synthesize animalData;

-(id) initWithView:(AnimalView*) viewValue setSpeed:(CGFloat) speedValue setLimitRect:(CGRect) limitRectValue
{
	if ( (self=[super init]) )
	{
		view = [viewValue retain];
		speed = speedValue;
		targetPosition = ccp(view.position.x, view.position.y);
		currSpeed = ccp(0 ,0);
		currStatus = 6;
		
		limitRect = limitRectValue;
		
		[[CCScheduler sharedScheduler] scheduleTimer: [CCTimer timerWithTarget:self selector:@selector(tick:)]];
	}
	return self;
}

-(id) initWithAnimalData:(DataModelAnimal *) data
{
	if ( (self = [super init]))
	{
		animalData = data;
		
		NSInteger type = data.originalAnimalId;
		NSInteger stage = data.birdStage;
		view = [AnimalViewFactory createAnimalView:type birdStage:stage];
		
		//TODO: Need to set the animal data...
		speed = data.speed / 60.0f;
		currSpeed = ccp(0 ,0);
		currStatus = 5;
		limitRect = CGRectMake(100, 100, 500, 500);
		view.position = ccp(400, 200);
		targetPosition = ccp(view.position.x, view.position.y);
		view.animalId = data.animalId;
		
		[[CCScheduler sharedScheduler] scheduleTimer: [CCTimer timerWithTarget:self selector:@selector(tick:)]];
		
		[[GameMainScene sharedGameMainScene] addSpriteToStage:view z:5];
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
		//NSLog(@"当前方向: %d", currDirection);
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
	
	BOOL isFound = NO;
	
	while (!isFound)
	{
		targetPosition.x = [RandomHelper getRandomNum:currX - 50 to:currX + 50];
		targetPosition.y = [RandomHelper getRandomNum:currY - 50 to:currY + 50];
		
		if (CGRectContainsPoint(limitRect, targetPosition)) isFound = YES;
		NSLog(@"===Loop Find===");
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
	//TODO: Remove view from the stage
	[view dealloc];
	[view release];
	[super dealloc];
}

@end