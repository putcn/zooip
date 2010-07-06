//
//  BabyPigeonView.m
//  zoo
//
//  Created by Rainbow on 4/22/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "BabyPigeonView.h"
#import "AnimalImageProperty.h"


@implementation BabyPigeonView
-(id) init
{	
	if ((self = [super init])) {
		
		AnimalImageProperty *imageProp = [[AnimalImageProperty alloc] init];
		animationTable = [imageProp animationTable:@"_BabyPigeon.png" plistName:@"_BabyPigeon.plist"];
		NSLog(@"------------%@", animationTable);
		[self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:[animationTable objectForKey:@"stop"]]]];
		
	}
	return self;
	
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	
	
	[super dealloc];
}


@end
