//
//  DataModelDejecta.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-18.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelDejecta.h"


@implementation DataModelDejecta

@synthesize
dejectaId,
coordinateX,
coordinateY;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[dejectaId release];
	
	[super dealloc];
}


@end
