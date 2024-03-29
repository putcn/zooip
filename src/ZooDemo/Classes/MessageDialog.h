//
//  MessageDialog.h
//  Jianghu
//
//  Created by Niu Darcy on 1/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface MessageDialog : CCSprite <CCTargetedTouchDelegate>
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

@end
