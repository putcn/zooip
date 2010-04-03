//
//  GameMainScene.m
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "GameMainScene.h"
#import "AnimalView.h"
#import "Animal.h"

@implementation GameMainScene

+(id) scene
{
	CCScene *scene = [CCScene node];
	GameMainScene *layer = [GameMainScene node];
	
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) 
	{
		// 实际应用中应使用AnimalView的子类，如DuckView
		AnimalView *view  = [[AnimalView alloc] initWithPrefix:@"Animal"];
		
		Animal *animal = [[Animal alloc] initWithView:view setSpeed:0.2f];
		
		[self addChild:view];
	}
	return self;
}

-(void) dealloc
{
	[super dealloc];
}

@end
