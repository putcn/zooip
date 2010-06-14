//
//  ImgInitUtil.m
//  zoo
//
//  Created by Rainbow on 6/14/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ImgInitUtil.h"


@implementation ImgInitUtil
@synthesize animation;
-(id)initWithImage:(NSString *)fileName width:(NSInteger)w height:(NSInteger)h index:(NSInteger)index number:(NSInteger)number
{
	if ((self = [super init])) {
		animation = [CCAnimation animationWithName:@"animal" delay:0.04f];
		CCTexture2D *image = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:fileName ofType:nil]]];
		NSInteger itemsOneLine = image.contentSize.width / w;
		for (int i = index; i<= index + number; i++) {
			NSInteger startX = (index - 1) % itemsOneLine;
			NSInteger startY = index / itemsOneLine;
			[animation addFrameWithTexture:image rect:CGRectMake(startX, startY, w, h)];
		}
	}
	return self;
}

@end
