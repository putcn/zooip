//
//  DuckEggView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DuckEggView.h"


@implementation DuckEggView

-(id) init
{
	if((self = [super init]))
	{
		CCTexture2D *eggImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"duckEgg.png" ofType:nil]]];
		CGRect rect = CGRectZero;
		rect.size = eggImg.contentSize;
		[self setTexture: eggImg];
		[self setTextureRect: rect];
	}
	return self;
}

@end
