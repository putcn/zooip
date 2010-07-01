//
//  LoadingBar.m
//  zoo
//
//  Created by jiang ziwei on 10-6-30.
//  Copyright 2010 shandongligong. All rights reserved.
//

#import "LoadingBar.h"


@implementation LoadingBar


-(id) initWithCCSprite:(NSString*) labelText setColor:(ccColor3B) labelColor setFont:(NSString*) labelFont
			setSize:(int) labelSize setTarget:(id) targetValue
		 setSpriteLeft:(CCSprite*) load_left setSpriteMidele:(CCSprite*) load_middle setSpriteRight:(CCSprite*) load_right
		setSpriteColoLeft:(CCSprite*) load_Cololeft setSpriteColoMidele:(CCSprite*) load_Colomiddle setSpriteColoRight:(CCSprite*) load_Coloright
		offsetX:(int) offsetXValue offsetY:(int) offsetYValue setpercent:(int) cent
{
	if( (self=[super init] ))
	{		
		load_left.position = ccp(-8,0);
		[load_left setAnchorPoint:ccp(0, 0)];
		
		load_middle.position = ccp(0,0);
		[load_middle setAnchorPoint:ccp(0, 0)];
		load_middle.scaleX = offsetXValue;
		
		load_right.position = ccp(offsetXValue*2,0);
		[load_right setAnchorPoint:ccp(0, 0)];
		
		
		load_Cololeft.position = ccp(-7,2);
		[load_Cololeft setAnchorPoint:ccp(0, 0)];
		
		load_Colomiddle.position = ccp(-2,2);
		[load_Colomiddle setAnchorPoint:ccp(0, 0)];
		load_Colomiddle.scaleX = offsetYValue*2+4;
		
		load_Coloright.position = ccp(offsetXValue*2+2,2);
		[load_Coloright setAnchorPoint:ccp(0, 0)];
		
		
		[self addChild:load_left];
		[self addChild:load_middle];
		[self addChild:load_right];
		if(cent == 1)
		{
			[self addChild:load_Cololeft];
			[self addChild:load_Colomiddle];
		}
		else if(cent == 2)
		{
			[self addChild:load_Cololeft];
			[self addChild:load_Colomiddle];
			[self addChild:load_Coloright];
		}
		
		
		text = [CCLabel labelWithString:labelText fontName:labelFont fontSize:labelSize];
		[text setAnchorPoint:ccp(0, 0)];
		text.position = ccp( offsetXValue*2+15 , -2 );
		text.color = labelColor;
		[self addChild:text];

	}
	return self;
}

-(void) dealloc
{
//	[label release];
//	[text release];
//	[targetCallBack release];
	[super dealloc];
}



@end
