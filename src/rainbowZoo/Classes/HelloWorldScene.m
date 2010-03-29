//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "time.h"
#import "HelloWorldScene.h"

CCAnimation* animationMagpie;
CCSprite *magpie;
BOOL isFirst = YES;

@implementation MoveToRandomPoint
+ (id) actionWithDuration:(ccTime)t inBox:(CGRect)aBox
{
	return [[[self alloc] initWithDuration:t inBox:aBox] autorelease];
}

- (id) initWithDuration:(ccTime)t inBox:(CGRect)aBox
{
	if (!(self = [super initWithDuration:t])) 
		return nil;
		
	box = aBox;
	return self;
}

-(id) copyWithZone:(NSZone *)zone
{
	CCAction *copy = [[[self class] allocWithZone: zone] initWithDuration:[self duration] position:endPostion];
	return copy;
}

-(void) startWithTarget:(CCNode *)aTarget
{
	[super startWithTarget:aTarget];
	srandom(time(NULL));	
	if (isFirst) {
		startPostion = aTarget.position;
		endPostion = aTarget.position;
		isFirst = NO;
	}
	else{
		startPostion = endPostion;
		endPostion = [self eightDirection];
		
	}

	delta = ccpSub(endPostion, startPostion);
	
}

-(void) update: (ccTime) t
{
	[target setPosition:ccp((startPostion.x + delta.x * t ), (startPostion.y + delta.y * t))];
}

-(CGPoint)eightDirection
{
	srandom(time(NULL));
	CGSize size = box.size;
	CGPoint origin = box.origin;
	int direct = (int)random() % 8 + 1;
	NSLog(@"the direct is %d", direct);
	
	int distance;
	switch (direct) {
		case 1:
			distance = [self right:origin recSize:size];
			return ccp(endPostion.x + distance,endPostion.y);
			break;
		case 2:
			distance = [self rightUp:origin recSize:size];
			return ccp(endPostion.x + distance, endPostion.y + distance);
			break;
		case 3:
			distance = [self up:origin recSize:size];
			return ccp(endPostion.x, endPostion.y + distance);
			break;
		case 4:
			distance = [self leftUp:origin recSize:size];
			return ccp(endPostion.x - distance, endPostion.y + distance);
			break;
		case 5:
			distance = [self left:origin recSize:size];
			return ccp(endPostion.x - distance, endPostion.y);
			break;
		case 6:
			distance = [self leftDown:origin recSize:size];
			return ccp(endPostion.x - distance, endPostion.y - distance);
			break;
		case 7:
			distance = [self down:origin recSize:size];
			return ccp(endPostion.x, endPostion.y - distance);
			break;
		case 8:
			distance = [self rightDown:origin recSize:size];
			return ccp(endPostion.x + distance, endPostion.y - distance);
			break;
		default:
			return endPostion;
			break;
	}
	
}

-(float) right: (CGPoint)origin recSize:(CGSize)size
{
	srandom(time(NULL));
	if ((int)origin.x + (int)size.width == (int)endPostion.x) {
		return 0.0f;
	}
	return random() % ((int)origin.x + (int)size.width - (int)endPostion.x + 1) - 1;
}

-(float) rightUp: (CGPoint)origin recSize:(CGSize)size
{
	srandom(time(NULL));
	if ((int)origin.x + (int)size.width == (int)endPostion.x || (int)origin.y + (int)size.height == (int)endPostion.y) {
		return 0.0f;
	}
	if (((int)origin.x + (int)size.width - (int)endPostion.x) < ((int)origin.y + (int)size.height - (int)endPostion.y)) {
		return random() % ((int)origin.x + (int)size.width - (int)endPostion.x + 1) - 1;
	}
	else {
		return random() % ((int)origin.y + (int)size.height - (int)endPostion.y + 1) - 1;
	}
}

-(float) up: (CGPoint)origin recSize:(CGSize)size
{
	srandom(time(NULL));
	if ((int)origin.y + (int)size.height == (int)endPostion.y) {
		return 0.0f;
	}
	return random() % ((int)origin.y + (int)size.height - (int)endPostion.y + 1) - 1;
}

-(float) leftUp: (CGPoint)origin recSize:(CGSize)size
{
	srandom(time(NULL));
	if ((int)endPostion.x - (int)origin.x == (int)origin.y || (int)size.height == (int)endPostion.y) {
		return 0.0f;
	}
	if (((int)endPostion.x - (int)origin.x) < (int)origin.y + (int)size.height - (int)endPostion.y) {
		return random() % ((int)endPostion.x - (int)origin.x + 1) - 1;
	}
	else {
		return random() % ((int)origin.y + (int)size.height - (int)endPostion.y + 1) - 1;
	}
}

-(float) left: (CGPoint)origin recSize:(CGSize)size
{
	srandom(time(NULL));
	if ((int)endPostion.x == (int)origin.x) {
		return 0.0f;
	}
	return random() % ((int)endPostion.x - (int)origin.x + 1) - 1;
}

-(float) leftDown: (CGPoint)origin recSize:(CGSize)size
{
	srandom(time(NULL));
	if ((int)endPostion.x == (int)origin.x || (int)endPostion.y == (int)origin.y) {
		return 0.0f;
	}
	if (((int)endPostion.x - (int)origin.x) < ((int)endPostion.y - (int)origin.y)) {
		return random() % ((int)endPostion.x - (int)origin.x + 1) - 1;
	}
	else {
		return random() % ((int)endPostion.y - (int)origin.y + 1) - 1;
	}
}

-(float) down: (CGPoint)origin recSize:(CGSize)size
{
	srandom(time(NULL));
	if ((int)endPostion.y == (int)origin.y) {
		return 0.0f;
	}
	return random() % ((int)endPostion.y - (int)origin.y + 1) - 1;
}

-(float) rightDown: (CGPoint)origin recSize:(CGSize)size
{
	srandom(time(NULL));
	if ((int)origin.x + (int)size.width == (int)endPostion.x || (int)endPostion.y == (int)origin.y) {
		return 0.0f;
	}
	if (((int)origin.x + (int)size.width - (int)endPostion.x) <= ((int)endPostion.y - (int)origin.y)) {
		return random() % ((int)origin.x + (int)size.width - (int)endPostion.x + 1) - 1;
	}
	else{
		return random() % ((int)endPostion.y - (int)origin.y + 1) - 1;
	}
		
}

@end


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
		// CGSize size = [[CCDirector sharedDirector] winSize];
		animationMagpie = [CCAnimation animationWithName:@"magple" delay:0.1f];
		for (int i=1; i<22; i++) {
			[animationMagpie addFrameWithFilename: [NSString stringWithFormat:@"magpie_l_%d.png",i]];
		}
		id actionMagpie = [CCAnimate actionWithAnimation: animationMagpie];
		
		CGRect rect = CGRectMake(50, 50, 380, 260);
		id moveAction = [MoveToRandomPoint actionWithDuration:4 inBox:rect];  
		magpie = [CCSprite node];
		magpie.position = ccp(240, 180); 
		[self addChild:magpie];
		id walkMagpie = [CCRepeatForever actionWithAction:[CCSpawn actions:
														   [CCSequence actions:moveAction,nil],
														   [CCSequence actions:actionMagpie,actionMagpie,nil],nil]];
		[magpie runAction:walkMagpie];		
					

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



