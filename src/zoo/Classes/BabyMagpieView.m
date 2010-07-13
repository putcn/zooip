//
//  BabyMagpieView.m
//  zoo
//
//  Created by Rainbow on 4/22/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "BabyMagpieView.h"
#import "AnimalImageProperty.h"


@implementation BabyMagpieView

-(id) init
{	
	if ((self = [super init])) {
		
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		animationTable = [imageProp animationTable:@"_BabyMagpie.png" plistName:@"_BabyMagpie.plist"];
		NSLog(@"------------%@", animationTable);
		[self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[animationTable objectForKey:@"stop"]]]];
		
		// Add by Hunk on 2010-07-13 for memory leak
		[imageProp release];
	}
	return self;
	
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	
	
	[super dealloc];
}


@end
