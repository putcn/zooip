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

@synthesize m_npopViewType, m_ntabFlag, itemId, curr_itemType, tempCount,labelString;


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
	[farmerId release];
	farmerId = nil;
	
	[showImage release];
	showImage = nil;
	[iconImage release];
	iconImage = nil;
	[priceLabel release];
	priceLabel = nil;
	[nameLabel release];
	nameLabel = nil;
	[describeLabel release];
	describeLabel = nil;
	[buySlider release];
	buySlider =nil;
	[countLabel release];
	countLabel = nil;
	
    [super dealloc];
}

// slown down or speed up the slide show as the slider is moved
- (IBAction)sliderAction:(id)sender
{
	UISlider* durationSlider = sender;
//	self.imageView.animationDuration = [durationSlider value];
//	if (!self.imageView.isAnimating)
//		[self.imageView startAnimating];
}

- (IBAction) OKSelected:(id)sender{
	
	switch (m_ntabFlag) {
		case BUY_ANIMAL:{
			
			//用蚂蚁购买
			if (tempPrice > 0) {
				
				NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
										farmerId,									@"farmerId",
										[NSString stringWithFormat:@"%d",buyAniId], @"originalAnimalId",
										[NSString stringWithFormat:@"%d",tempCount],@"amount",
										nil];
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyAnimalByAnts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			}
			//用金币购买
			else {
				
				NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
										farmerId,									@"farmerId",
										[NSString stringWithFormat:@"%d",buyAniId], @"originalAnimalId",
										[NSString stringWithFormat:@"%d",tempCount],@"amount",
										nil];
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyAnimalByGoldenEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];		
			}
		}
			break;
			
		case SALE_ANIMAL:{
			
		}
				break;

		default:
			break;
	}
	


	[self.view removeFromSuperview];
}

- (IBAction) CancelSelected:(id)sender{
	
	[self.view removeFromSuperview];
}

- (void) setShowImageName:(NSString*)fileName{
	
	[showImage setImage:[UIImage imageNamed:fileName]];
	
	[DataEnvironment sharedDataEnvironment].playerFarmerInfo.antsCurrency;
	
	//get data
	farmerId = [[NSString alloc] initWithString: [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId];
	NSDictionary *originAnimalDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
	DataModelOriginalAnimal *originAnimal; 
	NSArray *animalArrayTemp = [originAnimalDic allKeys];
	originAnimal = [originAnimalDic objectForKey:[animalArrayTemp objectAtIndex:itemId]];
	
	buyAniId = originAnimal.originalAnimalId;
	tempCount = 1;
	tempPrice = originAnimal.antsPrice;
	
	NSString* describeString = @"   性别：";
	int income = 0;
	
	//show
	if (tempPrice == 0) {
		[iconImage setImage:[UIImage imageNamed:@"金蛋.png"]];
		int basePrice = originAnimal.basePrice;
		priceLabel.text = [NSString stringWithFormat:@"%d", basePrice];
		describeString = [describeString stringByAppendingString:@"母\n   价格："];
		describeString = [describeString stringByAppendingString:priceLabel.text];
		describeString = [describeString stringByAppendingString:@"个金蛋"];
		describeString = [describeString stringByAppendingString:@"\n总收益："];
	}else {
		[iconImage setImage:[UIImage imageNamed:@"金蚂蚁.png"]];
		priceLabel.text = [NSString stringWithFormat:@"%d", tempPrice];
		describeString = [describeString stringByAppendingString:@"公\n   价格："];
		describeString = [describeString stringByAppendingString:priceLabel.text];
		describeString = [describeString stringByAppendingString:@"个蚂蚁币"];
		describeString = [describeString stringByAppendingString:@"\n总收益："];
	}
	
	nameLabel.text = originAnimal.scientificNameCN;
	
	describeString = [describeString stringByAppendingString:[NSString stringWithFormat:@"%d", income]];
	describeString = [describeString stringByAppendingString:@"个金蛋"];
	describeLabel.numberOfLines = 3;
	describeLabel.text = describeString;
	
}


-(void) resultCallback:(NSObject *)value
{
	
	switch (m_ntabFlag) {
		case BUY_ANIMAL:{
			
			NSDictionary* dic = (NSDictionary*)value;
			NSInteger code = [[dic objectForKey:@"code"] intValue];
			switch (code) {
				case 0:
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"无道具信息!"];
					break;
				case 1:
				{
					[[FeedbackDialog sharedFeedbackDialog] addMessage:@"恭喜你购买物品成功!"];
					
					if (tempPrice > 0) 
						((DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo).goldenEgg -= tempPrice * tempCount;
					else
						((DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo).antsCurrency -= tempPrice * tempCount;
	
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
			break;
			
		case SALE_ANIMAL:{
				
		}
				break;
			
		default:
			break;
	}
	
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

@end
