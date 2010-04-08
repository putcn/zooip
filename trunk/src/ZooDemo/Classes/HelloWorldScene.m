//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "ScaleControlLayer.h"
#import "DragControlLayer.h"


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
		
		
		ScaleControlLayer *scaler = [[ScaleControlLayer alloc] initWithTarget:baseContainer];
		[self addChild:scaler];
		
		DragControlLayer *Drager = [[DragControlLayer alloc] initWithTarget:baseContainer];
		[self addChild:Drager];
		
	}
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
