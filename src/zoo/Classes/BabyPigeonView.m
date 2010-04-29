//
//  BabyPigeonView.m
//  zoo
//
//  Created by Rainbow on 4/22/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "BabyPigeonView.h"


@implementation BabyPigeonView
-(id) init
{	
	if ((self = [super init])) {
		//stop animation
		CCAnimation* stopAnimation = [CCAnimation animationWithName:@"stop" delay:0.04f];
		
		//add stop animation
		for (int i = 1; i<=24; i++) {
			[stopAnimation addFrameWithFilename:[NSString stringWithFormat:@"babyPigeon_stop_%02d.png",i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:stopAnimation]] forKey:@"stop"];
		
	}
	return self;
	
}
@end
