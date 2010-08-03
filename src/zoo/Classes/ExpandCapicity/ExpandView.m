//
//  ExpandView.m
//  ExpandView
//
//  Created by Hunk on 10-8-2.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import "ExpandView.h"
#import "DataModelFarmerInfo.h"
#import "DataModelFarmInfo.h"
#import "DataEnvironment.h"
#import "ModelLocator.h"
#import "ServiceHelper.h"
#import "FeedbackDialog.h"

@implementation ExpandView
@synthesize m_labelCurCapacity;
@synthesize m_labelCurLevel;
@synthesize m_labelCurGoldenEggs;
@synthesize m_labelExpandNeedLevel;
@synthesize m_labelExpandNeedGoldenEggs;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor clearColor];
	
	
	
//	m_labelCurCapacity.text = @"6";
//	
//	m_labelCurLevel.text = @"5";
//	
//	m_labelCurGoldenEggs.text = @"564788";
//	
//	m_labelExpandNeedLevel.text = @"45";
//	
//	m_labelExpandNeedGoldenEggs.text = @"5000000";
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -
#pragma mark buttonSure
-(IBAction)buttonSure:(id)sender
{
	NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",nil];
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestexpansionFarm WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackFarmExpand:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallbackFarmExpand:(NSObject *)value
{	
	NSDictionary* dic = (NSDictionary*)value;
 	NSInteger code = [[dic objectForKey:@"code"] intValue];
	
	NSLog(@"%@\n", dic);
	
	switch (code) 
	{
		case 0:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"农场不存在"];
			break;
		case 1:
		{
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"扩容成功！"];
			
			// Add by Hunk on 2010-07-12
			//			NSInteger goldenEgg = [[dic objectForKey:@"goldenEgg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"goldenEgg"] intValue];
			//			
			//			((DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo).goldenEgg += goldenEgg;
			//			
			//			[[GameMainScene sharedGameMainScene] updateUserInfo];
		}
			break;
		case 2:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"金蛋余额不足！"];
			break;
		case 3:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"级别不够！"];
			break;
		case 4:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"扩容失败！"];
			break;
		case 5:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"级别不足！"];
			break;
		case 6:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"蚂蚁余额不足！"];
			break;		
		case 7:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"上一次操作正在进行！"];
			break;
		default:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作出现异常"];
			break;
			
	}
	NSLog(@"操作已成功!");
	
	[self.view removeFromSuperview];
}


#pragma mark -
#pragma mark buttonCancel
-(IBAction)buttonCancel:(id)sender
{
	[self.view removeFromSuperview];
}


- (void)dealloc {
    [super dealloc];
}


@end
