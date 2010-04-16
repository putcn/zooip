//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "ServiceHelper.h"

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
		
		// create and initialize a Label
		CCLabel* label = [CCLabel labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
	}
	
	
	
	//[[serviceHelper sharedService] connectivityTestWithScope:self AndSuccessSel:@"requestDoneWith:" AndFailedSel:@"requestFailedWithReason:"];
	//[[serviceHelper sharedService] getFarmInfoWithFarmerId:NULL AndIsbodyGarded:NO AndScope:self AndSuccessSel:@"requestDoneWith:" AndFailedSel:@"requestFailedWithReason:"];
	//[[ServiceHelper sharedService] getFarmerInfo];
	//[[ServiceHelper sharedService] getFarmInfoWithFarmerId:@"A6215BF61A3AF50A8F72F043A1A6A85C" AndIsGuarded:NO];
	[[ServiceHelper sharedService] getAllBirdFarmAnimalInfoWithFarmId:@"163D7A78682082B36872659C7A9DA8F9" AndFarmerId:@"A6215BF61A3AF50A8F72F043A1A6A85C"];
	
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
