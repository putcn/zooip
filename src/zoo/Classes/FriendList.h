//
//  FriendList.h
//  zoo
//
//  Created by admin on R.O.C. 99/6/11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ServiceHelper.h"
#import "DataEnvironment.h"
#import "DataModelFriendInfo.h"
#import "FriendList.h"
#import "FriendInfoBut.h"

#import "Button.h"


@interface FriendList : CCSprite {
	int currentPageNum;
	int totalPage;
	int currentPage;
	int displayNum;
	int currentNum;
	id parentTarget;
	NSMutableArray *friendListArray;
	
	UIView *_view;
	UITextField* levelEntryTextField;
	DataModelFriendInfo *dataModelfriend_search;
	NSString *result;
	BOOL searchDown;
	
	CCLabel *pageLabel;
	int nStatus;
}
-(id) initWithTab:(id)target;

-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;
-(void) nextPage:(Button *)button;
-(void) forwardPage:(Button *)button;
-(void) generatePage;
-(int ) getStatus;

NSInteger compareFriendArrayExpSelector(id f1, id f2, void *context);
@end
