//
//  AnimalManageInfoPanel.h
//  zoo
//
//  Created by AlexLiu on 6/2/10.
//  Copyright 2010 Vance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Button.h"

@interface AnimalManageInfoPanel : CCSprite <CCTargetedTouchDelegate>
{
	BOOL isOpen;
	CCLabel *lblMessage;
	
	id targetCallBack;
	SEL selector;
}

@property BOOL isOpen;

-(id) initDialog:(NSString *) filePath setTarget:(id) target setSelector:(SEL) handler;
-(void) popUp:(NSString*) msg;
-(void) closeDialogHandler;
-(void)addTitle:(NSString *) title;

@end
