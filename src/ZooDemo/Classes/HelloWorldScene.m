//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "HelloWorldScene.h"

CCSprite *background;
CCSprite *tree;
CCSprite *house;
CCSprite *waterbox;
CCSprite *egg1;
CCSprite *egg2;
CCSprite *egg3;
CCSprite *egg4;
CCSprite *egg5;
CCSprite *egg6;
CCSprite *egg7;
CCSprite *egg8;
CCSprite *egg9;
CCSprite *egg10;
CCSprite *pan;
CCSprite *snake1;
CCSprite *snake2;

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
		background = [CCSprite spriteWithFile:@"bgimg.jpg"];
		background.scale = 0.47f;
		background.position = ccp(240,160);
		
		tree = [CCSprite spriteWithFile:@"tree.png"];
		tree.position = ccp(810,440);
		[background addChild:tree];
		
		house = [CCSprite spriteWithFile:@"house.png"];
		house.position = ccp(480,480);
		[background addChild:house];
		
		waterbox = [CCSprite spriteWithFile:@"waterbox.png"];
		waterbox.position = ccp(350,480);
		[background addChild:waterbox];
		
		egg1 = [CCSprite spriteWithFile:@"丹顶鹤蛋.png"];
		egg1.position = ccp(600,100);
		[background addChild:egg1 z:1];
		
		egg2 = [CCSprite spriteWithFile:@"喜鹊蛋.png"];
		egg2.position = ccp(710,180);
		[background addChild:egg2 z:1];
		
		egg3 = [CCSprite spriteWithFile:@"大雁蛋.png"];
		egg3.position = ccp(820,146);
		[background addChild:egg3 z:1];
		
		egg4 = [CCSprite spriteWithFile:@"天鹅蛋.png"];
		egg4.position = ccp(630,190);
		[background addChild:egg4 z:1];
		
		egg5 = [CCSprite spriteWithFile:@"孔雀蛋.png"];
		egg5.position = ccp(580,134);
		[background addChild:egg5 z:1];
		
		egg6 = [CCSprite spriteWithFile:@"火鸡蛋.png"];
		egg6.position = ccp(750,167);
		[background addChild:egg6 z:1];
		
		egg7 = [CCSprite spriteWithFile:@"野鸡蛋.png"];
		egg7.position = ccp(660,123);
		[background addChild:egg7 z:1];
		
		egg8 = [CCSprite spriteWithFile:@"野鸭蛋.png"];
		egg8.position = ccp(570,104);
		[background addChild:egg8 z:1];
		
		egg9 = [CCSprite spriteWithFile:@"鸡蛋.png"];
		egg9.position = ccp(780,200);
		[background addChild:egg9 z:1];
		
		egg10 = [CCSprite spriteWithFile:@"鸳鸯蛋.png"];
		egg10.position = ccp(790,178);
		[background addChild:egg10 z:1];
		
		pan = [CCSprite spriteWithFile:@"喂食3.png"];
		pan.position = ccp(300,150);
		[background addChild:pan z:1];
		
		snake1 = [CCSprite spriteWithFile:@"snake_sleep_2.png"];
		snake1.position = ccp(800,100);
		[background addChild:snake1 z:2];
		
		snake2 = [CCSprite spriteWithFile:@"snake_sleep_5.png"];
		snake2.position = ccp(600,200);
		[background addChild:snake2 z:2];
		
		
		[self addChild: background z:0];
		
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
