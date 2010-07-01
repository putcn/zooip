//
//  LoadingBar.h
//  zoo
//
//  Created by jiang ziwei on 10-6-30.
//  Copyright 2010 shandongligong. All rights reserved.
//

#import "cocos2d.h"


@interface LoadingBar : CCSprite <CCTargetedTouchDelegate> {

	CCSprite* m_load_left;
	CCSprite* m_load_middle;
	CCSprite* m_load_right;
	CCSprite* m_load_Cololeft;
	CCSprite* m_load_Colomiddle;
	CCSprite* m_load_Coloright;
	
	CCLabel *text;
}


-(id) initWithCCSprite:(NSString*) labelText setColor:(ccColor3B) labelColor setFont:(NSString*) labelFont
			   setSize:(int) labelSize setTarget:(id) targetValue
		 setSpriteLeft:(CCSprite*) load_left setSpriteMidele:(CCSprite*) load_middle setSpriteRight:(CCSprite*) load_right
	 setSpriteColoLeft:(CCSprite*) load_Cololeft setSpriteColoMidele:(CCSprite*) load_Colomiddle setSpriteColoRight:(CCSprite*) load_Coloright
			   offsetX:(int) offsetXValue offsetY:(int) offsetYValue setpercent:(int) cent;


@end
