//
//  NormalFoodView.m
//  zoo
//
//  Created by Rainbow on 5/12/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "NormalFoodView.h"


@implementation NormalFoodView

-(id) init
{
	if ((self = [super init])) {
	
		CCAnimation *operationAnimation = [CCAnimation animationWithName:@"operation" delay:0.2];
		for (int i = 1; i<= 6; i++) {
			[operationAnimation addFrameWithFilename:[NSString stringWithFormat:@"normal_food_%02d.png", i]];
		}
		operationAnimate = [[CCAnimate actionWithAnimation:operationAnimation] copy];
	}
	return self;
}

-(void) play
{
	
	[self runAction:operationAnimate];
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[operationAnimate release];
	
	[super dealloc];
}


@end
