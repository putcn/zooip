//
//  AnimalManagementButtonItem.h
//  zoo
//
//  Created by Alex Liu on 6/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface AnimalManagementButtonItem : CCSprite <CCTargetedTouchDelegate>
{
	id targetCallBack;
	SEL selector;
	int pri;
	NSString *itemId;
	NSString *itemType;
	NSString *animalID;
}

@property (nonatomic, retain)NSString *itemId;
@property (nonatomic, retain)NSString *itemType;
@property (nonatomic, retain)NSString *animalID;

-(id) initWithItem:(NSString *)itId setitType:(NSString *)itType setAnimalID:(NSString *)animalIDP setImagePath:(NSString*) imagePath setAnimalName:(NSString *) animalName setTarget:(id) target setSelector:(SEL) handler
	   setPriority:(int) priorityValue offsetX:(int) offsetXValue offsetY:(int) offsetYValue setPictureScale:(float) fScale;

-(void) setImg: (NSString *) itemImg setName:(NSString *) animalName;
@end
