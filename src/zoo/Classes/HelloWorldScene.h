
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "AnimalViewFactory.h"


// HelloWorld Layer
@interface HelloWorld : CCLayer
{
	CCSprite *baseContainer;
	CCSprite *background;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end
