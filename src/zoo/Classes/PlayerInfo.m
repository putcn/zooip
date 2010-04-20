//
//  PlayerInfo.m
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlayerInfo.h"


@implementation PlayerInfo

-(id) init
{
	self = [super init];
	
	if (self)
	{
		CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"PlayerInfo.png" ofType:nil] ] ];
		CCSprite *playerInfo = [[CCSprite alloc] initWithTexture:bg];
		playerInfo.scale = 0.6f;
		[self addChild:playerInfo];
	}
	
	return self;
}

-(void) update
{
	
}

@end
