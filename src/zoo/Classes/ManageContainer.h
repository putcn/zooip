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


@interface ManageContainer : CCSprite{
	NSString *title;
	NSMutableDictionary *tabDic;
	NSMutableDictionary *tabContentDic;
	
	CCTexture2D *tabEnable;
	CCTexture2D *tabDisable;
	
	int tabIndex;
}
@property (nonatomic,retain) NSString *title;


-(void)addTitle;
-(void)addTab:(NSArray *)tabArray;
@end
