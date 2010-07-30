//
//  ZooRecordTableCell.m
//  zoo
//
//  Created by Hunk on 10-7-30.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import "ZooRecordTableCell.h"

@interface ZooRecordTableCell(SubviewFrames)

-(CGRect)zooRecordLabelFrame;

@end


@implementation ZooRecordTableCell
@synthesize zooRecordLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		zooRecordLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [zooRecordLabel setFont:[UIFont systemFontOfSize:14.0]];
        [zooRecordLabel setTextColor:[UIColor darkGrayColor]];
        [zooRecordLabel setHighlightedTextColor:[UIColor whiteColor]];
		[zooRecordLabel setBackgroundColor:[UIColor clearColor]];
        
		[self.contentView addSubview:zooRecordLabel];
	}
	return self;
}

#pragma mark -
#pragma mark Create table list
-(void)creatTableList:(NSString*)listString
{
	zooRecordLabel.text = listString;
	[zooRecordLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
	zooRecordLabel.textColor = [UIColor blackColor];
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	
	[zooRecordLabel setFrame:[self zooRecordLabelFrame]];
}

-(CGRect)zooRecordLabelFrame 
{
	return CGRectMake(0.f, 0.f, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
}

-(void)dealloc
{
	[zooRecordLabel release];
	
	[super dealloc];
}

@end
