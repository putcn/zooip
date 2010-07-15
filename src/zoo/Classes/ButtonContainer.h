//
//  ButtonContainer.h
//  zoo
//
//  Created by Rainbow on 5/24/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ServiceHelper.h"
#import "DataEnvironment.h"
#import "DataModelOriginalAnimal.h"
#import "DataModelFood.h"
#import "DataModelGood.h"
#import "Button.h"
#import "ItemButton.h"

@interface ButtonContainer : CCSprite {
	int currentPageNum;
	int totalPage;
	int currentNum;
	NSString *tabFlag;
	id parentTarget;
	
	CCLabel *pageLabel;
}
-(id) initWithTab:(NSString *)tabName setTarget:(id)target;

-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;
-(void) nextPage:(Button *)button;
-(void) forwardPage:(Button *)button;
-(void) generatePage;
@end
