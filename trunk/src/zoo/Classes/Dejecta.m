//
//  Dejecta.m
//  zoo
//
//  Created by Rainbow on 5/10/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Dejecta.h"


@implementation Dejecta

-(id) init
{
	if ((self = [super init])) {
		CCAnimation *animation = [CCAnimation animationWithName:@"animal" delay:0.4];
		for (int i = 1; i<=4; i++) {
			[animation addFrameWithFilename:[NSString stringWithFormat:@"dejecta_%02d",i]];
		}
		CCRepeatForever *repeatAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
		[self runAction:repeatAction];
	}
	return self;
}

@end
