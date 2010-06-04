//
//  AnimalStorageManagerContainer.h
//  zoo
//
//  Created by AlexLiu on 6/4/10.
//  Copyright 2010 Vance. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "UIController.h"
#import "ItemInfoPane.h"
#import "MessageDialog.h"
#import "TransBackground.h"
#import "AnimalStorageManagerButtonItem.h"



@interface AnimalStorageManagerContainer : CCSprite{
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
