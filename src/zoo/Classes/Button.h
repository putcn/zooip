//
//  Button.h
//  Common
//
//  Created by Niu Darcy on 2/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"


@interface Button : CCSprite <CCTargetedTouchDelegate>
{
	NSString *label;
	CCLabel *text;
	
	id targetCallBack;
	SEL selector;
	
	int pri;
	
	float defaultScale;
}

-(id) initWithLabel:(NSString*) labelText setColor:(ccColor3B) labelColor setFont:(NSString*) labelFont 
		setSize:(int) labelSize setBackground:(NSString*) imagePath setTarget:(id) target setSelector:(SEL) handler
		setPriority:(int) priorityValue offsetX:(int) offsetXValue offsetY:(int) offsetYValue scale:(float) scaleValue;

-(void) setLabel:(NSString*) labelValue;

@property (retain, nonatomic) NSString *label;

@end
