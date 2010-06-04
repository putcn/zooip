//
//  AnimalManagementMateOrDisList.h
//  zoo
//
//  Created by AlexLiu on 6/3/10.
//  Copyright 2010 Vance. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "DataEnvironment.h"
#import "Button.h"
#import "DataModelOriginalAnimal.h"
#import "AnimalManagementButtonItem.h"
#import "AnimalManageButtonContainer.h"

@interface AnimalManagementMateOrDisList : CCSprite {
	int currentPageNum;
	int totalPage;
	int currentNum;
	NSString *tabFlag;
	id parentTarget;
}
-(id) initWithTab:(NSString *)tabName setTarget:(id)target;

-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;
-(void) nextPage:(Button *)button;
-(void) forwardPage:(Button *)button;
-(void) generatePage;

@end
