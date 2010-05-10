//
//  AnimalToolTip.h
//  zoo
//
//  Created by Rainbow on 5/4/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "DataModelAnimal.h"

CCLabel *nameLbl;
CCLabel *timeLbl;
CCSprite *processorBar;
CCSprite *processorFrame;
float remainTime;
float totalTime;

@interface AnimalToolTip : CCSprite {
	
	DataModelAnimal *data;
}

@property (nonatomic, retain) DataModelAnimal *data;

-(id) initWithName: (NSString *)name setTotalTime:(float)inTotalTime setLeaveTime:(float)inLeaveTime;
@end
