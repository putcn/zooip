//
//  MyTableView.m
//  zoo
//
//  Created by Hunk on 10-7-30.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import "MyTableView.h"

@implementation MyTableView

static MyTableView* _sharedMyTableView = nil;

+(MyTableView*)sharedMyTableView
{
	@synchronized([MyTableView class])
	{
		if(!_sharedMyTableView)
		{
			_sharedMyTableView = [[MyTableView alloc]init];
		}
		return _sharedMyTableView;
	}
	return nil;
}

-(void)awakeZooRecordTable:(NSArray*)tableMsgArray bgImgName:(NSString*)bgImgName
{
	NSArray* arrZooRecord;
	if(0 == [tableMsgArray count])
	{
		arrZooRecord = [NSArray arrayWithObject:@"暂无消息记录!"];
	}
	else
	{
		arrZooRecord = [NSArray arrayWithArray:tableMsgArray];
	}
	
	if(nil == zooRecordTableView)
	{
		zooRecordTableView = [[ZooRecordTableViewController alloc]initWithNibName:@"ZooRecordTableViewController" bundle:nil];
	}
	[zooRecordTableView setM_strBgImageName:bgImgName];
	[zooRecordTableView setM_arrayZooRecord:arrZooRecord];
	
	[[[UIApplication sharedApplication]keyWindow] addSubview:zooRecordTableView.view];
	
}

-(void)dealloc
{
	[super dealloc];
}

@end
