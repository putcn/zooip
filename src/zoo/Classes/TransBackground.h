//
//  TransBackground.h
//  zoo
//
//  Created by Rainbow on 5/27/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TransBackground : CCSprite <CCTargetedTouchDelegate>
{
	NSInteger pri;
}

-(id)initWithPriority:(NSInteger) pripority;

@end
