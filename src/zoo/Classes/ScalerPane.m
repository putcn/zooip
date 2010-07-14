//
//  ScalerPane.m
//  zoo
//
//  Created by Rainbow on 5/31/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ScalerPane.h"


@implementation ScalerPane
@synthesize count, totalPrice;

-(id) initWithCounter:(NSInteger)countMin max:(NSInteger)countMax delta:(NSInteger)countdDelta target:(id)parentTarget price:(float)unitPrice z:(NSInteger) z Priority:(int) priorityValue setPathname:(NSString*) path setlength:(int )length
{
	if ((self = [super init])) {
		min = countMin;
		max = countMax;
		delta = countdDelta;
		count = min;
		uPrice = unitPrice;
		targetCallBack = parentTarget;
//		[self setContentSize:CGSizeMake(100, 50)];
		counterLbl = [[CCLabel labelWithString:@"" fontName:@"Arial" fontSize:20] retain];
		[counterLbl setColor:ccc3(0,0,0)];
		[counterLbl setString:[NSString stringWithFormat:@"%d",count]];
		totalPrice = uPrice * count;
//		counterLbl.position = self.position;
		counterLbl.position = ccp(70,50);
		
//		NSString *path = @"加减显示器.png";
		CCSprite* bg_2 = [CCSprite spriteWithFile:path];
		bg_2.position = ccp(70,50);
		[self addChild:bg_2 z:7 ];
		
		
		Button *reduceBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_左.png" setTarget:self setSelector:@selector(counterReduce:) setPriority:priorityValue offsetX:0 offsetY:0 scale:1.0f];
		
		Button *reduceLeftBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_右.png" setTarget:self setSelector:@selector(counterAdd:) setPriority:priorityValue offsetX:0 offsetY:0 scale:1.0f];
		

		
		//		addBtn.flipX = YES;
//		reduceBtn.flipX = YES;
		reduceBtn.position = ccp(35 - length,50);
		reduceLeftBtn.position = ccp(105 + length,50);
		
		[self addChild:counterLbl z:z];
		[self addChild:reduceLeftBtn z:z];
		[self addChild:reduceBtn z:z];
		
		[reduceBtn release];
		[reduceLeftBtn release];
	}
	return self;
}


-(void) counterAdd:(Button*) button
{
	if (count < max) {
		count = count + delta;
		[counterLbl setString:[NSString stringWithFormat:@"%d",count]];
		NSDictionary *values = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",count], @"count",nil];
		//当产品数量增加的时候执行回调函数 [ItemInfoPane updataPrice]
		[targetCallBack performSelector:@selector(updatePrice:) withObject:values];
	}
	
}

-(void) counterReduce:(Button*) button
{
	if (count > min) {
		count = count - delta;
		totalPrice  = uPrice * count;
		[counterLbl setString:[NSString stringWithFormat:@"%d",count]];
		NSDictionary *values = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",count], @"count",nil];
		[targetCallBack performSelector:@selector(updatePrice:) withObject:values];
	}
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[counterLbl release];
	[targetCallBack release];
	
	[super dealloc];
}


@end
