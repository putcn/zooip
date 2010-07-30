//
//  ZooRecordTableCell.h
//  zoo
//
//  Created by Hunk on 10-7-30.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZooRecordTableCell : UITableViewCell
{
	UILabel* zooRecordLabel;
}
@property(nonatomic, retain)UILabel* zooRecordLabel;

-(void)creatTableList:(NSString*)listString;

@end
