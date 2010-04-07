//
//  GameMainScene.m
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "GameMainScene.h"
#import "MallardView.h"
#import "DoveView.h"
#import "ChickenView.h"
#import "MaleMandarinDuckView.h"
#import "PeacockView.h"
#import "ChinemyView.h"
#import "SnakeView.h"
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
		//set the backgroud and the size set 50%
		baseContainer = [CCSprite spriteWithFile:@"Icon.png"];
		baseContainer.position = ccp(14.25,14.25);
		baseContainer.scale = 0.5f;
		[self addChild:baseContainer];
		
		background = [CCSprite spriteWithFile:@"bgimg.jpg"];
		background.scale = 0.95f;
		background.position = ccp(480,320);
		
		tree = [CCSprite spriteWithFile:@"tree.png"];
		tree.position = ccp(750,400);
		[baseContainer addChild:tree z:1];
		
		house = [CCSprite spriteWithFile:@"house.png"];
		house.position = ccp(450,410);
		[baseContainer addChild:house z:1];
		
		waterbox = [CCSprite spriteWithFile:@"waterbox.png"];
		waterbox.position = ccp(330,420);
		[baseContainer addChild:waterbox z:1];
		
		egg1 = [CCSprite spriteWithFile:@"丹顶鹤蛋.png"];
		egg1.position = ccp(500,50);
		[baseContainer addChild:egg1 z:2];
		
		egg2 = [CCSprite spriteWithFile:@"喜鹊蛋.png"];
		egg2.position = ccp(610,130);
		[baseContainer addChild:egg2 z:2];
		
		egg3 = [CCSprite spriteWithFile:@"大雁蛋.png"];
		egg3.position = ccp(720,46);
		[baseContainer addChild:egg3 z:2];
		
		egg4 = [CCSprite spriteWithFile:@"天鹅蛋.png"];
		egg4.position = ccp(530,140);
		[baseContainer addChild:egg4 z:2];
		
		egg5 = [CCSprite spriteWithFile:@"孔雀蛋.png"];
		egg5.position = ccp(580,104);
		[baseContainer addChild:egg5 z:2];
		
		egg6 = [CCSprite spriteWithFile:@"火鸡蛋.png"];
		egg6.position = ccp(650,107);
		[baseContainer addChild:egg6 z:2];
		
		egg7 = [CCSprite spriteWithFile:@"野鸡蛋.png"];
		egg7.position = ccp(560,23);
		[baseContainer addChild:egg7 z:2];
		
		egg8 = [CCSprite spriteWithFile:@"野鸭蛋.png"];
		egg8.position = ccp(570,54);
		[baseContainer addChild:egg8 z:2];
		
		egg9 = [CCSprite spriteWithFile:@"鸡蛋.png"];
		egg9.position = ccp(680,100);
		[baseContainer addChild:egg9 z:2];
		
		egg10 = [CCSprite spriteWithFile:@"鸳鸯蛋.png"];
		egg10.position = ccp(590,178);
		[baseContainer addChild:egg10 z:2];
		
		pan = [CCSprite spriteWithFile:@"喂食3.png"];
		pan.position = ccp(300,100);
		[baseContainer addChild:pan z:2];
		
		snake1 = [CCSprite spriteWithFile:@"snake_sleep_2.png"];
		snake1.position = ccp(700,100);
		[baseContainer addChild:snake1 z:3];
		
		snake2 = [CCSprite spriteWithFile:@"snake_sleep_5.png"];
		snake2.position = ccp(700,50);
		[baseContainer addChild:snake2 z:3];
		
		
		[baseContainer addChild: background z:0];
		
		// 实际应用中应使用AnimalView的子类，如DuckView
//		AnimalView *view  = [[AnimalView alloc] initWithPrefix:@"Animal"];
//		
//		Animal *animal = [[Animal alloc] initWithView:view setSpeed:0.2f];
		
		MallardView *mallardView = [[MallardView alloc] initWithPrefix:@"mallard"];
		mallardView.position = ccp(400,200);
		Animal *mallard = [[Animal alloc] initWithView:mallardView setSpeed:0.2f];
		
		DoveView *doveView = [[DoveView alloc] initWithPrefix:@"dove"];
		doveView.position = ccp(400,500);
		Animal *dove = [[Animal alloc] initWithView:doveView setSpeed:0.2f];
		
		DoveView *doveView1 = [[DoveView alloc] initWithPrefix:@"dove1"];
		doveView1.position = ccp(600,450);
		Animal *dove1 = [[Animal alloc] initWithView:doveView1 setSpeed:0.2f];
		
		ChickenView *chickenView = [[ChickenView alloc] initWithPrefix:@"chicken"];
		chickenView.position = ccp(700,300);
		Animal *chicken = [[Animal alloc] initWithView:chickenView setSpeed:0.2f];	
		
		PeacockView *peacockView = [[PeacockView alloc] initWithPrefix:@"peacoke"];
		peacockView.position = ccp(600,200);
		Animal *peacock = [[Animal alloc] initWithView:peacockView setSpeed:0.2f];
		
		SnakeView *snakeView = [[SnakeView alloc] initWithPrefix:@"snake"];
		snakeView.position = ccp(700,200);
		Animal *snake = [[Animal alloc] initWithView:snakeView setSpeed:0.05f];
		
//		ChinemyView *chinemyView = [[ChinemyView alloc] initWithPrefix:@"chinemy"];
//		chinemyView.position = ccp(600,500);
//		Animal *chinemy = [[Animal alloc] initWithView:chinemyView setSpeed:0.1f];
//		
//		MaleMandarinDuckView *maleMandarinDuckView = [[MaleMandarinDuckView alloc] initWithPrefix:@"maleMandarinDuck"];
//		maleMandarinDuckView.position = ccp(350,620);
//		Animal *maleMandarinDuck = [[Animal alloc] initWithView:maleMandarinDuckView setSpeed:1.0f];
		
		[baseContainer addChild:mallardView z:4];
		[baseContainer addChild:doveView z:4];
		[baseContainer addChild:doveView1 z:4];
		[baseContainer addChild:chickenView z:4];
		[baseContainer addChild:peacockView z:4];
		[baseContainer addChild:snakeView z:4];
	//	[baseContainer addChild:chinemyView z:4];
	//	[baseContainer addChild:maleMandarinDuckView z:4];
	
		
	}
	return self;
}

-(void) dealloc
{
	[super dealloc];
}

@end
