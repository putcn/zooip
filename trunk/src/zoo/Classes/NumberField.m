//
//  NumberField.m
//  Jianghu
//
//  Created by Niu Darcy on 1/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NumberField.h"


@implementation NumberField

-(id) initWithCounter:(NSInteger)countMin target:(id)parentTarget z:(NSInteger) z Priority:(int) priorityValue  {
	if ((self = [super init]))
	{
		CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"滚轮数字文本框.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		
		CGSize s = [self.texture contentSize];
		
		lblText = [CCLabel labelWithString:@"0" fontName:@"Arial" fontSize:12];
		lblText.position = ccp( s.width / 2 , (s.height / 2) );
		lblText.color = ccc3(102, 0, 0);
		[self addChild:lblText];
	}
	return self;
}

-(void) dealloc
{
	[lblText release];
	[super dealloc];
}

-(void) setCount:(int) countValue
{
	count = countValue;
	[lblText setString:[NSString stringWithFormat:@"%d", count]];
	NSDictionary *values = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",count], @"count",nil];

	[targetCallBack performSelector:@selector(updatePrice:) withObject:values];
}
-(int) getCount
{
	return count;
}
-(void) addCount:(int) incrementValue
{
	count += incrementValue;
	[lblText setString:[NSString stringWithFormat:@"%d", count]];
	NSDictionary *values = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",count], @"count",nil];

	[targetCallBack performSelector:@selector(updatePrice:) withObject:values];
}

@end
