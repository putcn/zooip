//
//  SecPopViewController.m
//  zoo
//
//  Created by shen lancy on 10-8-2.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SecPopViewController.h"
#import "Common.h"
#import "DataEnvironment.h"
#import "ServiceHelper.h"
#import "FeedbackDialog.h"
#import "ItemInfoPane.h"
#import "GameMainScene.h"

#import "DataModelOriginalAnimal.h"
#import "DataModelAnimal.h"


@implementation SecPopViewController

@synthesize m_npopViewType, m_ntabFlag, itemId, labelString;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		showImage = [UIImageView alloc];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[labelString release];
	labelString = nil;
	[myLabel release];
	myLabel = nil;
	
    [super dealloc];
}

- (IBAction) OKSelected:(id)sender{
	
	NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
//	NSMutableArray *animalIDs = (NSMutableArray *)[DataEnvironment sharedDataEnvironment].animalIDs;
//	NSString* aniID = [animalIDs objectAtIndex:itemId];
//	DataModelOriginalAnimal *serverAnimalData2 = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:aniID];
//	NSString* buyAniId = serverAnimalData2.originalAnimalId;
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							farmerId,							@"farmerId",
							[NSString stringWithFormat:@"%d",itemId],@"originalAnimalId",
							[NSString stringWithFormat:@"%d",1],@"amount",
							nil];
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyAnimalByGoldenEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	
	
	[self.view removeFromSuperview];
}

- (IBAction) CancelSelected:(id)sender{
	
	[self.view removeFromSuperview];
}

- (void) setShowImageName:(NSString*)fileName{
	
	[showImage setImage:[UIImage imageNamed:fileName]];
}


-(void) resultCallback:(NSObject *)value
{
/*	NSDictionary *itemDic;
	NSArray *itemArray;
	switch (m_ntabFlag) {
		case SHOP_POPVIEW:{
			
			itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
			itemArray = [itemDic allKeys];
		}
			break;
		default:
			break;
	}
*/
	
//	ItemInfoPane *itemInfo = (ItemInfoPane *)button.target; 
//	int tempPrice  = itemInfo.itemPrice;
	
	NSDictionary* dic = (NSDictionary*)value;
 	NSInteger code = [[dic objectForKey:@"code"] intValue];
	switch (code) {
		case 0:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"无道具信息!"];
			break;
		case 1:
		{
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"恭喜你购买物品成功!"];
//			if(curr_itemType == @"ant")
//			{
//				((DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo).antsCurrency -= tempPrice * tempCount;
//			}
//			else {
//				((DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo).goldenEgg -= tempPrice * tempCount;
//			}
			[[GameMainScene sharedGameMainScene] updateUserInfo];
		}
			break;
		case 2:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"余额不足!"];
			break;
		case 3:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作正在进行，不能短时间连续购买!"];
			break;
		case 4:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不能再买了!"];
			break;
		default:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作失败"];
			break;
	}
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

@end
