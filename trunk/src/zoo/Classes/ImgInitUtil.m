//
//  ImgInitUtil.m
//  zoo
//
//  Created by Rainbow on 6/14/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ImgInitUtil.h"


@implementation ImgInitUtil

static ImgInitUtil *_sharedImgInitUtil;

+(ImgInitUtil *)sharedImgInitUtil{
	@synchronized([ImgInitUtil class])
	{
		if(!_sharedImgInitUtil)
		{
			_sharedImgInitUtil = [[ImgInitUtil alloc] init];
		}
		return _sharedImgInitUtil;
	}
	return nil;
}
-(CCAnimation *)getAnimate:(NSString *)fileName setOriginX:(float)originx setOriginY:(float)originy setWidth:(float)w setHeight:(float)h setNumber:(NSInteger)number setMaxOneline:(NSInteger)max
{
	CCAnimation *animation = [CCAnimation alloc];
	animation = [CCAnimation animationWithName:@"animal" delay:0.1f];
	CCTexture2D *image = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:fileName ofType:nil]]];
	NSInteger containOneLine = max;
	for (int i = 0; i < number; i++) {
		[animation addFrameWithTexture:image rect:CGRectMake(originx + (i % containOneLine) * w, originy + (i/containOneLine) * h, w, h)];
		NSLog(@"second x.....%f, y.....%f",originx + (i % containOneLine) * w, originy + (i/containOneLine) * h);
	}
	[image release];
	return animation;
}

-(NSDictionary *)getSprite:(NSString *)fileName setOriginX:(float)originx setOriginY:(float)originy setWidth:(float)w setHeight:(float)h setNumber:(NSInteger)number
{
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	CCTexture2D *image = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:fileName ofType:nil]]];
	if (number == 5) {
		[dictionary setObject:[CCSprite spriteWithTexture:image rect:CGRectMake(0, originy, w, h)] forKey:@"down"];
		[dictionary setObject:[CCSprite spriteWithTexture:image rect:CGRectMake(w, originy, w, h)] forKey:@"left"];
		[dictionary setObject:[CCSprite spriteWithTexture:image rect:CGRectMake(2*w, originy, w, h)] forKey:@"leftDown"];
		[dictionary setObject:[CCSprite spriteWithTexture:image rect:CGRectMake(3*w, originy, w, h)] forKey:@"leftUp"];
		[dictionary setObject:[CCSprite spriteWithTexture:image rect:CGRectMake(4*w, originy, w, h)] forKey:@"up"];
	}
	else if(number == 2)
	{
		[dictionary setObject:[CCSprite spriteWithTexture:image rect:CGRectMake(0, originy, w, h)] forKey:@"down"];
		[dictionary setObject:[CCSprite spriteWithTexture:image rect:CGRectMake(w, originy, w, h)] forKey:@"left"];
	}
	else if(number == 1)
	{
		[dictionary setObject:[CCSprite spriteWithTexture:image rect:CGRectMake(0, originy, w, h)] forKey:@"left"];
	}
	[image release];
	return [NSDictionary dictionaryWithDictionary:dictionary];
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	
	
	[super dealloc];
}


@end
