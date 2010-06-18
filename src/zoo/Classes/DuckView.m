//
//  DuckView.m
//  zoo
//
//  Created by Rainbow on 4/22/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DuckView.h"
#import "ImgInitUtil.h"


@implementation DuckView

-(id) init
{	
	if ((self = [super init])) {
		//walk animations
		CCAnimation* walkUpAnimation = [[ImgInitUtil sharedImgInitUtil] getAnimate:@"duck1.png" setOriginX:1120 setOriginY:186 setWidth:30 setHeight:75 setNumber:16 setMaxOneline:20];
		CCAnimation* walkDownAnimation = [[ImgInitUtil sharedImgInitUtil] getAnimate:@"duck1.png" setOriginX:1040 setOriginY:261 setWidth:30 setHeight:82 setNumber:16 setMaxOneline:20];
		CCAnimation* walkLeftUpAnimation = [[ImgInitUtil sharedImgInitUtil] getAnimate:@"duck1.png" setOriginX:0 setOriginY:343 setWidth:55 setHeight:73 setNumber:16 setMaxOneline:20];
		CCAnimation* walkLeftDownAnimation = [[ImgInitUtil sharedImgInitUtil] getAnimate:@"duck1.png" setOriginX:0 setOriginY:261 setWidth:65 setHeight:68 setNumber:16 setMaxOneline:20];
		CCAnimation* walkLeftAnimation = [[ImgInitUtil sharedImgInitUtil] getAnimate:@"duck1.png" setOriginX:0 setOriginY:186 setWidth:70 setHeight:55 setNumber:16 setMaxOneline:20];
		
		//eat animation
		CCAnimation* eatAnimation = [[ImgInitUtil sharedImgInitUtil] getAnimate:@"duck1.png" setOriginX:0 setOriginY:0 setWidth:85 setHeight:62 setNumber:60 setMaxOneline:20];
		
		//add walk animations to animationTable
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkUpAnimation]] forKey:@"walk_up"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkDownAnimation]] forKey:@"walk_down"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftUpAnimation]] forKey:@"walk_leftUp"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftDownAnimation]] forKey:@"walk_leftDown"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkLeftAnimation]] forKey:@"walk_left"];
		[animationTable setObject:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:eatAnimation]] forKey:@"eat_left"];
		
		
		//stand textures
		CCTexture2D *standLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck.png" ofType:nil]]];
		//add stand textures
		[animationTable setObject:standLeft forKey:@"stand_left"];				
		
		//swimming textures
		CCTexture2D *swimmingUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_up.png" ofType:nil]]];
		CCTexture2D *swimmingDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_down.png" ofType:nil]]];
		CCTexture2D *swimmingLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_leftUp.png" ofType:nil]]];
		CCTexture2D *swimmingLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_leftDown.png" ofType:nil]]];
		CCTexture2D *swimmingLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_left.png" ofType:nil]]];
		
		//ill textures
		CCTexture2D *illUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_ill_up.png" ofType:nil]]];
		CCTexture2D *illDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_ill_down.png" ofType:nil]]];
		CCTexture2D *illLeftUp = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_ill_leftUp.png" ofType:nil]]];
		CCTexture2D *illLeftDown = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_ill_leftDown.png" ofType:nil]]];
		CCTexture2D *illLeft = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_ill_left.png" ofType:nil]]];
		
		//add swimming textures to animationTable
		[animationTable setObject:swimmingUp forKey:@"swimming_up"];
		[animationTable setObject:swimmingDown forKey:@"swimming_down"];
		[animationTable setObject:swimmingLeftUp forKey:@"swimming_leftUp"];
		[animationTable setObject:swimmingLeftDown forKey:@"swimming_leftDown"];
		[animationTable setObject:swimmingLeft forKey:@"swimming_left"];
		
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
