//
//  DataEnvironment.h
//  Qunar
//
//  Created by kevinhuang on 2/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataEnvironment : NSObject {
	NSString *departureCity;
	NSString *arrivalCity;
	NSDate *departureDate;
	NSDate *arrivalDate;
	NSString *keyword;
	NSInteger price;
	BOOL isUseMap;
	BOOL isDoubleWay;
	BOOL isMultiStop;
	BOOL searchCondUpdated;
	NSInteger searchCondOrder;
	NSDictionary *searchCondFilterTakeoffTimeDict;
	NSDictionary *searchCondFilterFlightCompanyDict;
	NSDictionary *searchCondFilterTakeoffAirportDict;
	NSDictionary *searchCondFilterStarDict;
	NSDictionary *starValueDict;
	NSString *flightCode;
	//NSString *hotelName;
	NSArray *priceAry;
	NSDictionary *selectedHotel;
}
+ (DataEnvironment *)sharedDataEnvironment;
- (void)restore;

@property(nonatomic,retain) NSString *departureCity;
@property(nonatomic,retain) NSString *arrivalCity;
@property(nonatomic,retain) NSDate *departureDate;
@property(nonatomic,retain) NSDate *arrivalDate;
@property(nonatomic,retain) NSString *keyword;
@property(nonatomic,assign) NSInteger price;
@property(nonatomic,assign) BOOL isDoubleWay;
@property(nonatomic,assign) BOOL isMultiStop;
@property(nonatomic,assign) BOOL isUseMap;
@property(nonatomic,assign) BOOL searchCondUpdated;
@property(nonatomic,assign) NSInteger searchCondOrder;
@property(nonatomic,retain) NSDictionary *searchCondFilterTakeoffTimeDict;
@property(nonatomic,retain) NSDictionary *searchCondFilterFlightCompanyDict;
@property(nonatomic,retain) NSDictionary *searchCondFilterTakeoffAirportDict;
@property(nonatomic,retain) NSDictionary *searchCondFilterStarDict;
@property(nonatomic,retain) NSDictionary *starValueDict;
@property(nonatomic,retain) NSString *flightCode;
@property(nonatomic,retain) NSArray *priceAry;
@property(nonatomic,retain) NSDictionary *selectedHotel;

@end
