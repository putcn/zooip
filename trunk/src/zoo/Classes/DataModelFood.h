//
//  DataModelFood.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelFood : NSObject {
	
	NSString* foodPower;
	NSString* foodName;
	NSString* foodImg;
	
	NSInteger foodId;
	NSInteger foodPrice;
	NSInteger antsRequired;
}

@property (nonatomic, retain) NSString* foodPower;
@property (nonatomic, retain) NSString* foodName;
@property (nonatomic, retain) NSString* foodImg;

@property (nonatomic, assign) NSInteger foodId;
@property (nonatomic, assign) NSInteger foodPrice;
@property (nonatomic, assign) NSInteger antsRequired;

@end
