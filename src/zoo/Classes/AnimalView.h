//
//  AnimalView.h
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"


@interface AnimalView : CCSprite
{
	NSMutableDictionary *animationTable;
}

-(void) update:(int)currDirectionValue status:(int)currStatusValue;

@end



