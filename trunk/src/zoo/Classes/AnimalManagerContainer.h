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
#import "AniamalManagementMateOrDisapart.h"

@interface AnimalManagerContainer : CCSprite {
	
	NSString *title;
	NSMutableDictionary *tabDic;
	NSMutableDictionary *tabContentDic;
	
	CCTexture2D *tabEnable;
	CCTexture2D *tabDisable;
	AnimalManageToMateInfoPanel *animalToMateInfoPanel;
	AniamalManagementMateOrDisapart *animalToMateOrDisapart;
	
	int tabIndex;
	NSString *managementType;
}
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *managementType;

-(id)initWithName:(NSString *)manageType;
-(void)addTitle;

@end