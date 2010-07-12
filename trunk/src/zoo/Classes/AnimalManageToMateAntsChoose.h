//
//  AnimalToMateAntsChoose.h
//  zoo
//
//  Created by Alex Liu on 6/3/10.
//  Copyright 2010 Vance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "DataEnvironment.h"
#import "DataModelOriginalAnimal.h"
#import "DataModelFood.h"
#import "DataModelGood.h"
#import "Button.h"
#import "AnimalManageInfoPanel.h"
#import "LoadingBar.h"
@interface AnimalManageToMateAntsChoose : CCSprite {
	NSString *title;
	NSString *itemId;
	NSString *itemType;
	NSString *itemBuyType;
	NSInteger itemPrice;
	NSInteger count;
	CCLabel *priceLbl;
	
	
	//for params;
	NSDictionary *paramsDict;
	
	NSString *maledIdBeforeMarry;
	NSString *femaledIdBeforeMarry;
	NSString *animalIDAfterMarry;
	NSInteger antsCount;
	
//	CCSprite *load_left;
//	CCSprite *load_middle;
//	CCSprite *load_right;
//	CCSprite *load_Cololeft;
//	CCSprite *load_Colomiddle;
//	CCSprite *load_Coloright;
//	LoadingBar *load_1;
	NSString *spercent;
	
	CCLabel *numberLbl;
		
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *itemId;
@property (nonatomic, retain) NSString *itemType;
@property (nonatomic, retain) NSString *itemBuyType;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic,retain) NSDictionary *paramsDict;

@property (nonatomic, retain) NSString *maledIdBeforeMarry;
@property (nonatomic, retain) NSString *femaledIdBeforeMarry;
@property (nonatomic, retain) NSString *animalIDAfterMarry;
@property (nonatomic, assign) NSInteger antsCount;


-(id)initWithParam:(NSDictionary *)param setTarget:(id)target setLeftAnimalId:(NSString *)leftAnimalID setRightAnimalId:(NSString *) rightAnimalID;
-(id) initWithItem: (NSString *) itId type: (NSString *) itType setTarget: (id)target; 
-(id)initWithParam:(NSDictionary *)param setTarget:(id)target;
-(void)addTitle;
//-(void)addInfo: (id)target;
-(void) setImg: (NSString *) imagePath setBuyType: (NSString *) buyType setPrice:(NSString *) price;
-(void) updateInfo: (NSString *) itId type: (NSString *) itType setTarget:(id)target;
-(void) updatePrice: (NSDictionary *)values;
-(void)updateButtonsAndRates:(id)target;
@end

