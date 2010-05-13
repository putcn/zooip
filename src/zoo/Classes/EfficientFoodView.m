//
//  EfficientFoodView.m
//  zoo
//
//  Created by Rainbow on 5/12/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "EfficientFoodView.h"


@implementation EfficientFoodView

-(id)init
{
	if ((self = [super init])) {
		
		CCAnimation *operationAnimation = [CCAnimation animationWithName:@"operation" delay:0.2];
		for (int i = 1; i<= 6; i++) {
			[operationAnimation addFrameWithFilename:[NSString stringWithFormat:@"efficient_food_%02d.png", i]];
		}
		operationAnimate = [[CCAnimate actionWithAnimation:operationAnimation] copy];
		
	}
	return self;
}

-(void) play
{
	[self runAction:operationAnimate];
}

@end
