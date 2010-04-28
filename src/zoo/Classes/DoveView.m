//
//  DoveView.m
//  zoo
//
//  Created by Rainbow on 4/22/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DoveView.h"


@implementation DoveView

-(id) init
{	
	if ((self = [super init])) {
		//walk animations
		CCAnimation* walkUpAnimation = [CCAnimation animationWithName:@"walkUp" delay:0.04f];
		CCAnimation* walkDownAnimation = [CCAnimation animationWithName:@"walkRightUp" delay:0.04f];
		CCAnimation* walkLeftUpAnimation = [CCAnimation animationWithName:@"walkRight" delay:0.04f];
		CCAnimation* walkLeftDownAnimation = [CCAnimation animationWithName:@"walkRightDown" delay:0.04f];
		CCAnimation* walkLeftAnimation = [CCAnimation animationWithName:@"walkDown" delay:0.04f];
		
		//fly animations
		CCAnimation* flyUpAnimation = [CCAnimation animationWithName:@"flyUp" delay:0.04f];
		CCAnimation* flyDownAnimation = [CCAnimation animationWithName:@"flyRightUp" delay:0.04f];
		CCAnimation* flyLeftUpAnimation = [CCAnimation animationWithName:@"flyRight" delay:0.04f];
		CCAnimation* flyLeftDownAnimation = [CCAnimation animationWithName:@"flyRightDown" delay:0.04f];
		CCAnimation* flyLeftAnimation = [CCAnimation animationWithName:@"flyDown" delay:0.04f];
		
		//eat animation
		CCAnimation* eatAnimation = [CCAnimation animationWithName:@"eat" delay:0.04f];
		
		//transition
//		CCAnimation* transitionUpAnimation = [CCAnimation animationWithName:@"transitionUp" delay:0.04f];
//		CCAnimation* transitionDownAnimation = [CCAnimation animationWithName:@"transitionRightUp" delay:0.04f];
//		CCAnimation* transitionLeftUpAnimation = [CCAnimation animationWithName:@"transitionRight" delay:0.04f];
//		CCAnimation* transitionLeftDownAnimation = [CCAnimation animationWithName:@"transitionRightDown" delay:0.04f];
//		CCAnimation* transitionLeftAnimation = [CCAnimation animationWithName:@"transitionDown" delay:0.04f];
		
		//landing
//		CCAnimation* landingUpAnimation = [CCAnimation animationWithName:@"landingUp" delay:0.04f];
//		CCAnimation* landingDownAnimation = [CCAnimation animationWithName:@"landingRightUp" delay:0.04f];
//		CCAnimation* landingLeftUpAnimation = [CCAnimation animationWithName:@"landingRight" delay:0.04f];
//		CCAnimation* landingLeftDownAnimation = [CCAnimation animationWithName:@"landingRightDown" delay:0.04f];
//		CCAnimation* landingLeftAnimation = [CCAnimation animationWithName:@"landingDown" delay:0.04f];
		
		//add walk animations to animationTable
		for (int i = 1; i<=11; i++) {
			[walkUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"dove_walk_up_%02d.png", i]];
			[walkDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"dove_walk_down_%02d.png", i]];
			[walkLeftUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"dove_walk_leftUp_%02d.png", i]];
			[walkLeftDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"dove_walk_leftDown_%02d.png", i]];
			[walkLeftAnimation addFrameWithFilename:[NSString stringWithFormat:@"dove_walk_left_%02d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkUpAnimation]] forKey:@"walk_up"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkDownAnimation]] forKey:@"walk_down"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftUpAnimation]] forKey:@"walk_leftUp"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftDownAnimation]] forKey:@"walk_leftDown"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnimation]] forKey:@"walk_left"];
		
		//add fly animations to animationTable
		for (int i = 1; i<=8; i++) {
			[flyUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"dove_fly_up_%02d.png", i]];
			[flyDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"dove_fly_down_%02d.png", i]];
			[flyLeftUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"dove_fly_leftUp_%02d.png", i]];
			[flyLeftDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"dove_fly_leftDown_%02d.png", i]];
			[flyLeftAnimation addFrameWithFilename:[NSString stringWithFormat:@"dove_fly_left_%02d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyUpAnimation]] forKey:@"fly_up"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyDownAnimation]] forKey:@"fly_down"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftUpAnimation]] forKey:@"fly_leftUp"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftDownAnimation]] forKey:@"fly_leftDown"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftAnimation]] forKey:@"fly_left"];
		
		//add eat animation
		for (int i = 1; i<=9; i++) {
			[eatAnimation addFrameWithFilename:[NSString stringWithFormat:@"dove_eat_left_%02d.png",i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:eatAnimation]] forKey:@"eat_left"];
		
		
		//ill textures
		CCTexture2D *illUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"dove_ill_up.png" ofType:nil]]];
		CCTexture2D *illDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"dove_ill_down.png" ofType:nil]]];
		CCTexture2D *illLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"dove_ill_leftUp.png" ofType:nil]]];
		CCTexture2D *illLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"dove_ill_leftDown.png" ofType:nil]]];
		CCTexture2D *illLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"dove_ill_left.png" ofType:nil]]];
		
		//sleep textures
		CCTexture2D *sleepUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"dove_sleep_up.png" ofType:nil]]];
		CCTexture2D *sleepDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"dove_sleep_down.png" ofType:nil]]];
		CCTexture2D *sleepLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"dove_sleep_leftUp.png" ofType:nil]]];
		CCTexture2D *sleepLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"dove_sleep_leftDown.png" ofType:nil]]];
		CCTexture2D *sleepLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"dove_sleep_left.png" ofType:nil]]];
		
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