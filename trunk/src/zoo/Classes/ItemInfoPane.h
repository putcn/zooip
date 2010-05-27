//
//  ItemInfoPane.h
//  zoo
//
//  Created by Rainbow on 5/26/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DataEnvironment.h"
#import "DataModelOriginalAnimal.h"
#import "DataModelFood.h"
#import "DataModelGood.h"
#import "Button.h"


@interface ItemInfoPane : CCSprite {
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
