//
//  ManageContainer.h
//  zoo
//
//  Created by Rainbow on 5/24/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "UIController.h"
#import "ItemInfoPane.h"
#import "MessageDialog.h"
#import "TransBackground.h"
#import "PlayerInfo.h"
#import "ItemButton.h"


@interface ManageContainer : CCSprite{
	NSString *title;
	NSMutableDictionary *tabDic;
	NSMutableDictionary *tabContentDic;
	
	CCTexture2D *tabEnable;
	CCTexture2D *tabDisable;
	ItemInfoPane *itemInfoPane;
	
	NSInteger tempPrice;
	NSInteger tempCount;
	NSString *curr_itemId;
	NSString *curr_itemType;
	PlayerInfo *playerInfo;
	
	int tabIndex;
}
@property (nonatomic,retain) NSString *title;

-(void) itemInfoHandler:(ItemButton *) itemButton;
-(void)addTitle;
-(void)addTab:(NSArray *)tabArray;

@end
