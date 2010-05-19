//
//  SnakeController.h
//  zoo
//
//  Created by Rainbow on 5/19/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SnakeController : NSObject {
	
	NSMutableArray *allSnakes;
}

+(SnakeController *) sharedSnakeController;

-(void) addSnakes:(NSArray *)snakeIds;
-(void) clearSnakes;

@end
