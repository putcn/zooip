//
//  FirecrackerView.m
//  zoo
//
//  Created by Rainbow on 5/12/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "FirecrackerView.h"
#import "GameMainScene.h"

@implementation FirecrackerView

-(id)init
{
	if ((self = [super init])) {
		self.scale = 3.0f;
		CCAnimation *operationAnimation = [CCAnimation animationWithName:@"operation" delay:0.2];
		for (int i = 1; i<= 9; i++) {
			[operationAnimation addFrameWithFilename:[NSString stringWithFormat:@"firecracker_%02d.png", i]];
		}
		operationAnimate = [[CCAnimate actionWithAnimation:operationAnimation] copy];
	}
	return self;
}

-(void) play
{
	
	[self runAction:operationAnimate];
}
// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[operationAnimate release];
	
	[super dealloc];
}
@end
