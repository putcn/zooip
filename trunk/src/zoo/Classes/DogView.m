//
//  DogView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DogView.h"
#import "AnimalImageProperty.h"
#import "ZooRecordTableViewController.h"

@implementation DogView
@synthesize dogId;
@synthesize m_pZooRecordTable;

-(id) init
{
	if((self = [super init]))
	{
		AnimalImageProperty *imageProperty = [[AnimalImageProperty alloc] init];
		animationTable = [[imageProperty animationTable:@"_dog.png" plistName:@"_dog.plist"] retain];
		NSLog(@"dog---%@", animationTable);
		self.scale = 1.0f/0.49f;
		[[GameMainScene sharedGameMainScene] addSpriteToStage:self z:5];
	//	[self runAction:[animationTable objectForKey:@"rest"]];
}
	return self;
}

-(void) update:(int)currDirectionValue status:(int)currStatusValue
{
	NSString *status = [statuses objectForKey: [NSString stringWithFormat:@"%d", currStatusValue]];
	NSString *direction= [dirctions objectForKey: [NSString stringWithFormat:@"%d",currDirectionValue]];
	if ([direction isEqualToString:@"right"]) 
	{
		self.flipX =YES;
		direction = @"left";
	}
	else if ([direction isEqualToString:@"rightUp"]) {
		self.flipX =YES;
		direction = @"left";
	}
	else if ([direction isEqualToString:@"rightDown"]){
		self.flipX =YES;
		direction = @"left";
	}	
	else if ([direction isEqualToString:@"leftUp"]) {
		self.flipX =NO;
		direction = @"left";
	}
	else if ([direction isEqualToString:@"leftDown"]){
		self.flipX =NO;
		direction = @"left";
	}
	else 
	{
		self.flipX = NO;
	}
	NSString *showKey;
	
	if (status == @"stand") {
		showKey = @"rest";
	}
	else {
		showKey = [[status stringByAppendingString:@"_"] stringByAppendingFormat:direction];
	}
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
	int type = OPERATION_DEFAULT;
	if (type == OPERATION_DEFAULT) {
	//	[self schedule:@selector(tick:) interval:4.0];
	}

	else {
		return;
	}
	
}

-(void)callServerController
{
	// Add by Hunk on 2010-07-29
	NSDictionary *param = [NSDictionary dictionaryWithObject:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId forKey:@"farmerId"];
	
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmerDog WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void)resultCallback:(NSObject *)value
{
	/*
	NSDictionary *result = (NSDictionary *)value;
	
	NSLog(@"%@\n", result);
	
	NSDictionary* dogDic = [[result objectForKey:@"dogs"] objectAtIndex:0];

	NSString* str = [dogDic objectForKey:@"goodsDescription"];

	NSArray* arrZooRecord = [NSArray arrayWithObject:str];
//	if(0 == [array count])
//	{
//		arrZooRecord = [NSArray arrayWithObject:@"暂无消息记录!"];
//	}
//	else
//	{
//		arrZooRecord = [NSArray arrayWithArray:array];
//	}
	
	if(nil == m_pZooRecordTable)
	{
		m_pZooRecordTable = [[ZooRecordTableViewController alloc]initWithNibName:@"ZooRecordTableViewController" bundle:nil];
	}
	[(ZooRecordTableViewController*)m_pZooRecordTable setM_arrayZooRecord:arrZooRecord];
	
	[[[UIApplication sharedApplication]keyWindow] addSubview:((ZooRecordTableViewController*)m_pZooRecordTable).view];
	 */
}

-(void)faultCallback:(NSObject *)value
{
	
	
}

								   
-(void) dealloc
{
	// Add by Hunk on 2010-06-29
	[animationTable release];
	[dogId release];
	
	
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}
								   

@end
