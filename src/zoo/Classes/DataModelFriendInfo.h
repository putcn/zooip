//
//  DataModelFriendInfo.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-19.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelFriendInfo : NSObject {
	
	NSString* farmId;
	NSString* farmerId;
	NSString* userName;
	NSString* tinyurl;
	NSString* uid;
	
	NSInteger experience;
}

@property (nonatomic, retain) NSString* farmId;
@property (nonatomic, retain) NSString* farmerId;
@property (nonatomic, retain) NSString* userName;
@property (nonatomic, retain) NSString* tinyurl;
@property (nonatomic, retain) NSString* uid;

@property (nonatomic, assign) NSInteger experience;

@end
