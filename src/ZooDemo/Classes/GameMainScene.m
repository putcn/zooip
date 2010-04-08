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
#import "ScaleControlLayer.h"
#import "MalePhasianusColchicusView.h"
#import "UILayer.h"

@implementation GameMainScene

static GameMainScene *_sharedGameMainScene = nil;

+ (GameMainScene *)sharedGameMainScene
{
	@synchronized([GameMainScene class])
	{
		if (!_sharedGameMainScene)
		{
			_sharedGameMainScene = [GameMainScene node];
		}
		
		return _sharedGameMainScene;
	}
	
	return nil;
}

+(id) scene
{
	CCScene *scene = [CCScene node];
	GameMainScene *layer = [GameMainScene sharedGameMainScene];
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) 
	{
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		//set the backgroud and the size set 50%
		baseContainer = [CCSprite node];
		baseContainer.position = ccp(-size.width / 2, -size.height / 2);
		baseContainer.scale = 0.5f;
		
		CCSprite *scaleContainer = [CCSprite node];
		scaleContainer.position = ccp( size.width / 2, size.height / 2);
		[scaleContainer addChild:baseContainer];
		[self addChild:scaleContainer];
		//baseContainer.anchorPoint = ccp( size.width / 2, size.height / 2);
		
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
		//	[baseContainer addChild:egg1 z:2];
		
		egg2 = [CCSprite spriteWithFile:@"喜鹊蛋.png"];
		egg2.position = ccp(610,130);
		//	[baseContainer addChild:egg2 z:2];
		
		egg3 = [CCSprite spriteWithFile:@"大雁蛋.png"];
		egg3.position = ccp(720,46);
		//	[baseContainer addChild:egg3 z:2];
		
		egg4 = [CCSprite spriteWithFile:@"天鹅蛋.png"];
		egg4.position = ccp(530,140);
		//	[baseContainer addChild:egg4 z:2];
		
		egg5 = [CCSprite spriteWithFile:@"孔雀蛋.png"];
		egg5.position = ccp(580,104);
		//	[baseContainer addChild:egg5 z:2];
		
		egg6 = [CCSprite spriteWithFile:@"火鸡蛋.png"];
		egg6.position = ccp(650,107);
		//	[baseContainer addChild:egg6 z:2];
		
		egg7 = [CCSprite spriteWithFile:@"野鸡蛋.png"];
		egg7.position = ccp(560,23);
		//	[baseContainer addChild:egg7 z:2];
		
		egg8 = [CCSprite spriteWithFile:@"野鸭蛋.png"];
		egg8.position = ccp(570,54);
		//	[baseContainer addChild:egg8 z:2];
		
		egg9 = [CCSprite spriteWithFile:@"鸡蛋.png"];
		egg9.position = ccp(680,100);
		//	[baseContainer addChild:egg9 z:2];
		
		egg10 = [CCSprite spriteWithFile:@"鸳鸯蛋.png"];
		egg10.position = ccp(590,178);
		//	[baseContainer addChild:egg10 z:2];
		
		pan = [CCSprite spriteWithFile:@"喂食3.png"];
		pan.position = ccp(300,100);
		//	[baseContainer addChild:pan z:2];
		
		egg11 = [CCSprite spriteWithFile:@"丹顶鹤蛋.png"];
		egg11.position = ccp(532,150);
		//	[baseContainer addChild:egg1 z:2];
		
		egg12 = [CCSprite spriteWithFile:@"喜鹊蛋.png"];
		egg12.position = ccp(589,130);
		//	[baseContainer addChild:egg2 z:2];
		
		egg13 = [CCSprite spriteWithFile:@"大雁蛋.png"];
		egg13.position = ccp(720,26);
		//	[baseContainer addChild:egg3 z:2];
		
		egg14 = [CCSprite spriteWithFile:@"天鹅蛋.png"];
		egg14.position = ccp(630,80);
		//	[baseContainer addChild:egg4 z:2];
		
		egg15 = [CCSprite spriteWithFile:@"孔雀蛋.png"];
		egg15.position = ccp(580,104);
		//	[baseContainer addChild:egg5 z:2];
		
		egg16 = [CCSprite spriteWithFile:@"火鸡蛋.png"];
		egg16.position = ccp(590,20);
		//	[baseContainer addChild:egg6 z:2];
		
		egg17 = [CCSprite spriteWithFile:@"野鸡蛋.png"];
		egg17.position = ccp(644,23);
		//	[baseContainer addChild:egg7 z:2];
		
		egg18 = [CCSprite spriteWithFile:@"野鸭蛋.png"];
		egg18.position = ccp(700,154);
		//	[baseContainer addChild:egg8 z:2];
		
		egg19 = [CCSprite spriteWithFile:@"鸡蛋.png"];
		egg19.position = ccp(583,140);
		//	[baseContainer addChild:egg9 z:2];
		
		egg20 = [CCSprite spriteWithFile:@"鸳鸯蛋.png"];
		egg20.position = ccp(639,178);
		//	[baseContainer addChild:egg10 z:2];
		
		pan1 = [CCSprite spriteWithFile:@"喂食1.png"];
		pan1.position = ccp(300,100);
		//	[baseContainer addChild:pan z:2];	

		
		[baseContainer addChild: background z:0];
		
		mySceneArray = [[NSMutableArray alloc] init];
		[mySceneArray addObject:egg1];
		[mySceneArray addObject:egg2];
		[mySceneArray addObject:egg3];
		[mySceneArray addObject:egg4];
		[mySceneArray addObject:egg5];
		[mySceneArray addObject:egg6];
		[mySceneArray addObject:egg7];
		[mySceneArray addObject:egg8];
		[mySceneArray addObject:egg9];
		[mySceneArray addObject:egg10];
		[mySceneArray addObject:pan];
		
		for (CCSprite *tempSprite in mySceneArray) {
			[baseContainer addChild:tempSprite z:2];
		}
		friendSceneArray = [[NSMutableArray alloc] init];
		[friendSceneArray addObject:egg11];
		[friendSceneArray addObject:egg12];
		[friendSceneArray addObject:egg13];
		[friendSceneArray addObject:egg14];
		[friendSceneArray addObject:egg15];
		[friendSceneArray addObject:egg16];
		[friendSceneArray addObject:egg17];
		[friendSceneArray addObject:egg18];
		[friendSceneArray addObject:egg19];
		[friendSceneArray addObject:egg20];
		[friendSceneArray addObject:pan1];
		
		// ÂÆûÈôÖÂ∫îÁî®‰∏≠Â∫î‰ΩøÁî®AnimalViewÁöÑÂ≠êÁ±ªÔºåÂ¶ÇDuckView
		//		AnimalView *view  = [[AnimalView alloc] initWithPrefix:@"Animal"];
		//		
		//		Animal *animal = [[Animal alloc] initWithView:view setSpeed:0.2f];
		
		MallardView *mallardView = [[MallardView alloc] initWithPrefix:@"mallard"];
		mallardView.position = ccp(400,210);
		Animal *mallard = [[Animal alloc] initWithView:mallardView setSpeed:0.2f setLimitRect:CGRectMake(280,0,450,360)];
		
		DoveView *doveView = [[DoveView alloc] initWithPrefix:@"dove"];
		doveView.position = ccp(400,500);
		Animal *dove = [[Animal alloc] initWithView:doveView setSpeed:0.5f setLimitRect:CGRectMake(0,360,960,360)];
		
		DoveView *doveView1 = [[DoveView alloc] initWithPrefix:@"dove1"];
		doveView1.position = ccp(600,450);
		Animal *dove1 = [[Animal alloc] initWithView:doveView1 setSpeed:0.5f setLimitRect:CGRectMake(0,360,960,360)];
		
		ChickenView *chickenView = [[ChickenView alloc] initWithPrefix:@"chicken"];
		chickenView.position = ccp(300,300);
		Animal *chicken = [[Animal alloc] initWithView:chickenView setSpeed:0.2f setLimitRect:CGRectMake(280,0,450,360)];	
		
		PeacockView *peacockView = [[PeacockView alloc] initWithPrefix:@"peacoke"];
		peacockView.position = ccp(580,220);
		Animal *peacock = [[Animal alloc] initWithView:peacockView setSpeed:0.2f setLimitRect:CGRectMake(280,0,450,360)];
		
		SnakeView *snakeView = [[SnakeView alloc] initWithPrefix:@"snake"];
		snakeView.position = ccp(600,150);
		Animal *snake = [[Animal alloc] initWithView:snakeView setSpeed:0.05f setLimitRect:CGRectMake(480,0,480,240)];
		
		//		ChinemyView *chinemyView = [[ChinemyView alloc] initWithPrefix:@"chinemy"];
		//		chinemyView.position = ccp(600,500);
		//		Animal *chinemy = [[Animal alloc] initWithView:chinemyView setSpeed:0.1f];
		//		
		MaleMandarinDuckView *maleMandarinDuckView = [[MaleMandarinDuckView alloc] initWithPrefix:@"maleMandarinDuck"];
		maleMandarinDuckView.position = ccp(120,300);
		Animal *maleMandarinDuck = [[Animal alloc] initWithView:maleMandarinDuckView setSpeed:0.2f setLimitRect:CGRectMake(0, 280, 240, 100)];
		
		myAnimalArray = [[NSMutableArray alloc] init];
		[myAnimalArray addObject:mallardView];
		[myAnimalArray addObject:doveView];
		[myAnimalArray addObject:doveView1];
		[myAnimalArray addObject:chickenView];
		[myAnimalArray addObject:peacockView];
		[myAnimalArray addObject:snakeView];
		[myAnimalArray addObject:maleMandarinDuckView];
		
		for (AnimalView *animalView in myAnimalArray) {
			[baseContainer addChild:animalView z:4];
		}
		
		
		MalePhasianusColchicusView *malePhasianusColchicusView = [[MalePhasianusColchicusView alloc] initWithPrefix:@"malePhasianusCochicus"];
		malePhasianusColchicusView.position = ccp(400,210);
		Animal *malePhasianusColchicus = [[Animal alloc] initWithView:malePhasianusColchicusView setSpeed:0.5f setLimitRect:CGRectMake(280,0,450,360)];
		
		friendAnimalArray = [[NSMutableArray alloc] init];
		[friendAnimalArray addObject:malePhasianusColchicus];
		//		
		//		[baseContainer addChild:mallardView z:4];
		//		[baseContainer addChild:doveView z:4];
		//		[baseContainer addChild:doveView1 z:4];
		//		[baseContainer addChild:chickenView z:4];
		//		[baseContainer addChild:peacockView z:4];
		//		[baseContainer addChild:snakeView z:4];
		//	//	[baseContainer addChild:chinemyView z:4];
		//		[baseContainer addChild:maleMandarinDuckView z:4];
		
		UILayer *uiLayer = [UILayer node];
		[self addChild:uiLayer];
		
		
		ScaleControlLayer *scaler = [[ScaleControlLayer alloc] initWithTarget:scaleContainer];
		[self addChild:scaler];
	}
	return self;
}

-(void) swithZoo:(BOOL)isFriend
{
	
	if (isFriend) {
		[baseContainer removeAllChildrenWithCleanup:YES]; 
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
		
		for (CCSprite *tempSprite in friendSceneArray) {
			[baseContainer addChild:tempSprite z:2];
		}
		for (AnimalView *animalView in friendAnimalArray) {
			[baseContainer addChild:animalView z:4];
		}
		
	}
	else {
		[baseContainer removeAllChildrenWithCleanup:YES]; 
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
		for (CCSprite *tempSprite in mySceneArray) {
			[baseContainer addChild:tempSprite z:2];
		}
		for (AnimalView *animalView in myAnimalArray) {
			[baseContainer addChild:animalView z:4];
		}
	}
	
}

-(void) dealloc
{
	[super dealloc];
}

@end
