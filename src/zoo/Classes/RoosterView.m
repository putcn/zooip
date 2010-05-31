//
//  RoosterView.m
//  zoo
//
//  Created by Rainbow on 4/22/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "RoosterView.h"


@implementation RoosterView

-(id) init
{	
	if ((self = [super init])) {
		//walk animations
		CCAnimation* walkUpAnimation = [CCAnimation animationWithName:@"walkUp" delay:0.04f];
		CCAnimation* walkDownAnimation = [CCAnimation animationWithName:@"walkRightUp" delay:0.04f];
		CCAnimation* walkLeftUpAnimation = [CCAnimation animationWithName:@"walkRight" delay:0.04f];
		CCAnimation* walkLeftDownAnimation = [CCAnimation animationWithName:@"walkRightDown" delay:0.04f];
		CCAnimation* walkLeftAnimation = [CCAnimation animationWithName:@"walkDown" delay:0.04f];
		
		//eat animation
		CCAnimation* eatAnimation = [CCAnimation animationWithName:@"eat" delay:0.04f];
		
		//crow animation
		CCAnimation* crowAnimation = [CCAnimation animationWithName:@"crow" delay:0.04f];
		
		//add walk animations to animationTable
		for (int i = 1; i<=32; i++) {
			[walkUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"rooster_walk_up_%02d.png", i]];
			[walkDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"rooster_walk_down_%02d.png", i]];
			[walkLeftUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"rooster_walk_leftUp_%02d.png", i]];
			[walkLeftDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"rooster_walk_leftDown_%02d.png", i]];
			[walkLeftAnimation addFrameWithFilename:[NSString stringWithFormat:@"rooster_walk_left_%02d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkUpAnimation]] forKey:@"walk_up"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkDownAnimation]] forKey:@"walk_down"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftUpAnimation]] forKey:@"walk_leftUp"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftDownAnimation]] forKey:@"walk_leftDown"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnimation]] forKey:@"walk_left"];
		
		//add eat animation
		for (int i = 1; i<=42; i++) {
			[eatAnimation addFrameWithFilename:[NSString stringWithFormat:@"rooster_eat_left_%02d.png",i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:eatAnimation]] forKey:@"eat_left"];
		
		//add crow animation
		for (int i = 1; i<=42; i++) {
			[crowAnimation addFrameWithFilename:[NSString stringWithFormat:@"rooster_crow_left_%02d.png",i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:crowAnimation]] forKey:@"crow"];
		
		
		
		//stand textures
		CCTexture2D *standLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"rooster.png" ofType:nil]]];
		//add stand textures
		[animationTable setObject:standLeft forKey:@"stand_left"];
		
		
		//ill textures
		CCTexture2D *illUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"rooster_ill_up.png" ofType:nil]]];
		CCTexture2D *illDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"rooster_ill_down.png" ofType:nil]]];
		CCTexture2D *illLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"rooster_ill_leftUp.png" ofType:nil]]];
		CCTexture2D *illLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"rooster_ill_leftDown.png" ofType:nil]]];
		CCTexture2D *illLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"rooster_ill_left.png" ofType:nil]]];
		
		//sleep textures
		CCTexture2D *sleepUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"rooster_sleep_up.png" ofType:nil]]];
		CCTexture2D *sleepDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"rooster_sleep_down.png" ofType:nil]]];
		CCTexture2D *sleepLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"rooster_sleep_leftUp.png" ofType:nil]]];
		CCTexture2D *sleepLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"rooster_sleep_leftDown.png" ofType:nil]]];
		CCTexture2D *sleepLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"rooster_sleep_left.png" ofType:nil]]];		
		
		//add ill textures to animationTable
		[animationTable setObject:illUp forKey:@"ill_up"];
		[animationTable setObject:illDown forKey:@"ill_down"];
		[animationTable setObject:illLeftUp	forKey:@"ill_leftUp"];
		[animationTable setObject:illLeftDown forKey:@"ill_leftDown"];
		[animationTable setObject:illLeft forKey:@"ill_left"];
		
		//add sleep textures to animationTable
		[animationTable setObject:sleepUp forKey:@"sleep_up"];
		[animationTable setObject:sleepDown forKey:@"sleep_down"];
		[animationTable setObject:sleepLeftUp	forKey:@"sleep_leftUp"];
		[animationTable setObject:sleepLeftDown forKey:@"sleep_leftDown"];
		[animationTable setObject:sleepLeft forKey:@"sleep_left"];
		
	}
	return self;
}
@end
