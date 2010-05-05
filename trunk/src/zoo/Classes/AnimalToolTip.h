//
//  AnimalToolTip.h
//  zoo
//
//  Created by Rainbow on 5/4/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"

CCLabel *nameLbl;
CCLabel *timeLbl;
CCSprite *processorBar;
CCSprite *processorFrame;


@interface AnimalToolTip : CCSprite {
	float totalTime;
	float leaveTime;
}
 
@property (nonatomic,assign) float totalTime;
@property (nonatomic,assign) float leaveTime;

-(id) initWithName: (NSString *)name setTotalTime:(float)inTotalTime setLeaveTime:(float)inLeaveTime;
@end
