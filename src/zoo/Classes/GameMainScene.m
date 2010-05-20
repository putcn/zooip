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
		
		background = [CCSprite spriteWithFile:@"bgimg.jpg"];
		background.scale = 0.95f;
		background.position = ccp(480,320);
		
		[baseContainer addChild: background z:0];
		
		CCSprite *tree = [CCSprite spriteWithFile:@"tree.png"];
		tree.position = ccp(800,445);
		
		[background addChild:tree z:1];
		
		CCSprite *house = [CCSprite spriteWithFile:@"house.png"];
		house.position = ccp(485,475);
		
		[background addChild:house z:1];
		
		CCSprite *waterbox = [CCSprite spriteWithFile:@"waterbox.png"];
		waterbox.position = ccp(345,480);
		
		[background addChild:waterbox z:1];
		
		CCSprite *scaleContainer = [CCSprite node];
		[scaleContainer setContentSize:CGSizeMake(486.4f, 364.8f)];
		[scaleContainer setAnchorPoint:ccp(0, 0)];
		scaleContainer.position = ccp( size.width / 2, size.height / 2);
		[scaleContainer addChild:baseContainer];
		[self addChild:scaleContainer];
		
		UILayer *uiLayer = [UILayer node];
		[self addChild:uiLayer];
		
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
		
//		NSDictionary *paras = [NSDictionary dictionaryWithObjectsAndKeys:@"12",@"farmerId",nil];
//		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmerInfo WithParameters:paras AndCallBackScope:self AndSuccessSel:@"requestDoneWith:" AndFailedSel:@"requestFaildWithReason:"];
//		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmerInfo WithParameters:paras AndCallBackScope:self AndSuccessSel:@"requestDoneWith:" AndFailedSel:@"requestFaildWithReason:"];
		
		return self;
	}
	
	return nil;
}

//-(void)requestDoneWith:(NSDictionary *)dic{
//	NSLog(@"%@",dic);
//}

-(void) addSpriteToStage:(CCSprite *) sprite z:(int) zIndex
{
	[background addChild:sprite z:zIndex];
}

-(void) removeSpriteFromStage:(CCSprite *) sprite
{
	[background removeChild:sprite cleanup:YES];
}

-(void) dealloc
{
	[super removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end
