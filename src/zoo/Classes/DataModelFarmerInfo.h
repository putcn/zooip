//
//  DataModelFarmerInfo.h
//  zoo
//
//  Created by Gu Lei on 10-5-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataModelCommon.h"


@interface DataModelFarmerInfo : DataModelCommon
{
	NSInteger antsCurrency;
	NSString *farmerId;
	NSInteger snsUserId;
	NSInteger platformId;
	NSString *userName;
	NSString *userImg;
	NSInteger farmPref;
	NSInteger fighter;
	BOOL isNewUser;
	BOOL haveNewMessage;
	NSInteger level;
	NSInteger experience;
	NSInteger nextLevelExp;
	NSInteger goldenEgg;
	BOOL haveTurtle;
}

@property(nonatomic,assign) NSInteger antsCurrency;
@property(nonatomic,assign) NSInteger snsUserId;
@property(nonatomic,assign) NSInteger platformId;
@property(nonatomic,assign) NSInteger farmPref;
@property(nonatomic,assign) NSInteger fighter;
@property(nonatomic,assign) NSInteger level;
@property(nonatomic,assign) NSInteger experience;
@property(nonatomic,assign) NSInteger nextLevelExp;
@property(nonatomic,assign) NSInteger goldenEgg;
@property(nonatomic,assign) BOOL isNewUser;
@property(nonatomic,assign) BOOL haveNewMessage;
@property(nonatomic,assign) BOOL haveTurtle;
@property(nonatomic,retain) NSString *farmerId;
@property(nonatomic,retain) NSString *userName;
@property(nonatomic,retain) NSString *userImg;

@end
