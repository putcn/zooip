//
//  DogView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DogView.h"


@implementation DogView
-(id) init
{
	if((self = [super init]))
	{
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
								   
-(void) dealloc
	{
		[dirctions dealloc];
		[statuses dealloc];
		[super dealloc];
	}
								   

@end
