//
//  DuckView.m
//  ZooDemo
//
//  Created by Rainbow on 4/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DuckView.h"


@implementation DuckView

-(id) initWithPrefix:(NSString *)prefix
{		
	if ((self = [super initWithPrefix:prefix])) {
	}
	return self;
}


-(void) update:(int)currDirectionValue status:(int)currStatusValue
{
	CCTexture2D *bg;
	CGRect rect;
	
	switch (currDirectionValue) {
		case 0:
			self.flipX = NO;
			bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_up.0.png" ofType:nil] ] ];
			rect = CGRectZero;
			rect.size = bg.contentSize;
			[self setTexture: bg];
			[self setTextureRect: rect];
			break;
		case 1:
			self.flipX = YES;
			bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_left_up.0.png" ofType:nil] ] ];
			rect = CGRectZero;
			rect.size = bg.contentSize;
			[self setTexture: bg];
			[self setTextureRect: rect];
			break;
		case 2:
			self.flipX = YES;
			bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_left.png" ofType:nil] ] ];
			rect = CGRectZero;
			rect.size = bg.contentSize;
			[self setTexture: bg];
			[self setTextureRect: rect];
			break;
		case 3:
			self.flipX = YES;
			bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_left_down.0.png" ofType:nil] ] ];
			rect = CGRectZero;
			rect.size = bg.contentSize;
			[self setTexture: bg];
			[self setTextureRect: rect];
			break;
		case 4:
			self.flipX = NO;
			bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_down.0.png" ofType:nil] ] ];
			rect = CGRectZero;
			rect.size = bg.contentSize;
			[self setTexture: bg];
			[self setTextureRect: rect];
			break;
		case 5:
			self.flipX = NO;
			bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_left_down.0.png" ofType:nil] ] ];
			rect = CGRectZero;
			rect.size = bg.contentSize;
			[self setTexture: bg];
			[self setTextureRect: rect];
			break;
		case 6:
			self.flipX = NO;
			bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_left.png" ofType:nil] ] ];
			rect = CGRectZero;
			rect.size = bg.contentSize;
			[self setTexture: bg];
			[self setTextureRect: rect];
			break;
		case 7:
			self.flipX = NO;
			bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duck_swimming_left_up.0.png" ofType:nil] ] ];
			rect = CGRectZero;
			rect.size = bg.contentSize;
			[self setTexture: bg];
			[self setTextureRect: rect];
			break; 
		default:
			break;
			
	}
}

-(void) dealloc
{
	//[animationTable release];
	[super dealloc];
}

@end
