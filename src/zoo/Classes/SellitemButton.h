//
//  SellitemButton.h
//  zoo
//
//  Created by admin on R.O.C. 99/6/1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SellitemButton : CCSprite <CCTargetedTouchDelegate>
{
	id targetCallBack;
	SEL selector;
	int pri;
	NSString *itemId;
	NSString *itemType;
	CCSprite *item;
	CCTexture2D *itemImg;

	
}

@property (nonatomic, retain)NSString *itemId;
@property (nonatomic, retain)NSString *itemType;

-(id) initWithItem:(NSString *)itId setitType:(NSString *)itType setImagePath:(NSString*) imagePath setEggTotal:(NSString*) eggTotal setEggName:(NSString *) eggName setTarget:(id) target setSelector:(SEL) handler
	   setPriority:(int) priorityValue offsetX:(int) offsetXValue offsetY:(int) offsetYValue;

-(void) setImg: (NSString *) imagePath setEggTotal: (NSString*) eggTotal setEggName:(NSString *) eggName;
@end
