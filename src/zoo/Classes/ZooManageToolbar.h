//
//  ZooManageToolbar.h
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Button.h"

@interface ZooManageToolbar : CCSprite
{
	NSMutableArray *playerStatusIconTextures;
	NSMutableArray *friendStatusIconTextures;
	CCSprite *playerButtonContainer;
	CCSprite *friendButtonContainer;
	CCSprite *statusIcon;
	int selectIndex;
}

-(void) addButton;
-(void) addStatusIconTexture;

-(void) switchZoo:(Boolean) isSelf;

@end
