//
//  FeedbackDialog.h
//  zoo
//
//  Created by Rainbow on 6/7/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface FeedbackDialog : CCSprite {
	NSMutableArray *msgQuence;
	CCLabel *msgLbl;
	BOOL isShowing;
	id actionSequence;
}

@property (nonatomic, retain) NSMutableArray *msgQuence;


+ (FeedbackDialog *) sharedFeedbackDialog;
-(void) addMessage:(NSString *)newMessage;
-(void) showMessage;
-(void) msgFinish:(id)sender;

@end
