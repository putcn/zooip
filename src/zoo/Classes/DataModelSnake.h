//
//  DataModelSnake.h
//  zoo
//
//  Created by Zhou Shuyan on 10-5-18.
//  Copyright 2010 VIT. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataModelSnake : NSObject {
	NSString* releaseSnakeId;
	NSString* snakeReleaser;	// TODO farmerId?
	NSString* eggId;
}

@property (nonatomic, retain) NSString* releaseSnakeId;
@property (nonatomic, retain) NSString* snakeReleaser;
@property (nonatomic, retain) NSString* eggId;

@end
