//
//  ChinemyView.h
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"


@interface ChinemyView : CCSprite {
	NSMutableDictionary *animationTable;
	NSDictionary *dirctions;
}
-(void) update:(int)currDirectionValue status:(int)currStatusValue;

@end
