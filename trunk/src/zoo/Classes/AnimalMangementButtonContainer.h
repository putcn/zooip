//
//  AnimalMangementButtonContainer.h
//  zoo
//
//  Created by Alex Liu on 6/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Button.h"
#import "UIController.h"
#import "AnimalManagerContainer.h"


@interface AnimalMangementButtonContainer : CCSprite {

	NSMutableArray *playerStatusIconTextures;

	NSMutableArray *playerOperationButtons;

	CCSprite *playerButtonContainer;
	
	AnimalManagerContainer *animalManagerContainer;

	int selectIndex;
}

-(void) addButton;


@end
