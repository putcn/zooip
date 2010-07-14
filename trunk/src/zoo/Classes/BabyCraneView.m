//
//  BabyCraneView.m
//  zoo
//
//  Created by Rainbow on 4/29/10.
//  mdify   by  Majing  on 5/25/10
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "BabyCraneView.h"
#import "AnimalImageProperty.h"


@implementation BabyCraneView

-(id) init
{	
	if ((self = [super init])) 
	{
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		animationTable = [imageProp animationTable:@"_BabyCrane.png" plistName:@"_BabyCrane.plist"];
		NSLog(@"------------%@", animationTable);
		
		// Add by Hunk on 2010-07-13 for memory leak
		//[imageProp release];
	}
	return self;
	
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[super dealloc];
}




@end
