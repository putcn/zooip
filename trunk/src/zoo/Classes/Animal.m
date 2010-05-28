//
//  Animal.m
//  zoo
//
//  Created by Gu Lei on 10-4-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Animal.h"
#import "RandomHelper.h"
#import "CollisionHelper.h"


@implementation Animal

@synthesize animalData;

-(id) initWithView:(CCSprite*) viewValue setSpeed:(CGFloat) speedValue setLimitRect:(CGRect) limitRectValue
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
		
		//[[GameMainScene sharedGameMainScene] addSpriteToStage:view z:5];
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
		view.position = ccp(500, 200);
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
	//TODO: 判断是否已经进入水中或登陆，进入水中或登陆时，切换状态...
	
	CGPoint point = view.position;
	
	if ((fabs(point.x - targetPosition.x) <= speed) &&
		(fabs(point.y - targetPosition.y) <= speed))
	{
		//[self switchNormalState];
		[self findTarget];
		[view update:currDirection status:currStatus];
		//NSLog(@"当前方向: %d", currDirection);
	}
	else
	{
		CGPoint nextPosition;
		BOOL isReach = NO;
		while (!isReach)
		{
			nextPosition = ccpAdd(point, currSpeed);
			isReach = [self isCanReach:nextPosition];
			
			if (!isReach)
			{
				[self findTarget];
				[view update:currDirection status:currStatus];
			}
		}
		
		view.position = nextPosition;
		
		int mapType = [CollisionHelper getMapType:view.position];
		if (mapType == 1)//Water
		{
			if (currStatus != 7)
			{
				currStatus = 7;
				[view update:currDirection status:currStatus];
			}
		}
		else if (mapType == 2)//Land
		{
			if (currStatus != 5)
			{
				currStatus = 5;
				[view update:currDirection status:currStatus];
			}
		}
		else
		{
			
		}
	}
}

-(void) findTarget
{
	//TODO: 先判断动物是否为幼年，然后根据其行为限制计算下一个目地点是否可达，不可达再继续寻找...
	
	CGPoint point = view.position;
	
	int currX = (int)point.x;
	int currY = (int)point.y;
	
	BOOL isFound = NO;
	
	while (!isFound)
	{
		targetPosition.x = [RandomHelper getRandomNum:currX - 200 to:currX + 200];
		targetPosition.y = [RandomHelper getRandomNum:currY - 200 to:currY + 200];
		
		if (CGRectContainsPoint(limitRect, targetPosition))
		{
			isFound = [self isCanReach:targetPosition];
		}
		//NSLog(@"===Loop Find===");
	}
	
	[self calculateSpeed];
	[self findDirection];
}

-(BOOL) isCanReach:(CGPoint)targetPoint
{
	int mapType = [CollisionHelper getMapType:targetPoint];
	
	BOOL isReach = NO;
	
	if (mapType == -1)
	{
		return isReach;
	}
	
	if (animalData.aliveEdge == 1)//陆地
	{
		if (mapType == 2)
		{
			isReach = YES;
		}
	}
	else if (animalData.aliveEdge == 2)//水面
	{
		if (mapType == 1)
		{
			isReach = YES;
		}
	}
	else if (animalData.aliveEdge == 3)//陆地和水面
	{
		if (mapType == 1 || mapType == 2)
		{
			isReach = YES;
		}
	}
	else if (animalData.aliveEdge == 4)//陆地和空中
	{
		if (mapType == 0 || mapType == 2)
		{
			isReach = YES;
		}
	}
	else if (animalData.aliveEdge == 5)//水面和空中
	{
		if (mapType == 0 || mapType == 1)
		{
			isReach = YES;
		}
	}
	else if (animalData.aliveEdge == 6)//陆地，水面，空中
	{
		isReach = YES;
	}
	
	return isReach;
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

-(void) switchNormalState
{
	int randomNumber = [RandomHelper getRandomNum:0 to:100];
	
	if (currStatus == 4)
	{
		if (randomNumber > 0 && randomNumber < 30)
		{
			currStatus = 4;
		}
		else if (randomNumber >= 30 && randomNumber < 90)
		{
			if ([CollisionHelper getMapType:view.position] == 1)
			{
				currStatus = 7;
			}
			else
			{
				currStatus = 5;
			}
		}
		else
		{
			currStatus = 6;
		}
	}
	else if (currStatus == 5 || currStatus == 7)
	{
		if (randomNumber > 0 && randomNumber < 10)
		{
			currStatus = 4;
		}
		else if (randomNumber >= 30 && randomNumber < 90)
		{
			if ([CollisionHelper getMapType:view.position] == 1)
			{
				currStatus = 7;
			}
			else
			{
				currStatus = 5;
			}
		}
		else
		{
			currStatus = 6;
		}
	}
	else if (currStatus == 6)
	{
		if (randomNumber > 0 && randomNumber < 10)
		{
			if ([CollisionHelper getMapType:view.position] == 1)
			{
				currStatus = 7;
			}
			else
			{
				currStatus = 5;
			}
		}
		else
		{
			currStatus = 6;
		}
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
