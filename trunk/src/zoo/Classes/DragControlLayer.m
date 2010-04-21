//
//  DragControlLayer.m
//  Zoo
//
//  Created by Niu Darcy on 4/21/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DragControlLayer.h"


@implementation DragControlLayer

-(id)initWithTarget:(CCSprite*) targetValue
{
	if( (self=[super init] ))
	{
		self.isTouchEnabled = YES;
		oX = 0;
		oY = 0;
		target = targetValue;
		curTouchesNum = 0;
		
		isReset = YES;
	}
	return self;
}

-(void) dealloc
{
	[target release];
	[super dealloc];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	curTouchesNum += [[touches allObjects] count];
	NSLog(@"+++++++begin++++++curTouchesNum: %d", curTouchesNum);
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSArray *arrToucher = [touches allObjects];
	if (curTouchesNum == 1)
	{
		CGPoint point0 = [self convertTouchToNodeSpaceAR:[arrToucher objectAtIndex:0]];
		CGFloat x0 = point0.x;
		CGFloat y0 = point0.y;
		
		CGFloat xIncreament = (x0 - oX);
		CGFloat yIncreament = (y0 - oY);
		
		if (isReset) 
		{
			xIncreament = 0;
			yIncreament = 0;
			isReset = NO;
		}
		
		target.position = ccpAdd(target.position, ccp(xIncreament, yIncreament));
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CGFloat limitWidth = (target.contentSize.width * target.scale - size.width) / 2;
		CGFloat limitX = target.position.x;
		if (limitX > size.width / 2 + limitWidth) limitX = size.width / 2 + limitWidth;
		if (limitX < size.width / 2 - limitWidth) limitX = size.width / 2 - limitWidth;
		
		CGFloat limitHeight = (target.contentSize.height * target.scale - size.height) / 2;
		CGFloat limitY = target.position.y;
		if (limitY > size.height / 2 + limitHeight) limitY = size.height / 2 + limitHeight;
		if (limitY < size.height / 2 - limitHeight) limitY = size.height / 2 - limitHeight;
		
		target.position = ccp(limitX, limitY);
		
		//if (target.scale < 1) target.scale = 1;
		
		oX = x0;
		oY = y0;
		
		NSLog(@"TargetSize:%f * %f +++++++++++差值X: %f +++++++++++++差值Y: %f", target.contentSize.width, target.contentSize.height, xIncreament, yIncreament);
	}
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	isReset = YES;
	curTouchesNum -= [[touches allObjects] count];
	NSLog(@"++++++end++++++curTouchesNum: %d", curTouchesNum);
}

@end
