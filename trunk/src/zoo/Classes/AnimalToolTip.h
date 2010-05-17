//
//  AnimalToolTip.h
//  zoo
//
//  Created by Rainbow on 5/4/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "DataEnvironment.h"
#import "ToolTip.h"



@interface AnimalToolTip : ToolTip{
	CCLabel *nameLbl;
	CCLabel *timeLbl;
	CCSprite *processorBar;
	CCSprite *processorFrame;
	float remainTime;
	float totalTime;
	NSString *animalId;
}

-(id) initWithAnimalId: (NSString *) aniId;
@end
