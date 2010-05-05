//
//  AnimalView.h
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "AnimalToolTip.h"
#import "DataModelAnimal.h"

@interface AnimalView : CCSprite <CCTargetedTouchDelegate>
{
	NSMutableDictionary *animationTable;
	CCSprite *toolTip;
	DataModelAnimal *data;
}

@property (nonatomic, copy) DataModelAnimal *data;

-(void) update:(int)currDirectionValue status:(int)currStatusValue;
@end



