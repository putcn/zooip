//
//  DataModelStorageFood.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelStorageFood : NSObject {
	
	NSString* foodStorageId;
	NSString* foodId;
	NSString* foodName;
	NSString* foodImg;

	NSUInteger numOfFood;
	NSUInteger foodPower;
}

@property (nonatomic, retain) NSString* foodStorageId;
@property (nonatomic, retain) NSString* foodId;
@property (nonatomic, retain) NSString* foodName;
@property (nonatomic, retain) NSString* foodImg;

@property (nonatomic, assign) NSUInteger numOfFood;
@property (nonatomic, assign) NSUInteger foodPower;

@end
