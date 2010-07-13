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
	CCAnimation *animation = [CCAnimation animationWithName:@"animal" delay:0.1f];
	CCSpriteSheet *image = [CCSpriteSheet spriteSheetWithFile:fileName];

	NSInteger containOneLine = max;
	for (int i = 0; i < number; i++) {
		CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:image.texture rect:CGRectMake(originx + (i % containOneLine) * w, originy + (i/containOneLine) * h, w, h) offset:ccp(0,0)];
		[animation addFrame:frame];
	}
	return animation;
}

-(CCSprite *)getSprite:(NSString *)fileName setOriginX:(float)originx setOriginY:(float)originy setWidth:(float)w setHeight:(float)h setNumber:(NSInteger)number
{
	CCSpriteSheet *image = [CCSpriteSheet spriteSheetWithFile:fileName];
	CCSprite *tempSprite = [CCSprite spriteWithTexture:image.texture rect:CGRectMake(originx, originy, w, h)];
	return tempSprite;
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	
	
	[super dealloc];
}


@end
