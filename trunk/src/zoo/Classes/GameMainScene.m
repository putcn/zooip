//
//  GameMainScene.m
//  zoo
//
//  Created by Niu Darcy on 3/24/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "GameMainScene.h"
#import "ServiceHelper.h"
#import "PigeonView.h"
#import "Animal.h"
#import "CollisionHelper.h"
#import "AnimalController.h"


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
		[CollisionHelper initCollisionMap];
		
		isSelfZoo = YES;
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		//set the backgroud and the size set 50%
		baseContainer = [CCSprite node];
		baseContainer.position = ccp(-size.width / 2, -size.height / 2);
		baseContainer.scale = 0.5f;
		
		background = [CCSprite spriteWithFile:@"bgimg.jpg"];
		background.scale = 0.95f;
		background.position = ccp(480,320);
		
		[baseContainer addChild: background z:0];
		
		CCSprite *tree = [CCSprite spriteWithFile:@"tree.png"];
		tree.position = ccp(805,436);
		
		[background addChild:tree z:1];
		
		CCSprite *house = [CCSprite spriteWithFile:@"house.png"];
		house.position = ccp(485,475);
		
		[background addChild:house z:1];
		
		CCSprite *waterbox = [CCSprite spriteWithFile:@"waterbox.png"];
		waterbox.position = ccp(360,486);
		
		[background addChild:waterbox z:1];
		
		CCSprite *scaleContainer = [CCSprite node];
		[scaleContainer setContentSize:CGSizeMake(486.4f, 364.8f)];
		[scaleContainer setAnchorPoint:ccp(0, 0)];
		scaleContainer.position = ccp( size.width / 2, size.height / 2);
		[scaleContainer addChild:baseContainer];
		[self addChild:scaleContainer];
		ScaleControlLayer *scaler = [[ScaleControlLayer alloc] initWithTarget:scaleContainer];
		[self addChild:scaler];
		DragControlLayer *drager = [[DragControlLayer alloc] initWithTarget:scaleContainer];
		[self addChild:drager];
		
//		PigeonView *pigeonView = [[PigeonView alloc] init];
//		pigeonView.position = ccp(200,200);
//		[[Animal alloc] initWithView:pigeonView setSpeed:0.5f setLimitRect:CGRectMake(100, 100, 500, 500)];
//		[baseContainer addChild:pigeonView z:4];
		
		InitWorkFlowController *initFlowController = [[InitWorkFlowController alloc] init];
		[initFlowController setupStep];
		[initFlowController startStep];
		
//		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"2318393DAD70AF92F9D488C5CE85B8D9",@"farmId",@"EA4416A19E664C3D6246DF8E8D4EDC84",@"adultBirdStorageId",nil];
//		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestaddAnimalToFarm WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"requestFaildWithReason:"];
	
//		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"088A81B9307D26AAD5D1924394C2A2E9",@"farmerId",nil];
//		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"requestDoneWith:" AndFailedSel:@"requestFaildWithReason:"];

//		NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:@"12",@"farmerId",@"1",@"goodsId",nil];
//		NSDictionary *param1 =  [NSDictionary dictionaryWithObjectsAndKeys:@"12",@"farmerId",nil];
//		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllGoods WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
//		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyTurtleByAnts WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
//		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmerDog WithParameters:param1 AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		
		return self;
	}
	
	return nil;
}

-(void) resultCallback:(NSObject *)value{
}

-(Boolean) getIsSelfZoo
{
	return isSelfZoo;
}

-(void) addSpriteToStage:(CCSprite *) sprite z:(int) zIndex
{
	[background addChild:sprite z:zIndex];
}

-(void) removeSpriteFromStage:(CCSprite *) sprite
{
	[background removeChild:sprite cleanup:YES];
}

-(void) addDialogToScreen:(CCSprite *)sprite z:(int) zIndex
{
	[self addChild:sprite z:zIndex];
}

-(void) removeDialogFromScreen:(CCSprite *)sprite
{
	[self removeChild:sprite cleanup:YES];
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:51 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	int type = [[UIController sharedUIController] getOperation];
	if (type == OPERATION_CALL)
	{
		[[AnimalController sharedAnimalController] gotoEat];
		
		//CGPoint location = [background convertTouchToNodeSpaceAR:touch];
		CGPoint location = ccp(326,186);
		[[OperationViewController sharedOperationViewController] play:@"summon" setPosition:location];
	}
	
	return NO;
}

-(void) dealloc
{
	[super removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end
