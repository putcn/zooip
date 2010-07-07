//
//  DataModelStorageZygoteEgg.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelStorageZygoteEgg : NSObject {

	NSString* zygoteStorageId;
	NSString* eggId;
	NSString* originalAnimalId;
	NSString* eggName;
	NSString* eggNameEN;
	NSString* zygoteBirthday;
	
	NSInteger baseYield;
	NSInteger incubatingTime;
	NSInteger zygoteGender;
	NSInteger status;
	NSInteger eggPrice;
	NSInteger zygotePrice;
}

@property (nonatomic, retain) NSString* zygoteStorageId;
@property (nonatomic, retain) NSString* eggId;
@property (nonatomic, retain) NSString* originalAnimalId;
@property (nonatomic, retain) NSString* eggName;
@property (nonatomic, retain) NSString* eggNameEN;
@property (nonatomic, retain) NSString* zygoteBirthday;

@property (nonatomic, assign) NSInteger baseYield;
@property (nonatomic, assign) NSInteger incubatingTime;
@property (nonatomic, assign) NSInteger zygoteGender;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger eggPrice;
@property (nonatomic, assign) NSInteger zygotePrice;

@end
