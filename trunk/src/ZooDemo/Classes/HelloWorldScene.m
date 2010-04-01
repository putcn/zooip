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
		background.scale = 0.5f;
		background.position = ccp(240,160);
		
		tree = [CCSprite spriteWithFile:@"tree.png"];
		tree.position = ccp(800,450);
		[background addChild:tree];
		
		house = [CCSprite spriteWithFile:@"house.png"];
		house.position = ccp(470,480);
		[background addChild:house];
		
		waterbox = [CCSprite spriteWithFile:@"waterbox.png"];
		waterbox.position = ccp(360,480);
		[background addChild:waterbox];
		
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
