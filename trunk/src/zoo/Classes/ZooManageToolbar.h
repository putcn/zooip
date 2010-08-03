//
//  ZooManageToolbar.h
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Button.h"
#import "UIController.h"
#import "AnimalMangementButtonContainer.h"
#import "AnimalStorageManagerContainer.h"
#import "AnimalExpansionPanel.h"
#import "AnimalFeedButtonContainer.h"

#import "ExpandView.h"

@interface ZooManageToolbar : CCSprite<CCTargetedTouchDelegate>
{
	AnimalMangementButtonContainer *aniManagementBtnCtrl;
	AnimalStorageManagerContainer *animalManagerContainer;
	AnimalExpansionPanel *animalExpansionPanel;
	AnimalFeedButtonContainer *feed;
	
	NSMutableArray *playerStatusIconTextures;
	NSMutableArray *friendStatusIconTextures;
	NSMutableArray *playerOperationButtons;
	NSMutableArray *friendOperationButtons;
	CCSprite *playerButtonContainer;
	CCSprite *friendButtonContainer;
	CCSprite *statusIcon;
	int selectIndex;
	BOOL secondTouchAniManagement; //The seconde time of touch the animal management.
	BOOL secondTouchFarmExpansion; 
	BOOL secondTouchFarmStorage;
	BOOL secondTouchFeedButton;
	
	
	ExpandView* m_ExpandView;
	UIAlertView* myAlert;
}

-(void) addButton;
-(void) addStatusIconTexture;

-(void) switchZoo:(Boolean) isSelf;

@end
