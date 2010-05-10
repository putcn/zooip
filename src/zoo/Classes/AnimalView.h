//
//  AnimalView.h
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "AnimalToolTip.h"



@interface AnimalView : CCSprite <CCTargetedTouchDelegate>
{	
	NSMutableDictionary *animationTable;
	NSDictionary *dirctions;
	NSDictionary *statuses;
	CCSprite *toolTip;
	NSString *animalId;
}

@property (nonatomic, retain) NSString *animalId;

-(void) update:(int)currDirectionValue status:(int)currStatusValue;
@end



