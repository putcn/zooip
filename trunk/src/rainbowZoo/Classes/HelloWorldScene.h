
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCIntervalAction.h"

// HelloWorld Layer
@interface HelloWorld : CCLayer
{
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end

@interface MoveToRandomPoint: CCIntervalAction <NSCopying>
{
	CGPoint endPostion;
	CGPoint startPostion;
	CGPoint delta;
	CGRect box;
}

//create the action
+(id)actionWithDuration: (ccTime)duration inBox:(CGRect)aBox;

//initalize the action
-(id)initWithDuration:(ccTime)duration inBox:(CGRect)aBox;
-(CGPoint)eightDirection;
-(float) right: (CGPoint)origin recSize:(CGSize)size;
-(float) rightUp: (CGPoint)origin recSize:(CGSize)size;
-(float) up: (CGPoint)origin recSize:(CGSize)size;
-(float) leftUp: (CGPoint)origin recSize:(CGSize)size;
-(float) left: (CGPoint)origin recSize:(CGSize)size;
-(float) leftDown: (CGPoint)origin recSize:(CGSize)size;
-(float) down: (CGPoint)origin recSize:(CGSize)size;
-(float) rightDown: (CGPoint)origin recSize:(CGSize)size;
@end
