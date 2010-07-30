//
//  ZooRecordTableViewController.h
//  zoo
//
//  Created by Hunk on 10-7-30.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZooRecordTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UITableView* zooRecordTableView;
	
	NSArray* m_arrayZooRecord;
	
	IBOutlet UIButton* closeButton;
	
	NSString* m_strBgImageName;
}
@property(nonatomic, retain)NSArray* m_arrayZooRecord;
@property(nonatomic, retain)UIButton* closeButton;
@property(nonatomic, retain)NSString* m_strBgImageName;

-(IBAction)closeZooRecord:(id)sender;

@end
