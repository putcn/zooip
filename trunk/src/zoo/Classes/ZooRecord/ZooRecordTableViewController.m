    //
//  ZooRecordTableViewController.m
//  zoo
//
//  Created by Hunk on 10-7-30.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import "ZooRecordTableViewController.h"
#import "ZooRecordTableCell.h"

@implementation ZooRecordTableViewController
@synthesize m_arrayZooRecord;
@synthesize closeButton;
@synthesize m_strBgImageName;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	if(nil != self.m_strBgImageName)
	{
		UIImageView* m_BgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:m_strBgImageName]];
		[m_BgImageView setFrame:CGRectMake(70, 50, m_BgImageView.bounds.size.width, m_BgImageView.bounds.size.height)];
		[self.view addSubview:m_BgImageView];
		[self.view sendSubviewToBack:m_BgImageView];
	}
	
	self.view.backgroundColor = [UIColor clearColor];
	zooRecordTableView.backgroundColor = [UIColor clearColor];
	zooRecordTableView.separatorColor = [UIColor clearColor];
	zooRecordTableView.rowHeight = 30;
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark UITableView touch events
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark -
#pragma mark Table length
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [m_arrayZooRecord count];
}

#pragma mark -
#pragma mark Table cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ZooRecordTableCell* recordCell = (ZooRecordTableCell*)[tableView dequeueReusableCellWithIdentifier:@"RecordCellIdentifier"];
	
	recordCell = [[[ZooRecordTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecordCellIdentifier"] autorelease];
	recordCell.accessoryType = UITableViewCellAccessoryNone;
	recordCell.selectionStyle = UITableViewCellSelectionStyleNone;	
    
	[recordCell creatTableList:[m_arrayZooRecord objectAtIndex:[indexPath row]]];
	
	return recordCell;
}

#pragma mark -
#pragma mark Close zoo record
-(IBAction)closeZooRecord:(id)sender
{
	[self.view removeFromSuperview];
}

- (void)dealloc 
{
	[m_arrayZooRecord release];
	
    [super dealloc];
}


@end
