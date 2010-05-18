//
//  DataModelDejecta.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-18.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelDejecta : NSObject {
	
	NSString* dejectaId;
	// TODO float or int?
	NSInteger coordinateX;
	NSInteger coordinateY;
}

@property (nonatomic, retain) NSString* dejectaId;
@property (nonatomic, assign) NSInteger coordinateX;
@property (nonatomic, assign) NSInteger coordinateY;

@end
