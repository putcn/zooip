//
//  SummonView.m
//  zoo
//
//  Created by Rainbow on 5/12/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "SummonView.h"


@implementation SummonView

-(id)init
{
	if ((self = [super init])) {
		
		CCAnimation *operationAnimation = [CCAnimation animationWithName:@"operation" delay:0.2];
		for (int i = 1; i<= 5; i++) {
			[operationAnimation addFrameWithFilename:[NSString stringWithFormat:@"summon_%02d.png", i]];
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