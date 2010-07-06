//
//  MallardView.m
//  zoo
//
//  Created by Rainbow on 4/22/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "MallardView.h"
#import "AnimalImageProperty.h"


@implementation MallardView


-(id) init
{	
	if ((self = [super init])) {
		
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		animationTable = [imageProp animationTable:@"_Mallard_1.png" plistName:@"_Mallard_1.plist"];
		animationTable = [imageProp animationTable:@"_Mallard_2.png" plistName:@"_Mallard_2.plist"];
		NSLog(@"------------%@", animationTable);
		
		
//		//walk animations
//		CCAnimation* walkUpAnimation = [CCAnimation animationWithName:@"walkUp" delay:0.04f];
//		CCAnimation* walkDownAnimation = [CCAnimation animationWithName:@"walkRightUp" delay:0.04f];
//		CCAnimation* walkLeftUpAnimation = [CCAnimation animationWithName:@"walkRight" delay:0.04f];
//		CCAnimation* walkLeftDownAnimation = [CCAnimation animationWithName:@"walkRightDown" delay:0.04f];
//		CCAnimation* walkLeftAnimation = [CCAnimation animationWithName:@"walkDown" delay:0.04f];
//		
//		//fly animations
//		CCAnimation* flyUpAnimation = [CCAnimation animationWithName:@"flyUp" delay:0.04f];
//		CCAnimation* flyDownAnimation = [CCAnimation animationWithName:@"flyRightUp" delay:0.04f];
//		CCAnimation* flyLeftUpAnimation = [CCAnimation animationWithName:@"flyRight" delay:0.04f];
//		CCAnimation* flyLeftDownAnimation = [CCAnimation animationWithName:@"flyRightDown" delay:0.04f];
//		CCAnimation* flyLeftAnimation = [CCAnimation animationWithName:@"flyDown" delay:0.04f];
//		
//		//eat animation
//		CCAnimation* eatAnimation = [CCAnimation animationWithName:@"eat" delay:0.04f];
//		
//		
//		//add eat animation
//		for (int i = 1; i<=32; i++) {
//			[eatAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_eat_left_%02d.png",i]];
//		}
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:eatAnimation]] forKey:@"eat_left"];
//		
//	
//		//swimming textures
//		CCTexture2D *swimmingUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_swimming_up.png" ofType:nil]]];
//		CCTexture2D *swimmingDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_swimming_down.png" ofType:nil]]];
//		CCTexture2D *swimmingLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_swimming_leftUp.png" ofType:nil]]];
//		CCTexture2D *swimmingLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_swimming_leftDown.png" ofType:nil]]];
//		CCTexture2D *swimmingLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_swimming_left.png" ofType:nil]]];
//		
//		
//		
//		//transition
//		CCAnimation* transitionUpAnimation = [CCAnimation animationWithName:@"transitionUp" delay:0.04f];
//		CCAnimation* transitionDownAnimation = [CCAnimation animationWithName:@"transitionRightUp" delay:0.04f];
//		CCAnimation* transitionLeftUpAnimation = [CCAnimation animationWithName:@"transitionRight" delay:0.04f];
//		CCAnimation* transitionLeftDownAnimation = [CCAnimation animationWithName:@"transitionRightDown" delay:0.04f];
//		CCAnimation* transitionLeftAnimation = [CCAnimation animationWithName:@"transitionDown" delay:0.04f];
//		
//		//landing
//		CCAnimation* landingUpAnimation = [CCAnimation animationWithName:@"landingUp" delay:0.04f];
//		CCAnimation* landingDownAnimation = [CCAnimation animationWithName:@"landingRightUp" delay:0.04f];
//		CCAnimation* landingLeftUpAnimation = [CCAnimation animationWithName:@"landingRight" delay:0.04f];
//		CCAnimation* landingLeftDownAnimation = [CCAnimation animationWithName:@"landingRightDown" delay:0.04f];
//		CCAnimation* landingLeftAnimation = [CCAnimation animationWithName:@"landingDown" delay:0.04f];
//		
//		//add walk animations to animationTable
//		for (int i = 1; i<=16; i++) {
//			[walkUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_walk_up_%02d.png", i]];
//			[walkDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_walk_down_%02d.png", i]];
//			[walkLeftUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_walk_leftUp_%02d.png", i]];
//			[walkLeftDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_walk_leftDown_%02d.png", i]];
//			[walkLeftAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_walk_left_%02d.png", i]];
//		}
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkUpAnimation]] forKey:@"walk_up"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkDownAnimation]] forKey:@"walk_down"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftUpAnimation]] forKey:@"walk_leftUp"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftDownAnimation]] forKey:@"walk_leftDown"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnimation]] forKey:@"walk_left"];
//		
//		//add fly animations to animationTable
//		for (int i = 1; i<=11; i++) {
//			[flyUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_fly_up_%02d.png", i]];
//			[flyDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"wildgmallard_fly_down_%02d.png", i]];
//			[flyLeftUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_fly_leftUp_%02d.png", i]];
//			[flyLeftDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_fly_leftDown_%02d.png", i]];
//			[flyLeftAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_fly_left_%02d.png", i]];
//		}
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyUpAnimation]] forKey:@"fly_up"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyDownAnimation]] forKey:@"fly_down"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftUpAnimation]] forKey:@"fly_leftUp"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftDownAnimation]] forKey:@"fly_leftDown"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftAnimation]] forKey:@"fly_left"];
//		
//		
//		//add transiton animations to animationTable
//		for (int i = 1; i<=16; i++) {
//			[transitionUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_transition_up_%02d.png", i]];
//			[transitionDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_transition_down_%02d.png", i]];
//			[transitionLeftUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_transition_leftUp_%02d.png", i]];
//			[transitionLeftDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_transition_leftDown_%02d.png", i]];
//			[transitionLeftAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_transition_left_%02d.png", i]];
//		}
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyUpAnimation]] forKey:@"transition_up"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyDownAnimation]] forKey:@"transition_down"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftUpAnimation]] forKey:@"transition_leftUp"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftDownAnimation]] forKey:@"transition_leftDown"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftAnimation]] forKey:@"transition_left"];
//		
//		
//		//add landing animations to animationTable
//		for (int i = 1; i<=10; i++) {
//			[landingUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_landing_up_%02d.png", i]];
//			[landingDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_landing_down_%02d.png", i]];
//			[landingLeftUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_landing_leftUp_%02d.png", i]];
//			[landingLeftDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_landing_leftDown_%02d.png", i]];
//			[landingLeftAnimation addFrameWithFilename:[NSString stringWithFormat:@"mallard_landing_left_%02d.png", i]];
//		}
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyUpAnimation]] forKey:@"landing_up"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyDownAnimation]] forKey:@"landing_down"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftUpAnimation]] forKey:@"landing_leftUp"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftDownAnimation]] forKey:@"landing_leftDown"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:flyLeftAnimation]] forKey:@"landing_left"];
//		
//		
//		
//		//add swimming textures to animationTable
//		[animationTable setObject:swimmingUp forKey:@"swimming_up"];
//		[animationTable setObject:swimmingDown forKey:@"swimming_down"];
//		[animationTable setObject:swimmingLeftUp forKey:@"swimming_leftUp"];
//		[animationTable setObject:swimmingLeftDown forKey:@"swimming_leftDown"];
//		[animationTable setObject:swimmingLeft forKey:@"swimming_left"];
//		
//		
//		
//		//stand textures
//		CCTexture2D *standLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard.png" ofType:nil]]];
//		//add stand textures
//		[animationTable setObject:standLeft forKey:@"stand_left"];
//		
//		
//		
//		
//		//ill textures
//		CCTexture2D *illUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_ill_up.png" ofType:nil]]];
//		CCTexture2D *illDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_ill_down.png" ofType:nil]]];
//		CCTexture2D *illLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_ill_leftUp.png" ofType:nil]]];
//		CCTexture2D *illLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_ill_leftDown.png" ofType:nil]]];
//		CCTexture2D *illLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_ill_left.png" ofType:nil]]];
//		
//		//sleep textures
//		CCTexture2D *sleepUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_sleep_up.png" ofType:nil]]];
//		CCTexture2D *sleepDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_sleep_down.png" ofType:nil]]];
//		CCTexture2D *sleepLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_sleep_leftUp.png" ofType:nil]]];
//		CCTexture2D *sleepLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_sleep_leftDown.png" ofType:nil]]];
//		CCTexture2D *sleepLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mallard_sleep_left.png" ofType:nil]]];
//		
//		//add ill textures to animationTable
//		[animationTable setObject:illUp forKey:@"ill_up"];
//		[animationTable setObject:illDown forKey:@"ill_down"];
//		[animationTable setObject:illLeftUp	forKey:@"ill_leftUp"];
//		[animationTable setObject:illLeftDown forKey:@"ill_leftDown"];
//		[animationTable setObject:illLeft forKey:@"ill_left"];
//		
//		//add sleep textures to animationTable
//		[animationTable setObject:sleepUp forKey:@"sleep_up"];
//		[animationTable setObject:sleepDown forKey:@"sleep_down"];
//		[animationTable setObject:sleepLeftUp	forKey:@"sleep_leftUp"];
//		[animationTable setObject:sleepLeftDown forKey:@"sleep_leftDown"];
//		[animationTable setObject:sleepLeft forKey:@"sleep_left"];
//		
//		
//		NSLog(@"view x:%d, y:%d", self.contentSize.width, self.contentSize.height*3/2);
	}
	return self;
	
}



// Add by Hunk on 2010-06-29
-(void)dealloc
{
	
	
	[super dealloc];
}






@end
