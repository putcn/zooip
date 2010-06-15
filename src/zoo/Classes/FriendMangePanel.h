//
//  FriendMangePanel.h
//  zoo
//
//  Created by admin on R.O.C. 99/6/14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "UIController.h"
#import "ItemInfoPane.h"
#import "MessageDialog.h"
#import "TransBackground.h"
#import "FriendList.h"

@interface FriendMangePanel : CCSprite {
	NSString *title;
	NSMutableDictionary *tabDic;
	NSMutableDictionary *tabContentDic;
	
	CCTexture2D *tabEnable;
	CCTexture2D *tabDisable;
	ItemInfoPane *itemInfoPane;
	
	

}
@property (nonatomic,retain) NSString *title;


-(void)addTitle;

@end


