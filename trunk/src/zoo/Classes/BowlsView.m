//
//  BowlsView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "BowlsView.h"

@implementation BowlsView

-(id) initWithFoodEndTime: (NSDate *) foodEndTime
{
	if ((self = [super init])) {
		if (foodEndTime) {
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_0.png" ofType:nil]]];
		}
		else if(foodEndTime) {
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_1.png" ofType:nil]]];
		}
		else if(foodEndTime) {
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_2.png" ofType:nil]]];
		}
		else if(foodEndTime) {
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_3.png" ofType:nil]]];
		}
	}
	CGRect rect = CGRectZero;
	rect.size = bowls.contentSize;
	[self setTexture: bowls];
	[self setTextureRect: rect];
	return self;
}

-(void) update:(NSDate *) foodEndTime
{
	if (foodEndTime) {
		bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_0.png" ofType:nil]]];
	}
	else if(foodEndTime) {
		bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_1.png" ofType:nil]]];
	}
	else if(foodEndTime) {
		bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_2.png" ofType:nil]]];
	}
	else if(foodEndTime) {
		bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_3.png" ofType:nil]]];
	}
	rect.size = bowls.contentSize;
	[self setTexture: bowls];
	[self setTextureRect: rect];
}

-(void) dealloc
{
	[super dealloc];
}
@end
