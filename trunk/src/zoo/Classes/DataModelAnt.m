//
//  DataModelAnt.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-18.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelAnt.h"


@implementation DataModelAnt

@synthesize
releaseAntsId,
antsReleaser;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[releaseAntsId release];
	[antsReleaser release];
	
	[super dealloc];
}


@end
