//
//  FriendInfoBut.h
//  zoo
//
//  Created by admin on R.O.C. 99/6/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "FriendInfoBut.h"

@interface FriendInfoBut : CCSprite <CCTargetedTouchDelegate>
{
	
	id targetCallBack;
	SEL selector;
	int pri;
	
	NSString* friendFarmId;
	NSString* friendFarmerId;
	NSString* uId;
	NSString* friendNames;
		

}

@property (nonatomic, retain)NSString *friendFarmId;
@property (nonatomic, retain)NSString *friendFarmerId;
@property (nonatomic, retain)NSString *uId;
@property (nonatomic, retain)NSString *friendNames;

-(id) initFirendInfo:(NSString *)farmId setFarmerId:(NSString *)farmerid  setFriendId:(NSString *)friendId 
			setFriendName:(NSString *)friendName setFirendIco:(NSString*) friendIco setExperience:(int) experience  
			setTarget:(id) target setSelector:(SEL) handler setPriority:(int) priorityValue 
			offsetX:(int) offsetXValue offsetY:(int) offsetYValue;


-(void) setFriendIco: (NSString *) icoPath setFriendName: (NSString *) friendName setExperience:(int) exprience;

@end
