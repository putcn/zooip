//
//  TouchabelSprite.h
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-6.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Touchable.h"

// 变大来表示响应
@interface TouchableSprite : CCSprite <Touchable>{
	BOOL big;
}

-(void) fireTouchBegan;
-(void) fireTouchMovedIn;
-(void) fireTouchMovedOut;
-(void) fireTouchEnded;

@end
