//
//  NumberField.h
//  Jianghu
//
//  Created by Niu Darcy on 1/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"


@interface NumberField : CCSprite
{
	int count;
	CCLabel *lblText;
	
	id targetCallBack;
	
}
-(id) initWithCounter:(NSInteger)countMin target:(id)parentTarget z:(NSInteger) z Priority:(int) priorityValue;

-(void) setCount:(int) countValue;
-(void) addCount:(int) incrementValue;
-(int) getCount;

@end
