//
//  DataModelGood.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelGood : NSObject {

	NSString* goodsId;
	NSString* capability1;
	NSString* capability2;
	NSString* goodsPicture;
	NSString* goodsName;
	NSString* goodsDescription;
	
	NSInteger goodsType;
	NSInteger goodsDuration;
	NSInteger currencyType;
	NSInteger goodsAntsPrice;
	NSInteger goodsGoldenPrice;
	NSInteger levelRequired;
}

@property (nonatomic, retain) NSString* goodsId;
@property (nonatomic, retain) NSString* capability1;
@property (nonatomic, retain) NSString* capability2;
@property (nonatomic, retain) NSString* goodsPicture;
@property (nonatomic, retain) NSString* goodsName;
@property (nonatomic, retain) NSString* goodsDescription;

@property (nonatomic, assign) NSInteger goodsType;
@property (nonatomic, assign) NSInteger goodsDuration;
@property (nonatomic, assign) NSInteger currencyType;
@property (nonatomic, assign) NSInteger goodsAntsPrice;
@property (nonatomic, assign) NSInteger goodsGoldenPrice;
@property (nonatomic, assign) NSInteger levelRequired;

@end
