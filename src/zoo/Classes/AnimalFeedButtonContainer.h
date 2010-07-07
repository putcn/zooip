//
//  AnimalFeedButtonContainer.h
//  zoo
//
//  Created by AlexLiu on 6/9/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import "Button.h"
#import "UIController.h"
#import "AnimalManagerContainer.h"

@interface AnimalFeedButtonContainer  : CCSprite {
	
	NSMutableArray *playerStatusIconTextures;
	
	NSMutableArray *playerOperationButtons;
	
	CCSprite *playerButtonContainer;
	
	AnimalManagerContainer *animalManagerContainer;
	
	int selectIndex;
	
	//The food buttons.
	int countOfFoodButton;
	
	CCSprite *statusIcon;
	
	id parentTarget;
}

-(void)setStatusIcon:(int)index;
-(id) initWithTarget:(id)target;
-(void) addButton;


@end
