//
//  BowlsView.h
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "CCSprite.h"
#import "CCTexture2D.h"

CCTexture2D *bowls;
CGRect rect;

@interface BowlsView : CCSprite {
	
}

-(id) initWithFoodEndTime : (NSDate *) foodEndTime;

-(void)update: (NSDate *) foodEndTime;
@end
