//
//  AntView.h
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Cocos2d.h"


@interface AntView : CCSprite {
	NSDictionary *dirctions;
	CCAnimation *animation;	
}

-(void) update:(int)currDirectionValue status:(int)currStatusValue;


@end
