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
#import "ModelLocator.h"
#import "FriendInitWorkFlowController.h"
#import "EggController.h"
#import "ItemController.h"
#import "DejectaController.h"
#import "AntController.h"
#import "SnakeController.h"
#import "Background.h"

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
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		//set the backgroud and the size set 50%
		baseContainer = [CCSprite node];
		baseContainer.position = ccp(-size.width / 2, -size.height / 2);
		baseContainer.scale = 0.5f;
		
		background = [[Background alloc] init];
		background.scale = 0.95f;
		background.position = ccp(480,320);
		
		[baseContainer addChild: background z:0];
		
		CCSprite *tree = [CCSprite spriteWithFile:@"tree.png"];
		tree.position = ccp(805,436);
		
		[background addChild:tree z:10];
		
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
		
		// Add by Hunk on 2010-06-30
		[scaler release];
		
		DragControlLayer *drager = [[DragControlLayer alloc] initWithTarget:scaleContainer];
		[self addChild:drager];
		
		// Add by Hunk on 2010-06-30
		[drager release];
		
//		PigeonView *pigeonView = [[PigeonView alloc] init];
//		pigeonView.position = ccp(200,200);
//		[[Animal alloc] initWithView:pigeonView setSpeed:0.5f setLimitRect:CGRectMake(100, 100, 500, 500)];
//		[baseContainer addChild:pigeonView z:4];
		
		loadView = [[LoadView alloc] init];
		[loadView MyLoadingView];
		[self addChild:loadView z:14];
		[loadView SetLabelString:@"Loading"];
		PlayerInitWorkFlowController *playerInitFlowController = [[PlayerInitWorkFlowController alloc] init];
		[playerInitFlowController setupStep];
		[playerInitFlowController startStep];
		// Add by Hunk on 2010-06-30
		//[playerInitFlowController release];
		
		uiLayer = [[UILayer alloc] init];
		[self addChild:uiLayer z:10];
		[uiLayer switchPlayerZoo];
		
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

-(void) updateUserInfo
{
	[uiLayer updateUserInfo];
}

-(void) switchZoo:(NSString *)playerUid
{
	[self clearAll];
	
	BOOL isSelfZoo = NO;
	
	if ([playerUid isEqual:[DataEnvironment sharedDataEnvironment].playerUid] || playerUid == nil)
	{
		isSelfZoo = YES;
	}
	else
	{
		isSelfZoo = NO;
	}
	
	if (isSelfZoo)
	{
		[[ModelLocator sharedModelLocator] setIsSelfZoo:YES];
		PlayerInitWorkFlowController *playerInitFlowController = [[PlayerInitWorkFlowController alloc] init];
		[playerInitFlowController setupStep];
		[playerInitFlowController startStep];
		
		// Add by Hunk on 2010-06-30
		//[playerInitFlowController release];
		
		
		[uiLayer switchPlayerZoo];
	}
	else
	{
		[DataEnvironment sharedDataEnvironment].friendUid = playerUid;
		
		[[ModelLocator sharedModelLocator] setIsSelfZoo:NO];
		FriendInitWorkFlowController *friendInitFlowController = [[FriendInitWorkFlowController alloc] init];
		[friendInitFlowController setupStep];
		[friendInitFlowController startStep];
		
		[uiLayer switchFriendZoo];
	}
}

-(void) loading:(NSString *)info
{
	[loadView SetLabelString:info];
}

-(void) finishLoading
{
	[self removeChild:loadView cleanup:YES];
}

-(void) clearAll
{
	[[EggController sharedEggController] clearEgg];
	[[DataEnvironment sharedDataEnvironment].eggs removeAllObjects];
	[[AnimalController sharedAnimalController] clearAnimal];
	[[DataEnvironment sharedDataEnvironment].animals removeAllObjects];
	[[DataEnvironment sharedDataEnvironment].animalIDs removeAllObjects];
	[[ItemController sharedItemController] clearItems];
	[[DataEnvironment sharedDataEnvironment].dogs removeAllObjects];
	[[DejectaController sharedDejectaController] clearDejectas];
	[[DataEnvironment sharedDataEnvironment].dejectas removeAllObjects];
	[[AntController sharedAntController] clearAnts];
	[[DataEnvironment sharedDataEnvironment].ants removeAllObjects];
	[[SnakeController sharedSnakeController] clearSnakes];
	[[DataEnvironment sharedDataEnvironment].snakes removeAllObjects];
}

-(void) dealloc
{
//	[baseContainer release];
//	[background release];
	[uiLayer release];
//	[super removeAllChildrenWithCleanup:YES];// Modify by Hunk on 2010-07-07
	[super dealloc];
}

@end
