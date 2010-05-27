//
//  ItemButton.h
//  zoo
//
//  Created by Rainbow on 5/25/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ItemButton : CCSprite <CCTargetedTouchDelegate>
{
	id targetCallBack;
	SEL selector;
	int pri;
	NSString *itemId;
	NSString *itemType;
}

@property (nonatomic, retain)NSString *itemId;
@property (nonatomic, retain)NSString *itemType;

-(id) initWithItem:(NSString *)itId setitType:(NSString *)itType setImagePath:(NSString*) imagePath setBuyType:(int) buyType setPrice:(NSString *) price setTarget:(id) target setSelector:(SEL) handler
		setPriority:(int) priorityValue offsetX:(int) offsetXValue offsetY:(int) offsetYValue;

-(void) setImg: (NSString *) imagePath setBuyType: (int) buyType setPrice:(NSString *) price;
@end
