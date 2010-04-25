//
//  BabyDove.m
//  zoo
//
//  Created by Rainbow on 4/22/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "BabyDove.h"


@implementation BabyDove
-(id) initWithPrefix:(NSString *)prefix
{	
	if ((self = [super initWithPrefix:prefix])) {
		//stop animation
		CCAnimation* stopAnimation = [CCAnimation animationWithName:@"stop" delay:0.04f];
		
		//add stop animation
		for (int i = 1; i<=24; i++) {
			[stopAnimation addFrameWithFilename:[NSString stringWithFormat:@"babyDove_stop_%02d.png",i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:eatAnimation]] forKey:@"stop"];
		
	}
	return self;
	
}
@end
