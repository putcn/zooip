//
//  DataModelEgg.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-16.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelEgg : NSObject {
	NSString* birdEggId;
	NSString* farmId;
	NSString* lastStoleTime;
	// TODO NSPoint or?
	NSString* coordinate;
	NSString* eggId;
	NSString* eggName;
	NSString* eggNameEN;
	NSString* eggImgId;
	NSString* eggDescription;
	
	NSInteger quantity;
	NSInteger remain;
	NSInteger numOfZygote;
	NSInteger eggPrice;
	NSInteger zygotePrice;
}

@property (nonatomic, retain) NSString* birdEggId;
@property (nonatomic, retain) NSString* farmId;
@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, assign) NSInteger remain;
@property (nonatomic, retain) NSString* lastStoleTime;
@property (nonatomic, assign) NSInteger numOfZygote;
// TODO NSPoint or?
@property (nonatomic, retain) NSString* coordinate;
@property (nonatomic, retain) NSString* eggId;
@property (nonatomic, retain) NSString* eggName;
@property (nonatomic, retain) NSString* eggNameEN;
@property (nonatomic, assign) NSInteger eggPrice;
@property (nonatomic, assign) NSInteger zygotePrice;
@property (nonatomic, retain) NSString* eggImgId;
@property (nonatomic, retain) NSString* eggDescription;

@end
