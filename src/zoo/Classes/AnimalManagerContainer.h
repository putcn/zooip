//
//  AnimalManagerContainer.h
//  zoo
//
//  Created by Alex Liu on 6/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "UIController.h"
#import "SellinfoPane.h"
#import "AnimalManageToMateInfoPanel.h"

@interface AnimalManagerContainer : CCSprite {
	
	NSString *title;
	NSMutableDictionary *tabDic;
	NSMutableDictionary *tabContentDic;
	
	CCTexture2D *tabEnable;
	CCTexture2D *tabDisable;
	AnimalManageToMateInfoPanel *animalToMateInfoPanel;
	
	int tabIndex;
}
@property (nonatomic,retain) NSString *title;

-(id)initWithName:(NSString *)manageType;
-(void)addTitle;

@end