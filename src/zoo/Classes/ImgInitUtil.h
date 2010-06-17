//
//  ImgInitUtil.h
//  zoo
//
//  Created by Rainbow on 6/14/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ImgInitUtil : NSObject {
	
}
//fileName:大图片的名称, 如duck.png
//width:小图片的宽度
//height:小图片的高度
//index:开始获取图片的序号
//number:取图片的个数
//maxOneline:每行最多排列的图片数
-(CCAnimation *)getAnimate:(NSString *)fileName setOriginX:(float)originx setOriginY:(float)originy setWidth:(float)w setHeight:(float)h setNumber:(NSInteger)number setMaxOneline:(NSInteger)max;
-(NSDictionary *)getSprite:(NSString *)fileName setOriginX:(float)originx setOriginY:(float)originy setWidth:(float)w setHeight:(float)h setNumber:(NSInteger)number;
@end
