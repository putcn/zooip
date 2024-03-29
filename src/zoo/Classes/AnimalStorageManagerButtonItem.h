//
//  AnimalStorageManagerButtonItem.h
//  zoo
//
//  Created by Alex Liu on 10-6-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface AnimalStorageManagerButtonItem : CCSprite <CCTargetedTouchDelegate>
{
	id targetCallBack;
	SEL selector;
	int pri;
	NSString *itemId;
	NSString *itemType;
	NSString *storageID;
	NSInteger amount;
	CCSprite *genDer;
}

@property (nonatomic, retain)NSString *itemId;
@property (nonatomic, retain)NSString *itemType;
@property (nonatomic, retain)NSString *storageID;

//-(id) initWithItems:(NSString *)itId setitType:(NSString *)itType setAmount:(NSInteger) Amount setGender:(NSString *)gender setAnimalID:(NSString *)animalIDP setImagePath:(NSString*) imagePath setAnimalName:(NSString *) animalName setTarget:(id) target setSelector:(SEL) handler
//		setPriority:(int) priorityValue offsetX:(int) offsetXValue offsetY:(int) offsetYValue;
-(id) initWithItems:(NSString *)itId setitType:(NSString *)itType setAmount:(NSInteger) Amount setGender:(CCSprite *)gender setAnimalID:(NSString *)animalIDP setImagePath:(NSString*) imagePath setAnimalName:(NSString *) animalName setTarget:(id) target setSelector:(SEL) handler
		setPriority:(int) priorityValue offsetX:(int) offsetXValue offsetY:(int) offsetYValue;
-(void) setImg: (NSString *) itemImg setName:(NSString *) animalName;
@end