//
//  MandarinDuckView.m
//  zoo
//
//  Created by Rainbow on 4/29/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "MandarinDuckView.h"
#import "AnimalImageProperty.h"


@implementation MandarinDuckView


-(id) init
{	
	if ((self = [super init])) {
		
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		animationTable = [imageProp animationTable:@"_MandarinDuck.png" plistName:@"_MandarinDuck.plist"];
		NSLog(@"------------%@", animationTable);
		
		// Add by Hunk on 2010-07-13 for memory leak
		//[imageProp release];
		
//		//walk animations
//		CCAnimation* walkUpAnimation = [CCAnimation animationWithName:@"walkUp" delay:0.04f];
//		CCAnimation* walkDownAnimation = [CCAnimation animationWithName:@"walkRightUp" delay:0.04f];
//		CCAnimation* walkLeftUpAnimation = [CCAnimation animationWithName:@"walkRight" delay:0.04f];
//		CCAnimation* walkLeftDownAnimation = [CCAnimation animationWithName:@"walkRightDown" delay:0.04f];
//		CCAnimation* walkLeftAnimation = [CCAnimation animationWithName:@"walkDown" delay:0.04f];
//		
//		//eat animation
//		CCAnimation* eatAnimation = [CCAnimation animationWithName:@"eat" delay:0.04f];
//		
//		
//		//add eat animation
//		for (int i = 1; i<=24; i++) {
//			[eatAnimation addFrameWithFilename:[NSString stringWithFormat:@"maleMandarinDuck_eat_left_%02d.png",i]];
//		}
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:eatAnimation]] forKey:@"eat_left"];
//		
//		
//		//swimming textures
//		CCTexture2D *swimmingUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_swimming_up.png" ofType:nil]]];
//		CCTexture2D *swimmingDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_swimming_down.png" ofType:nil]]];
//		CCTexture2D *swimmingLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_swimming_leftUp.png" ofType:nil]]];
//		CCTexture2D *swimmingLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_swimming_leftDown.png" ofType:nil]]];
//		CCTexture2D *swimmingLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_swimming_left.png" ofType:nil]]];
//		
//		//add walk animations to animationTable
//		for (int i = 1; i<=17; i++) {
//			[walkUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"maleMandarinDuck_walk_up_%02d.png", i]];
//			[walkDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"maleMandarinDuck_walk_down_%02d.png", i]];
//			[walkLeftUpAnimation addFrameWithFilename:[NSString stringWithFormat:@"maleMandarinDuck_walk_leftUp_%02d.png", i]];
//			[walkLeftDownAnimation addFrameWithFilename:[NSString stringWithFormat:@"maleMandarinDuck_walk_leftDown_%02d.png", i]];
//			[walkLeftAnimation addFrameWithFilename:[NSString stringWithFormat:@"maleMandarinDuck_walk_left_%02d.png", i]];
//		}
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkUpAnimation]] forKey:@"walk_up"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkDownAnimation]] forKey:@"walk_down"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftUpAnimation]] forKey:@"walk_leftUp"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftDownAnimation]] forKey:@"walk_leftDown"];
//		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnimation]] forKey:@"walk_left"];
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
//		//ill textures
//		CCTexture2D *illUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_ill_up.png" ofType:nil]]];
//		CCTexture2D *illDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_ill_down.png" ofType:nil]]];
//		CCTexture2D *illLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_ill_leftUp.png" ofType:nil]]];
//		CCTexture2D *illLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_ill_leftDown.png" ofType:nil]]];
//		CCTexture2D *illLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_ill_left.png" ofType:nil]]];
//		
//		//sleep textures
//		CCTexture2D *sleepUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_sleep_up.png" ofType:nil]]];
//		CCTexture2D *sleepDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_sleep_down.png" ofType:nil]]];
//		CCTexture2D *sleepLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_sleep_leftUp.png" ofType:nil]]];
//		CCTexture2D *sleepLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_sleep_leftDown.png" ofType:nil]]];
//		CCTexture2D *sleepLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"maleMandarinDuck_sleep_left.png" ofType:nil]]];
//		
//		
//		//stand textures
//		CCTexture2D *standLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mandarinduck.png" ofType:nil]]];
//		//add stand textures
//		[animationTable setObject:standLeft forKey:@"stand_left"];				
//		
//			
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
