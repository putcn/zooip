//
//  DataModelUserTips.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-19.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelUserTips : NSObject {
	NSString* snsUserId;
	BOOL egg;
	BOOL shit;
	BOOL snake;
	BOOL ant;
}

@property (nonatomic, retain) NSString* snsUserId;

@property (nonatomic, assign) BOOL egg;
@property (nonatomic, assign) BOOL shit;
@property (nonatomic, assign) BOOL snake;
@property (nonatomic, assign) BOOL ant;

@end
