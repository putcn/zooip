//
//  RandomHelper.m
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "RandomHelper.h"


@implementation RandomHelper

+(int) getRandomNum:(int) low to:(int) high
{
	int result = low + (arc4random() % (high - low + 1));
	//NSLog(@"random result = %d", result);
	return result;
}

- (void) dealloc
{
	[super dealloc];
}

@end
