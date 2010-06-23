//
//  AnimalExpansionPanel.h
//  zoo
//
//  Created by AlexLiu on 6/8/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DataEnvironment.h"
#import "DataModelOriginalAnimal.h"
#import "Button.h"


@interface AnimalExpansionPanel : CCSprite {
	NSString *title;
	NSString *itemId;
	NSString *itemType;
	NSString *itemBuyType;
	NSInteger itemPrice;
	NSInteger count;
	CCLabel *priceLbl;
	
	
	//for params;
	NSDictionary *paramsDict;
	
	//for list;
	NSString *level;
	NSString *maxNumOfBirds;
	NSString *goldenEggNum;
	NSInteger goldenEgg;
	NSInteger levelRequire;
	
	CCLabel *levelLbl;
	CCLabel *goldenEggNumLbl;
	CCLabel *capacity;
	CCLabel *requireLevelLbl;
	CCLabel *requireGoldenEggLbl;
	id thisTarget;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *itemId;
@property (nonatomic, retain) NSString *itemType;
@property (nonatomic, retain) NSString *itemBuyType;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic,retain) NSDictionary *paramsDict;


-(id)initWithParam:(NSDictionary *)param setTarget:(id)target;
-(id) initWithItem: (NSString *) itId type: (NSString *) itType setTarget: (id)target; 
-(id)initWithParam:(NSDictionary *)param setTarget:(id)target;
-(void)addTitle;
//-(void)addInfo: (id)target;
-(void) setImg: (NSString *) imagePath setBuyType: (NSString *) buyType setPrice:(NSString *) price;
-(void) updateInfo: (NSString *) itId type: (NSString *) itType setTarget:(id)target;
-(void) updatePrice: (NSDictionary *)values;
-(void)updateButtonsAndRates;
@end
