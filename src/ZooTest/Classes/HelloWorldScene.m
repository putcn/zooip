//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "HelloWorldScene.h"

// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	Scene *scene = [Scene node];
	
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
		
		// create and initialize a Label
		//Label* label = [Label labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[Director sharedDirector] winSize];
	
		// position the label on the center of the screen
		//label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		//[self addChild: label];
		
		id moveA = [MoveBy actionWithDuration:1 position:ccp(-60,0)];
		
		Animation* animationMagpie = [Animation animationWithName:@"magpie" delay:0.05f];
		for( int i=1;i<22;i++)
			[animationMagpie addFrameWithFilename: [NSString stringWithFormat:@"magpie_l_%d.png", i]];
		id actionMagpie = [Animate actionWithAnimation: animationMagpie];
		
		Animation* animationRedCrowned = [Animation animationWithName:@"magpie" delay:0.05f];
		for( int i=1;i<22;i++)
			[animationRedCrowned addFrameWithFilename: [NSString stringWithFormat:@"redCrownedCrane_walk_left_%d.png", i]];
		id actionRedCrowned = [Animate actionWithAnimation: animationRedCrowned];
		
		for (int i = 0; i < 60; i++)
		{
			Sprite *magpie = [Sprite node];
			magpie.position = ccp( i % 10 * 60, i / 10 * 50 + 30 );
			[self addChild:magpie];
			id walkMagpie = [RepeatForever actionWithAction:
							 [Spawn actions:
							  [Sequence actions: [Place actionWithPosition:magpie.position], moveA, nil],
							  actionMagpie,
							  nil]];
			[magpie runAction:[walkMagpie copy]];
			
			Sprite *redCrowned = [Sprite node];
			redCrowned.position = ccp( i % 10 * 60, i / 10 * 50 + 30 );
			[self addChild:redCrowned];
			id walkRedCrowned = [RepeatForever actionWithAction:
							 [Spawn actions:
							  [Sequence actions: [Place actionWithPosition:redCrowned.position], moveA, nil],
							  actionRedCrowned,
							  nil]];
			[redCrowned runAction:[walkRedCrowned copy]];
		}
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
