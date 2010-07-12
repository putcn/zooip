//
//  FarmAnimalView.h
//  zoo
//
//  Created by Rainbow on 7/5/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"


@interface FarmAnimalView : CCSprite <CCTargetedTouchDelegate> {
	NSMutableDictionary *animationTable;
	NSDictionary *dirctions;
	NSDictionary *statuses;
}
-(void) update:(int)currDirectionValue status:(int)currStatusValue;
@end
