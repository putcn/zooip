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

@interface ButtonContainer : CCSprite {
	int currentPageNum;
	int totalPage;
	int currentNum;
	NSString *tabFlag;
}
-(id) initWithTab:(NSString *)tabName;

-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;
-(void) generatePage;
@end
