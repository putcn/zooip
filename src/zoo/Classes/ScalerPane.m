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

-(id) initWithCounter:(NSInteger)countMin max:(NSInteger)countMax delta:(NSInteger)countdDelta target:(id)parentTarget price:(float)unitPrice z:(NSInteger) z Priority:(int) priorityValue
{
	if ((self = [super init])) {
		min = countMin;
		max = countMax;
		delta = countdDelta;
		count = min;
		uPrice = unitPrice;
		targetCallBack = parentTarget;
		[self setContentSize:CGSizeMake(100, 50)];
		counterLbl = [[CCLabel labelWithString:@"" fontName:@"Arial" fontSize:40] retain];
		[counterLbl setColor:ccc3(0,0,0)];
		[counterLbl setString:[NSString stringWithFormat:@"%d",count]];
		totalPrice = uPrice * count;
		counterLbl.position = self.position;
		Button *addBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(counterReduce:) setPriority:priorityValue offsetX:0 offsetY:0 scale:1.0f];
		Button *reduceBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(counterAdd:) setPriority:priorityValue offsetX:0 offsetY:0 scale:1.0f];
		addBtn.flipX = YES;
		reduceBtn.position = ccp(self.contentSize.width/2 + 100, 0);
		addBtn.position = ccp(self.contentSize.width/2 - 100, 0);
		[self addChild:counterLbl z:z];
		[self addChild:addBtn z:z];
		[self addChild:reduceBtn z:z];
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

@end
