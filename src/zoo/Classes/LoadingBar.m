//
//  LoadingBar.m
//  zoo
//
//  Created by jiang ziwei on 10-6-30.
//  Copyright 2010 shandongligong. All rights reserved.
//

#import "LoadingBar.h"


@implementation LoadingBar


-(id) initWithCCSprite:(NSString*) labelText		//文字
			  setColor:(ccColor3B) labelColor		//颜色
			   setFont:(NSString*) labelFont		//字体
			   setSize:(int) labelSize				//大小
			 setTarget:(id) targetValue				//优先级
		 setSpriteLeft:(CCSprite*) load_left		//左空条
	   setSpriteMidele:(CCSprite*) load_middle		//中空条
		setSpriteRight:(CCSprite*) load_right		//右空条
	 setSpriteColoLeft:(CCSprite*) load_Cololeft	//左实条
   setSpriteColoMidele:(CCSprite*) load_Colomiddle	//中实条
	setSpriteColoRight:(CCSprite*) load_Coloright	//右实条
			   offsetX:(int) offsetXValue			//横向放大
			   offsetY:(int) offsetYValue			//纵向放大
			setpercent:(int) cent					//显示头尾
			 setLength:(int)length					//中条宽度
		  setTextLegth:(int)textlength				//控制字体横坐标
		  setTextHight:(int)texthight				//控制字体纵坐标
{
	if( (self=[super init] ))
	{		
		load_left.position = ccp(-8+length,0);
		[load_left setAnchorPoint:ccp(0, 0)];
		
		load_middle.position = ccp(0,0);
		[load_middle setAnchorPoint:ccp(0, 0)];
		load_middle.scaleX = offsetXValue;
		
		load_right.position = ccp(offsetXValue*length,0);
		[load_right setAnchorPoint:ccp(0, 0)];
		
		
		load_Cololeft.position = ccp(-7+length*2,2);
		[load_Cololeft setAnchorPoint:ccp(0, 0)];
		
		load_Colomiddle.position = ccp(-length,2);
		[load_Colomiddle setAnchorPoint:ccp(0, 0)];
		load_Colomiddle.scaleX = offsetYValue*length+4;
		
		load_Coloright.position = ccp(offsetXValue*length+2,2);
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
		text.position = ccp( offsetXValue*2+textlength , texthight );
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
