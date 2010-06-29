//
//  ScalerPane.h
//  zoo
//
//  Created by Rainbow on 5/31/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Button.h"

@interface ScalerPane : CCSprite {
	NSInteger max;
	NSInteger min;
	NSInteger delta;
	NSInteger count;
	NSInteger uPrice;
	NSInteger totalPrice;
	CCLabel *counterLbl;
	id targetCallBack;
}

@property (nonatomic,assign)NSInteger count;
@property (nonatomic,assign)NSInteger totalPrice;
-(id) initWithCounter:(NSInteger)countMin max:(NSInteger)countMax delta:(NSInteger)countdDelta target:(id)parentTarget price:(float)unitPrice z:(NSInteger) z Priority:(int) priorityValue setPathname:(NSString*) path setlength:(int )length;
@end
