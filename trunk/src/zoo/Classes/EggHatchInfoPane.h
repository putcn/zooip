//
//  EggHatchInfoPane.h
//  zoo
//
//  Created by admin on R.O.C. 99/6/7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Button.h"
#import "ServiceHelper.h"
#import "FeedbackDialog.h"


@interface EggHatchInfoPane : CCSprite {
	NSString *title;
	CCLabel *lab_hatchEggInfo1;
	CCLabel *lab_hatchEggInfo2;
	CCLabel *lab_hatchEggInfo3;
	
	CCLabel *lab_notice;
	
	NSString *FARMER_ID;
	NSString *FARM_ID;
	NSString *STORAGEZY_ID;
	
	NSString *infoStr;
	NSString *payType;
	
	id myTarget;
	


}
-(id) initWithItem:(NSString *) farmerid farmID:(NSString *) farmid storageZyID:(NSString *) storageZyId setTarget:(id)target; 

-(void) hatChEggHandler:(Button *)button;


@end


