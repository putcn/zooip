//
//  ChinemyView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ChinemyView.h"
#import "AnimalImageProperty.h"
#import "ZooRecordTableViewController.h"
#import "MyTableView.h"

@implementation ChinemyView
@synthesize m_pZooRecordTable;

-(id) init
{
	if((self = [super init]))
	{
		AnimalImageProperty *imageProperty = [[AnimalImageProperty alloc] init];
		animationTable = [[imageProperty animationTable:@"_chinemy.png" plistName:@"_chinemy.plist"] retain];
		NSLog(@"dog---%@", animationTable);
		self.scale = 1.0f/0.49f;
		[[GameMainScene sharedGameMainScene] addSpriteToStage:self z:5];
	}
	return self;
}

-(void) update:(int)currDirectionValue status:(int)currStatusValue
{
	NSString *status = @"walk";
	NSString *direction= [dirctions objectForKey: [NSString stringWithFormat:@"%d",currDirectionValue]];
	if ([direction isEqualToString:@"right"]) 
	{
		self.flipX =YES;
		direction = @"left";
	}
	else if ([direction isEqualToString:@"rightUp"]) {
		self.flipX =YES;
		direction = @"leftUp";
	}
	else if ([direction isEqualToString:@"rightDown"]){
		self.flipX =YES;
		direction = @"leftDown";
	}
	else 
	{
		self.flipX = NO;
	}
	
	NSString *showKey = [[status stringByAppendingString:@"_"] stringByAppendingFormat:direction];
	showKey = [showKey lowercaseString];
	[self stopAllActions];
	[self runAction:[animationTable objectForKey:showKey]];

}


- (CGRect)rect
{
	CGSize s = [self contentSize];
	return CGRectMake(-s.width/2, -s.height/2, s.width, s.height);
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:60 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if ( ![self containsTouchLocation:touch] || !self.visible ) return NO;
	//self.scale = 1;
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self optAnimationPlay];
	[self callServerController];
}

-(CGPoint)countCoordinate: (CGPoint)clickPoint
{
	return ccp(self.position.x + clickPoint.x - self.contentSize.width/2, self.position.y + clickPoint.y - self.contentSize.height/2);
}

-(void)optAnimationPlay
{
	int type = OPERATION_CURE_ANIMAL;
	if (type == OPERATION_DEFAULT) {
		[self schedule:@selector(tick:) interval:4.0];
	}
	else 
		if(type == OPERATION_CURE_ANIMAL){
		//	CGPoint location = ccp(self.position.x, self.position.y);
//			[[OperationViewController sharedOperationViewController] play:@"infusion" setPosition:location];
		}
		else {
			return;
		}
}

-(void)callServerController
{
	// Add by Hunk on 2010-07-29
	NSDictionary *param = [NSDictionary dictionaryWithObject:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId forKey:@"farmerId"];
	
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmerMessage WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void)resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	
	NSLog(@"%@\n", result);
	
	NSInteger code = [[result objectForKey:@"code"] intValue];
	switch (code)
	{
		case 0:
		{}
			break;
		case 1:
		{
			NSArray* array = [result objectForKey:@"message"];
			
		//	NSArray* arrZooRecord;
//			if(0 == [array count])
//			{
//				arrZooRecord = [NSArray arrayWithObject:@"暂无消息记录!"];
//			}
//			else
//			{
//				arrZooRecord = [NSArray arrayWithArray:array];
//			}
//			
//			if(nil == m_pZooRecordTable)
//			{
//				m_pZooRecordTable = [[ZooRecordTableViewController alloc]initWithNibName:@"ZooRecordTableViewController" bundle:nil];
//			}
//			[(ZooRecordTableViewController*)m_pZooRecordTable setM_arrayZooRecord:arrZooRecord];
//			
//			[[[UIApplication sharedApplication]keyWindow] addSubview:((ZooRecordTableViewController*)m_pZooRecordTable).view];
			
			[[MyTableView sharedMyTableView]awakeZooRecordTable:array bgImgName:@"BG_buy.png"];
		}
			break;
		default:
			break;
	}
}

-(void)faultCallback:(NSObject *)value
{


}

-(void)dealloc
{
	[animationTable release];
	[(ZooRecordTableViewController*)m_pZooRecordTable release];
	
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end

