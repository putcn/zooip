//
//  MyTableView.h
//  zoo
//
//  Created by Hunk on 10-7-30.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZooRecordTableViewController.h"


@interface MyTableView : NSObject 
{
	ZooRecordTableViewController* zooRecordTableView;
}

+(MyTableView*)sharedMyTableView;

-(void)awakeZooRecordTable:(NSArray*)tableMsg bgImgName:(NSString*)bgImgName;

@end
