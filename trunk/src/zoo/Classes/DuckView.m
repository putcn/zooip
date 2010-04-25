//
//  DuckView.m
//  zoo
//
//  Created by Rainbow on 4/22/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DuckView.h"


@implementation DuckView

-(id) initWithPrefix:(NSString *)prefix
{	
	if ((self = [super initWithPrefix:prefix])) {
		//walk animations
		CCAnimation* walkUpAnimation = [CCAnimation animationWithName:@"walkUp" delay:0.04f];
		CCAnimation* walkDownAnimation = [CCAnimation animationWithName:@"walkRightUp" delay:0.04f];
		CCAnimation* walkLeftUpAnimation = [CCAnimation animationWithName:@"walkRight" delay:0.04f];
		CCAnimation* walkLeftDownAnimation = [CCAnimation animationWithName:@"walkRightDown" delay:0.04f];
		CCAnimation* walkLeftAnimation = [CCAnimation animationWithName:@"walkDown" delay:0.04f];
		
		//eat animation
		CCAnimation* eatAnimation = [CCAnimation animationWithName:@"eat" delay:0.04f];
		
		//add walk animations to animationTable
		for (int i = 1; i<=16; i++) {
			[walkUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"duck_walk_up_%02d.png", i]];
			[walkDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"duck_walk_down_%02d.png", i]];
			[walkLeftUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"duck_walk_leftUp_%02d.png", i]];
			[walkLeftDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"duck_walk_leftDown_%02d.png", i]];
			[walkLeftAnimation addFrameWithFilename:[NSString stringWithFormat:@"duck_walk_left_%02d.png", i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkUpAnimation]] forKey:@"walk_up"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkDownAnimation]] forKey:@"walk_down"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftUpAnimation]] forKey:@"walk_leftUp"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftDownAnimation]] forKey:@"walk_leftDown"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnimation]] forKey:@"walk_left"];
		
		//add eat animation
		for (int i = 1; i<=60; i++) {
			[eatAnimation addFrameWithFilename:[NSString stringWithFormat:@"duck_eat_left_%02d.png",i]];
		}
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:eatAnimation]] forKey:@"eat_left"];
		
		//swimming textures
		CCTexture2D *illUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_up.png" ofType:nil]]];
		CCTexture2D *illDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_down.png" ofType:nil]]];
		CCTexture2D *illLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_leftUp.png" ofType:nil]]];
		CCTexture2D *illLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_leftDown.png" ofType:nil]]];
		CCTexture2D *illLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_left.png" ofType:nil]]];
		
		//ill textures
		CCTexture2D *illUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_ill_up.png" ofType:nil]]];
		CCTexture2D *illDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_ill_down.png" ofType:nil]]];
		CCTexture2D *illLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_ill_leftUp.png" ofType:nil]]];
		CCTexture2D *illLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_ill_leftDown.png" ofType:nil]]];
		CCTexture2D *illLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_ill_left.png" ofType:nil]]];
		
		//add swimming textures to animationTable
		[animationTable setObject:sleepUp forKey:@"swimming_up"];
		[animationTable setObject:sleepDown forKey:@"swimming_down"];
		[animationTable setObject:sleepLeftUp	forKey:@"swimming_leftUp"];
		[animationTable setObject:sleepLeftDown forKey:@"swimming_leftDown"];
		[animationTable setObject:sleepLeft forKey:@"swimming_left"];
		
		//add ill textures to animationTable
		[animationTable setObject:illUp forKey:@"ill_up"];
		[animationTable setObject:illDown forKey:@"ill_down"];
		[animationTable setObject:illLeftUp	forKey:@"ill_leftUp"];
		[animationTable setObject:illLeftDown forKey:@"ill_leftDown"];
		[animationTable setObject:illLeft forKey:@"ill_left"];
		
		
	}
	return self;
	
}


@end
