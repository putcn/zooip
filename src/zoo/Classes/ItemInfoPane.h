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
#import "DataModelStorageEgg.h"
#import "DataModelFood.h"
#import "DataModelGood.h"
#import "Button.h"

#import "NumberField.h"
@interface ItemInfoPane : CCSprite {
	NSString *title;
	NSString *itemId;
	NSString *itemType;
	NSString *itemBuyType;
	NSInteger itemPrice;
	NSInteger count;
	CCLabel *priceLbl;
	
	
	CCSprite *wheel;
	NumberField *numberField;
	float startValue;
	int maxCount;
	
	int totalAnt;
	int totalGold;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *itemId;
@property (nonatomic, retain) NSString *itemType;
@property (nonatomic, retain) NSString *itemBuyType;
@property (nonatomic, assign) NSInteger itemPrice;
@property (nonatomic, assign) NSInteger count;
-(id) initWithItem: (NSString *) itId type: (NSString *) itType setTarget: (id)target; 
-(void)addTitle;
//-(void)addInfo: (id)target;
-(void) setImg: (NSString *) imagePath setBuyType: (NSString *) buyType setPrice:(NSString *) price;
-(void) updateInfo: (NSString *) itId type: (NSString *) itType setTarget:(id)target;
-(void) updatePrice: (NSDictionary *)values;
@end
