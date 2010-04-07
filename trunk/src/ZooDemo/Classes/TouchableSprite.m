//
//  TouchabelSprite.m
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-6.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "TouchableSprite.h"


@implementation TouchableSprite

-(id) init
{
	if (self = [super init]) {
		big = NO;
	}
	return self;
}

-(void) fireTouchBegan
{
	if (!big) {
		self.scale = 1.2 * self.scale;
		big = YES;
	}
}

-(void) fireTouchMovedIn
{
	if (!big) {
		self.scale = 1.2 * self.scale;
		big = YES;
	}
}

-(void) fireTouchMovedOut
{
	if (big) {
		self.scale = self.scale / 1.2;
		big = NO;
	}
}

-(void) fireTouchEnded
{
	if (big) {
		self.scale = self.scale / 1.2;
		big = NO;
	}
}

@end
