//
//  ImageResources.h
//  zoo
//
//  Created by Rainbow on 7/14/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ImageResources : NSObject {
	CCSpriteSheet *babyCraneImg;
	CCSpriteSheet *babyDuckImg;
	CCSpriteSheet *babyHenImg;
	CCSpriteSheet *babyMagpieImg;
	CCSpriteSheet *babyMallardImg;
	CCSpriteSheet *babyPeacockImg;
	CCSpriteSheet *babyPiegonImg;
	CCSpriteSheet *babySwanImg;
	CCSpriteSheet *babyWildgooseImg;
	CCSpriteSheet *mallardImg_1;
	CCSpriteSheet *mallardImg_2;
	CCSpriteSheet *wildgooseImg_1;
	CCSpriteSheet *wildgooseImg_2;
	CCSpriteSheet *wildgooseImg_3;
	CCSpriteSheet *chinemyImg;
	CCSpriteSheet *craneImg_1;
	CCSpriteSheet *craneImg_2;
	CCSpriteSheet *craneImg_3;
	CCSpriteSheet *dogImg;
	CCSpriteSheet *duckImg;
	CCSpriteSheet *gooseImg;
	CCSpriteSheet *henImg;
	CCSpriteSheet *magpieImg_1;
	CCSpriteSheet *magpieImg_2;
	CCSpriteSheet *maleMandarinDuckImg;
	CCSpriteSheet *malePheasantImg;
	CCSpriteSheet *mandarinDuckImg;
	CCSpriteSheet *parrotImg_1;
	CCSpriteSheet *parrotImg_2;
	CCSpriteSheet *peacockImg;
	CCSpriteSheet *peahenImg;
	CCSpriteSheet *pheasantImg;
	CCSpriteSheet *pigeonImg;
	CCSpriteSheet *roosterImg;
	CCSpriteSheet *snakeImg;
	CCSpriteSheet *swanImg_1;
	CCSpriteSheet *swanImg_2;
	CCSpriteSheet *turkeyImg;
	CCSpriteSheet *turkeycockImg;
}
+ (ImageResources *)sharedImageResources;
- (void)restore;
- (CCSpriteSheet *)getImageResouce:(NSString *)imagePath;

@end
