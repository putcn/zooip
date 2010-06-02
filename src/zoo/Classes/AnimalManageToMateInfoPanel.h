//
//  AnimalManageToMateInfoPanel.h
//  zoo
//
//  Created by Alex Liu on 6/2/10.
//  Copyright 2010 Vance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DataEnvironment.h"
#import "DataModelOriginalAnimal.h"
#import "DataModelFood.h"
#import "DataModelGood.h"
#import "Button.h"
#import "DataModelAnimal.h"
#import "AnimalManagementButtonItem.h"

@interface AnimalManageToMateInfoPanel: CCSprite {
	NSString *title;
	NSString *itemId;
	NSString *itemType;
	NSString *itemBuyType;
	NSInteger itemPrice;
	NSInteger count;
	CCLabel *priceLbl;
	
	//New added for paging
	int currentPageNum;
	int totalPage;
	int currentNum;
	id parentTarget;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *itemId;
@property (nonatomic, retain) NSString *itemType;
@property (nonatomic, retain) NSString *itemBuyType;
@property (nonatomic, assign) NSInteger count;
-(id) initWithItem: (NSString *) itId type: (NSString *) itType setTarget: (id)target; 
-(void)addTitle;
//-(void)addInfo: (id)target;
-(void) setImg: (NSString *) imagePath setBuyType: (NSString *) buyType setPrice:(NSString *) price;
-(void) updateInfo: (NSString *) itId type: (NSString *) itType setTarget:(id)target;
-(void) updatePrice: (NSDictionary *)values;
@end