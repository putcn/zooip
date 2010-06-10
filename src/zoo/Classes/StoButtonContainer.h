//
//  StoButtonContainer.h
//  zoo
//
//  Created by admin on R.O.C. 99/5/28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ServiceHelper.h"
#import "DataEnvironment.h"
#import "DataModelStorageEgg.h"
#import "DataModelStorageZygoteEgg.h"
#import "Button.h"
#import "SellitemButton.h"
#import "FeedbackDialog.h"

@interface StoButtonContainer : CCSprite {
	int currentPageNum;
	int totalPage;
	int currentNum;
	NSString *tabFlag;
	id parentTarget;
	
	CCLabel *totalPriceLab;
	NSInteger totalPrice;
}
-(id) initWithTab:(NSString *)tabName setTarget:(id)target;

-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;
-(void) nextPage:(Button *)button;
-(void) forwardPage:(Button *)button;
-(void) sellAllEggsHandler:(Button *)button;
-(void) generatePage;
@end
