//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "ServiceHelper.h"
#import "PigeonView.h"
#import "Animal.h"
#import "UILayer.h"

// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *scaleContainer = [CCSprite node];
		[scaleContainer setContentSize:CGSizeMake(486.4f, 364.8f)];
		[scaleContainer setAnchorPoint:ccp(0, 0)];
		scaleContainer.position = ccp( size.width / 2, size.height / 2);
		[self addChild:scaleContainer];
		
		baseContainer = [CCSprite node];
		baseContainer.position = ccp(-size.width / 2, -size.height / 2);
		baseContainer.scale = 0.5f;
		
		CCSprite *background = [CCSprite spriteWithFile:@"bgimg.jpg"];
		background.scale = 0.95f;
		background.position = ccp(480,320);
		
		[baseContainer addChild: background z:0];
		
		CCSprite *tree = [CCSprite spriteWithFile:@"tree.png"];
		tree.position = ccp(750,400);
		
		[baseContainer addChild:tree z:1];
		
		CCSprite *house = [CCSprite spriteWithFile:@"house.png"];
		house.position = ccp(450,410);
		
		[baseContainer addChild:house z:1];
		
		CCSprite *waterbox = [CCSprite spriteWithFile:@"waterbox.png"];
		waterbox.position = ccp(330,420);
		
		[baseContainer addChild:waterbox z:1];
		
		// add the label as a child to this Layer
		[scaleContainer addChild: baseContainer];
		
		UILayer *uiLayer = [UILayer node];
		[self addChild:uiLayer];
	}
	
	//[[serviceHelper sharedService] connectivityTestWithScope:self AndSuccessSel:@"requestDoneWith:" AndFailedSel:@"requestFailedWithReason:"];
	//[[serviceHelper sharedService] getFarmInfoWithFarmerId:NULL AndIsbodyGarded:NO AndScope:self AndSuccessSel:@"requestDoneWith:" AndFailedSel:@"requestFailedWithReason:"];
	//[[ServiceHelper sharedService] getFarmerInfo];
	//[[ServiceHelper sharedService] getFarmInfoWithFarmerId:@"A6215BF61A3AF50A8F72F043A1A6A85C" AndIsGuarded:NO];
	[[ServiceHelper sharedService] getAllBirdFarmAnimalInfoWithFarmId:@"163D7A78682082B36872659C7A9DA8F9" AndFarmerId:@"A6215BF61A3AF50A8F72F043A1A6A85C"];
	PigeonView *pigeonView = [[PigeonView alloc] init];
	pigeonView.position = ccp(200,200);
	[[Animal alloc] initWithView:pigeonView setSpeed:0.5f setLimitRect:CGRectMake(100, 100, 500, 500)];
	[baseContainer addChild:pigeonView];
	
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
