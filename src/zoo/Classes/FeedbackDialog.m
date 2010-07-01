//
//  FeedbackDialog.m
//  zoo
//
//  Created by Rainbow on 6/7/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "FeedbackDialog.h"
#import "GameMainScene.h"


@implementation FeedbackDialog

static FeedbackDialog *_feedbackDialog;
@synthesize msgQuence;

+ (FeedbackDialog *)sharedFeedbackDialog{
    @synchronized( self ) {
        if ( _feedbackDialog == nil ) {
            /* _feedbackDialog set up in init */
			
            
			_feedbackDialog = [[self alloc] init];
			
        }
    }
	
    return _feedbackDialog;
}

-(id)init
{
	if ((self = [super init])) {
		isShowing = NO;
		msgQuence = [[NSMutableArray alloc] init];
		CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"条形_bg.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture: bg];
		[self setTextureRect: rect];
		[bg release];
		msgLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:12];
		[msgLbl setColor:ccc3(0, 0, 0)];
		msgLbl.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
		id moveTo = [CCMoveTo actionWithDuration:0.5 position:ccp(self.contentSize.width/2,280)];
		id delay = [CCDelayTime actionWithDuration:2];
		id moveBack = [CCMoveTo actionWithDuration:0.5 position:ccp(-self.contentSize.width/2,280)];
		id finishAction = [CCCallFunc actionWithTarget:self selector:@selector(msgFinish:)];
		actionSequence = [[CCSequence actions:moveTo, delay, moveBack, finishAction,nil] retain];
		[self addChild:msgLbl z:10];
		self.position = ccp(-self.contentSize.width/2,280);
		[[GameMainScene sharedGameMainScene] addDialogToScreen:self z:100];
	}
	return self;
}

-(void)addMessage:(NSString *)newMessage
{
	[msgQuence addObject:newMessage];
	if (!isShowing) {
		[self showMessage];
	}
}

-(void)showMessage
{
	if ([msgQuence count] >0) {
		isShowing = YES;
		[self stopAllActions];
		NSString *currentMsg= [msgQuence objectAtIndex:0];
		[msgLbl setString:currentMsg];
		[msgQuence removeObjectAtIndex:0];
		[self runAction:actionSequence];
	}
	else {
		isShowing = NO;
	}

}

-(void) msgFinish:(id)sender
{
	if ([msgQuence count] > 0) {
		[self showMessage];
	}
	else {
		isShowing = NO;
	}

}


-(void)dealloc
{
	// Add by Hunk on 2010-06-29
	[msgLbl release];
	[actionSequence release];
	
	[msgQuence release];
	[super dealloc];
}
@end
