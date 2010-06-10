//
//  StorageContainer.h
//  zoo
//
//  Created by majing on R.O.C. 99/5/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "UIController.h"
#import "MessageDialog.h"
#import "SellinfoPane.h"
#import "EggHatchInfoPane.h"
#import "TransBackground.h"
#import "StoButtonContainer.h"



@interface StorageContainer : CCSprite {
	NSString *title;
	NSMutableDictionary *tabDic;
	NSMutableDictionary *tabContentDic;
	
	CCTexture2D *tabEnable;
	CCTexture2D *tabDisable;
	SellinfoPane *itemInfoPane;
	EggHatchInfoPane *eggHatchInfoPane;
	
	StoButtonContainer *buttonContainer;
	
		
	NSString *curr_itemId;
	NSString *curr_itemType;
	NSString *testType;
	id curr_target;
	
	
	
	int tabIndex;
}
@property (nonatomic,retain) NSString *title;


-(void)addTitle;
-(void)addTab:(NSArray *)tabArray;
@end



