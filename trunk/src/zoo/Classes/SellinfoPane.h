//
//  SellinfoPane.h
//  zoo
//
//  Created by admin on R.O.C. 99/5/28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DataEnvironment.h"
#import "DataModelOriginalAnimal.h"
#import "DataModelFood.h"
#import "DataModelGood.h"
#import "Button.h"

@interface SellinfoPane : CCSprite {
	NSString *title;
	NSString *itemId;
	NSString *itemType;
	NSInteger itemBuyType;
}

@property (nonatomic, retain) NSString *title;

-(id) initWithItem: (NSString *) itId type: (NSString *) itType setTarget: (id)target; 

-(void)addTitle;
-(void)addInfo: (id)target;
-(void) setImg: (NSString *) imagePath setBuyType: (int) buyType setPrice:(NSString *) price;
-(void) updateInfo: (NSString *) itId type: (NSString *) itType setTarget:(id)target;
@end
