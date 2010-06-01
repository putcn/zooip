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
#import "ItemInfoPane.h"
#import "MessageDialog.h"


@interface StorageContainer : CCSprite {
	NSString *title;
	NSMutableDictionary *tabDic;
	NSMutableDictionary *tabContentDic;
	
	CCTexture2D *tabEnable;
	CCTexture2D *tabDisable;
	ItemInfoPane *itemInfoPane;
	
	
	int tabIndex;
}
@property (nonatomic,retain) NSString *title;


-(void)addTitle;
-(void)addTab:(NSArray *)tabArray;
@end



