//
//  PlayerInfo.h
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PlayerInfo : CCSprite
{
	NSString *userName;
	NSString *userImg;
	NSString *currentExperience;
	NSString *nextLevelExperience;
	NSString *level;
	NSString *maxNumOfBirds;
	NSString *topMaxNumOfBirds;
	NSString *animalNum;
	NSString *antsNum;
	NSString *goldenEggNum;
	CCLabel *userNameLbl;
	CCLabel *experienceLbl;
	CCLabel *experienceBar;
	CCLabel *levelLbl;
	CCLabel *capacity;
	CCLabel *antsNumLbl;
	CCLabel *goldenEggNumLbl;
	CCLabel *animalNumLbl;
	CCSprite *userImgSprite;
	
}

-(void) updateUserInfo;

@end
