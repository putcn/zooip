//
//  DataModelDog.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-18.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelDog : NSObject {

	NSString* farmerDogId;
	NSString* goodsId;
	NSString* statusEndTime;
	NSString* endTime;
	NSString* goodsDuration;
	NSString* picturePrefix;
	NSString* goodsPicture;
	NSString* goodsName;
	NSString* goodsDescription;
	BOOL status;
	float probability;
	NSUInteger loseGoldenEgg;
	NSUInteger level;
	NSUInteger speed;
	NSUInteger step;
	NSUInteger aliveEdge;	
}

@property (nonatomic, retain) NSString* farmerDogId;
@property (nonatomic, retain) NSString* goodsId;
@property (nonatomic, retain) NSString* statusEndTime;
@property (nonatomic, retain) NSString* endTime;
@property (nonatomic, retain) NSString* goodsDuration;
@property (nonatomic, retain) NSString* picturePrefix;
@property (nonatomic, retain) NSString* goodsPicture;
@property (nonatomic, retain) NSString* goodsName;
@property (nonatomic, retain) NSString* goodsDescription;
@property (nonatomic, assign) BOOL status;
@property (nonatomic, assign) float probability;
@property (nonatomic, assign) NSUInteger loseGoldenEgg;
@property (nonatomic, assign) NSUInteger level;
@property (nonatomic, assign) NSUInteger speed;
@property (nonatomic, assign) NSUInteger step;
@property (nonatomic, assign) NSUInteger aliveEdge;

@end
