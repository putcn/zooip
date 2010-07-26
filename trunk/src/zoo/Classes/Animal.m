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
@synthesize moveArea;

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
		
		[[GameMainScene sharedGameMainScene] addSpriteToStage:view z:5];
	}
	return self;
}

-(id) initWithAnimalData:(DataModelAnimal *) data
{
	if ( (self = [super init]))
	{
		animalData = data;
		
		isGotoEat = NO;
		
		NSInteger type = data.originalAnimalId;
		NSInteger stage = data.birdStage;
		view = [AnimalViewFactory createAnimalView:type birdStage:stage];
		
		//TODO: Need to set the animal data...
		speed = data.speed / 60.0f;
		currSpeed = ccp(0 ,0);
		currStatus = 5;
		limitRect = CGRectMake(100, 100, 500, 500);
		view.position = ccp([RandomHelper getRandomNum:530 to:760], [RandomHelper getRandomNum:100 to:200]);
		targetPosition = ccp(view.position.x, view.position.y);
		view.animalId = data.animalId;
		
		landLandingArea = CGRectMake(520, 78, 260, 150);
		waterLandingArea = CGRectMake(20, 358, 200, 150);
		bowlArea = CGRectMake(320, 140, 130, 80);
		
		[self setupMoveArea:data.aliveEdge];
		if (data.status == 1) {
			[view update:[RandomHelper getRandomNum:0 to:7] status:2];
		}
		else {
			[[CCScheduler sharedScheduler] scheduleTimer: [CCTimer timerWithTarget:self selector:@selector(tick:)]];
		}
		view.scale = 1.0f/0.49f;
		[[GameMainScene sharedGameMainScene] addSpriteToStage:view z:5];
		
	}
	return self;
}

-(void) removeAnimalView
{
	[[GameMainScene sharedGameMainScene] removeSpriteFromStage:view];
}

-(void) gotoEat
{
	if (currStatus == 4)
	{
		int mapType = [CollisionHelper getMapType:view.position isByte:NO];
		if (mapType == 1)//Water
		{
			currStatus = 7;
		}
		else if (mapType == 2)
		{
			currStatus = 5;
		}
	}
	else if (currStatus == 10 || currStatus == 11)
	{
		currStatus = 6;
	}
	
	if (CGRectContainsPoint(bowlArea, view.position) == NO)
	{
		targetPosition = ccp(386,176);
		isGotoEat = YES;
		[self updateSpeed];
		[self calculateSpeed];
		[self findDirection];
		[view update:currDirection status:currStatus];
	}
	else
	{
		if (currStatus != 1)
		{
			isGotoEat = NO;
			currStatus = 1;
			waitRemain = 600;
			[self updateSpeed];
			[view update:currDirection status:currStatus];
		}
	}
}

@end

@implementation Animal (Private)

-(void) tick: (ccTime) dt
{
	//TODO: 判断是否已经进入水中或登陆，进入水中或登陆时，切换状态...
	if (view.position.y > 400.0f) {
		[view setScale:(400.0f/view.position.y)*(1.0f/0.49f)];
	}
	else {
		view.scale = 1.0f/0.49f;
	}

	if (isGotoEat == YES)
	{
		CGPoint point = view.position;
		
		if (CGRectContainsPoint(bowlArea, point))
		{
			if (currStatus != 1)
			{
				isGotoEat = NO;
				currStatus = 1;
				waitRemain = 600;
				[self updateSpeed];
				[view update:currDirection status:currStatus];
			}
		}
		else
		{
			CGPoint nextPosition;
			BOOL isReach = NO;
			nextPosition = ccpAdd(point, currSpeed);
			isReach = [self isCanReach:nextPosition];
			
			if (!isReach)
			{
				isGotoEat = NO;
				[self findTarget];
				[view update:currDirection status:currStatus];
				return;
			}
			
			int mapType = [CollisionHelper getMapType:view.position isByte:NO];
			if (mapType == 1)//Water
			{
				if (currStatus != 7 && currStatus != 6)
				{
					currStatus = 7;
					[view update:currDirection status:currStatus];
				}
			}
			else if (mapType == 2)//Land
			{
				if (currStatus != 5 && currStatus != 6)
				{
					currStatus = 5;
					[view update:currDirection status:currStatus];
				}
			}
			else
			{
				
			}
			
			view.position = nextPosition;
		}
	}
	else
	{
		if (currStatus == 4 || currStatus == 1)
		{
			if (waitRemain <= 0)
			{
				[self switchNormalState];
				[self updateSpeed];
				[self findTarget];
				[view update:currDirection status:currStatus];
			}
			else
			{
				waitRemain--;
			}
		}
		else
		{
			CGPoint point = view.position;
			
			if ((fabs(point.x - targetPosition.x) <= speed) &&
				(fabs(point.y - targetPosition.y) <= speed))
			{
				[self switchNormalState];
				[self updateSpeed];
				[self findTarget];
				[view update:currDirection status:currStatus];
				//NSLog(@"当前方向: %d", currDirection);
			}
			else
			{
				if (currStatus != 6 && currStatus != 10 && currStatus != 11)
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
					
					int mapType = [CollisionHelper getMapType:view.position isByte:NO];
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
				else
				{
					CGPoint nextPosition;
					nextPosition = ccpAdd(point, currSpeed);
					view.position = nextPosition;
				}
			}
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
	
	if (currStatus != 6 && currStatus != 10 && currStatus != 11)
	{
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
	}
	else if (currStatus == 6)
	{
		targetPosition.x = [RandomHelper getRandomNum:0 to:1024];
		targetPosition.y = [RandomHelper getRandomNum:446 to:768];
	}
	else if (currStatus == 10)
	{
		targetPosition.x = currX;
		targetPosition.y = [RandomHelper getRandomNum:446 to:768];
	}
	
	[self calculateSpeed];
	[self findDirection];
}

-(void) setupMoveArea:(NSInteger) aliveEdge
{
	if (aliveEdge == 1)
	{
		moveArea = 0x0100;
	}
	else if (aliveEdge == 2)
	{
		moveArea = 0x0010;
	}
	else if (aliveEdge == 3)
	{
		moveArea = 0x110;
	}
	else if (aliveEdge == 4)
	{
		moveArea = 0x0101;
	}
	else if (aliveEdge == 5)
	{
		moveArea = 0x0011;
	}
	else if (aliveEdge == 6)
	{
		moveArea = 0x0111;
	}
}

-(BOOL) isCanReach:(CGPoint)targetPoint
{
	if (currStatus != 6 && currStatus != 10 && currStatus != 11)
	{
		int mapTypeByte = [CollisionHelper getMapType:targetPoint isByte:YES];
		
		BOOL isReach = NO;
		
		if (mapTypeByte == 0x0000)
		{
			return isReach;
		}
		
		if (moveArea & mapTypeByte)
		{
			isReach = YES;
		}
		
		return isReach;
	}
	else
	{
		return YES;
	}
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
	
//	if (currSpeed.x == 0 && currSpeed.y == 0)
//	{
//		currDirection = 6;
//		return;
//	}
//	
//	if (currSpeed.x == 0 && currSpeed.y != 0)
//	{
//		if (currSpeed.y > 0)
//		{
//			currDirection = 0;
//		}
//		else
//		{
//			currDirection = 4;
//		}
//		return;
//	}
//	
//	if (currSpeed.x != 0 && currSpeed.y == 0)
//	{
//		if (currSpeed.x > 0)
//		{
//			currDirection = 2;
//		}
//		else
//		{
//			currDirection = 6;
//		}
//		return;
//	}
//	
//	
}

-(void) switchNormalState
{
	int randomNumber = [RandomHelper getRandomNum:0 to:100];
	
	if (currStatus == 4 || currStatus == 1)
	{
		if (randomNumber > 0 && randomNumber < 10)
		{
			currStatus = 4;
			waitRemain = [RandomHelper getRandomNum:300 to:600];
			return;
		}
		else if (randomNumber >= 10 && randomNumber < 90)
		{
			if ([CollisionHelper getMapType:view.position isByte:NO] == 1)
			{
				currStatus = 7;
				return;
			}
			else
			{
				currStatus = 5;
				return;
			}
		}
		else
		{
			//Can Fly...
			if (moveArea & 0x0001)
			{
				currStatus = 10;
				return;
			}
		}
	}
	else if (currStatus == 5 || currStatus == 7)
	{
		if (randomNumber > 0 && randomNumber < 10)
		{
			if (currStatus == 5) {
				currStatus = 4;
				waitRemain = [RandomHelper getRandomNum:300 to:600];
				return;
			}
			else {
				currStatus = 7;
				return;
			}

		}
		else if (randomNumber >= 10 && randomNumber < 50)
		{
			if ([CollisionHelper getMapType:view.position isByte:NO] == 1)
			{
				currStatus = 7;
				return;
			}
			else
			{
				currStatus = 5;
				return;
			}
		}
		else
		{
			//Can Fly...
			if (moveArea & 0x0001)
			{
				currStatus = 10;
				return;
			}
		}
	}
	else if (currStatus == 6)
	{
		if (randomNumber > 0 && randomNumber < 5)
		{
			//Can Landing Land...
			if (moveArea & 0x0100)
			{
				currStatus = 11;
				
				targetPosition.x = [RandomHelper getRandomNum:landLandingArea.origin.x to:(landLandingArea.origin.x + landLandingArea.size.width)];
				targetPosition.y = [RandomHelper getRandomNum:landLandingArea.origin.y to:(landLandingArea.origin.y + landLandingArea.size.height)];
				
				return;
			}
		}
		else if (randomNumber >= 5 && randomNumber < 10)
		{
			//Can Landing Water...
			if (moveArea & 0x0010)
			{
				currStatus = 11;
				
				targetPosition.x = [RandomHelper getRandomNum:waterLandingArea.origin.x to:(waterLandingArea.origin.x + waterLandingArea.size.width)];
				targetPosition.y = [RandomHelper getRandomNum:waterLandingArea.origin.y to:(waterLandingArea.origin.y + waterLandingArea.size.height)];
				
				return;
			}
		}
		else
		{
			currStatus = 6;
			return;
		}
	}
	else if (currStatus == 10)
	{
		currStatus = 6;
		return;
	}
	else if (currStatus == 11)
	{
		if ([CollisionHelper getMapType:view.position isByte:NO] == 1)
		{
			currStatus = 7;
			return;
		}
		else
		{
			currStatus = 5;
			return;
		}
	}
}

-(void) updateSpeed
{
	if (!isGotoEat)
	{
		if (currStatus == 4)
		{
			speed = 0;
		}
		else if (currStatus == 5)
		{
			speed = animalData.speed / 90.0f;
		}
		else if (currStatus == 7)
		{
			speed = animalData.swimmingSpeed / 90.0f;
		}
		else if (currStatus == 6 || currStatus == 10 || currStatus == 11)
		{
			speed = animalData.flyingSpeed / 22.5f;
		}
		else
		{
			speed = 0;
		}
	}
	else
	{
		if (currStatus == 6 || currStatus == 10 || currStatus == 11)
		{
			speed = animalData.flyingSpeed / 30.0f;
		}
		else
		{
			speed = animalData.walkToEatSpeed / 45.0f;
		}
	}
	if (view.position.y > 400.0f) {
		speed = (300.0f/view.position.y)*speed;
	}
}

-(void) dealloc
{
	// Add by Hunk on 2010-06-29
	[animalData release];
	
	//TODO: Remove view from the stage
	[view dealloc];
	[view release];
	[super dealloc];
}

@end
