//
//  AntView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AntView.h"


@implementation AntView

-(id) init
{
	if ((self = [super init])) {
		
		NSArray *dirkeys = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
		NSArray *dirvalues = [NSArray arrayWithObjects:@"up",@"rightUp",@"right",@"rightDown",@"down",@"leftDown",@"left",@"leftUp",nil];
		dirctions = [[NSDictionary dictionaryWithObjects:dirvalues forKeys:dirkeys] retain];
		animation = [CCAnimation animationWithName:@"animal" delay:0.5];
		for (int i = 1; i <= 4; i++) {
			[animation addFrameWithFilename:[NSString stringWithFormat:@"ant_%02d", i]];
		}
	}
	return self;
}

-(void) update:(int)currDirectionValue status:(int)currStatusValue
{
	NSString *direction= [dirctions objectForKey: [NSString stringWithFormat:@"%d",currDirectionValue]];
	CCRepeatForever *repeatAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
	[self stopAllActions];
	self.rotation = 0;
	if (direction == @"left" || direction == @"leftUp") {
		[self runAction:repeatAction];
	}
	else if(direction == @"up" || direction == @"rightUp"){
		self.rotation = 90;
		[self runAction:repeatAction];
	}
	else if(direction == @"right" || direction == @"rightDown"){
		self.rotation = 180;
		[self runAction:repeatAction];
	}
	else if(direction == @"down" || direction == @"leftDown"){
		self.rotation = 270;
		[self runAction:repeatAction];
	}
}

-(void) dealloc
{
	[dirctions dealloc];
	[super dealloc];
}

@end
