//
//  StealEggsFromFarmController.h
//  zoo
//
//  Created by Rainbow on 6/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServerController.h"


@interface StealEggsFromFarmController:BaseServerController
{
	NSString * eggId;
}

@property (nonatomic,retain) NSString *eggId;

-(void) execute:(NSDictionary *)value;
-(void) resultCallback:(NSObject *)value;
-(void) faultCallback:(NSObject *)value;

@end
