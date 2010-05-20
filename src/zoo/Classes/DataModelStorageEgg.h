//
//  DataModelStorageEgg.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelStorageEgg : NSObject {
	
	NSString* eggStorageId;
	NSString* eggId;
	NSString* eggName;
	NSString* eggImgId;
	NSString* eggDescription;
	
	NSInteger numOfProduct;
	NSInteger numOfStolen;
	NSInteger eggPrice;
}

@property (nonatomic, retain) NSString* eggStorageId;
@property (nonatomic, retain) NSString* eggId;
@property (nonatomic, retain) NSString* eggName;
@property (nonatomic, retain) NSString* eggImgId;
@property (nonatomic, retain) NSString* eggDescription;

@property (nonatomic, assign) NSInteger numOfProduct;
@property (nonatomic, assign) NSInteger numOfStolen;
@property (nonatomic, assign) NSInteger eggPrice;

@end
