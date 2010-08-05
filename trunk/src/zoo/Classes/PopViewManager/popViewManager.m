//
//  popViewManager.m
//  zoo
//
//  Created by shen lancy on 10-7-30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "popViewManager.h"

//static popViewManager *sharedPopView = nil;

@interface popViewManager (SubviewFrames)
- (void) addTitleButtons:(NSArray *)arrayPic;
- (void) selectButtonAtIndex:(NSUInteger)index;
- (void) topBtnSelected:(id)sender;
- (void) backBtnSelected:(id)sender;
@end

@implementation popViewManager

//@synthesize delegate;
@synthesize m_npopViewType, m_nlistCount;
@synthesize buyTypeArray, priceArray, sexArray;

- (id)init{

	if ( (self = [super init]) ) {
		serviceInstance = [ServiceHelper sharedService];
		picFileNameArray = [[NSMutableArray alloc] init];
		topBtnArray = [[NSMutableArray alloc] init];
		m_nlistCount = 1;
		secPopView = [[SecPopViewController alloc] initWithNibName:@"SecPopViewController" bundle:nil];
		
		[self.view setFrame:CGRectMake(0.f,0.f,320.f,480.f)];
		[self.view setBackgroundColor:[UIColor clearColor]];
		UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		img.backgroundColor = [UIColor blackColor];
		img.alpha = 0.5;
		[self.view addSubview:img];
		[img release];
		img = nil;
		
		UIImageView* backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(80, 100, 320, 200)];
		[backgroundImage setImage:[UIImage imageNamed:@"BG_buy.png"]];
		[self.view addSubview:backgroundImage];
		[backgroundImage release];
		backgroundImage = nil;
		
		UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 		[backBtn setImage:[UIImage imageNamed: @"exitButton.png"] forState:UIControlStateNormal];
		backBtn.frame = CGRectMake(376, 276, 30, 30);
		[backBtn addTarget:self action:@selector(backBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:backBtn];
	}
	return self;
}

- (void)dealloc{
	
	[m_ppopView release];
	m_ppopView = nil;
	[picFileNameArray release];
	picFileNameArray = nil;
	[topBtnArray release];
	topBtnArray = nil;
	[secPopView release];
	secPopView = nil;
	
	[buyTypeArray release];
	buyTypeArray = nil;
	[priceArray release];
	priceArray = nil;
	[sexArray release];
	sexArray = nil;
	
	[super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{	
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


#pragma mark -
#pragma mark Laying out subviews

- (void)addView2Window{
	
	[[[UIApplication sharedApplication]keyWindow] addSubview:self.view];
}

- (void)setPopViewFrame:(CGRect)myFrame{
	
	m_ppopView = [[UIScrollView alloc] initWithFrame:myFrame];
}

#define		INTERVAL_PIX  30.0

- (void) setSubSize:(CGSize)size{
	
	subSize = size;
}

- (void) initWithItem:(NSArray*)arrayPic{
	
	
	m_nprevButtonIndex = -1;
	[picFileNameArray addObjectsFromArray:arrayPic];
	
	m_ppopView.userInteractionEnabled = YES;
	m_ppopView.scrollEnabled = YES;
	m_nrowCount = [arrayPic count]/m_nlistCount;
	if ([arrayPic count]%m_nlistCount != 0) {
		m_nrowCount++;
	}
	[m_ppopView setContentSize:CGSizeMake(subSize.width*m_nrowCount + INTERVAL_PIX*(m_nrowCount+1), m_ppopView.frame.size.height)];
	[m_ppopView setBackgroundColor:[UIColor clearColor]];
	m_ppopView.alpha = 1;
	[m_ppopView setShowsHorizontalScrollIndicator:NO];
	[m_ppopView setShowsVerticalScrollIndicator:NO];
	[self.view addSubview:m_ppopView];

	[self addTitleButtons:arrayPic];
}


- (void) addTitleButtons:(NSArray *)arrayPic{
	
	UIButton *btn;	
	for (int i = 0; i < [arrayPic count]; i++) {
		
		//show position
		float row = i/m_nlistCount;
		float list = i%m_nlistCount;
		float rowinterval = subSize.width*row + INTERVAL_PIX*(row + 1);
		float listinterval = subSize.height*list + INTERVAL_PIX*(list + 1);
		
		//background
		UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"边框.png"]];
		img.frame = CGRectMake(rowinterval-10, listinterval-5, subSize.width+20, subSize.height+20);
		[m_ppopView addSubview:img];
		[img release];
		img = nil;
		
		switch (m_npopViewType) {
			case SHOP_POPVIEW:{
			
				//icon
				UIImageView* buyImg = [[UIImageView alloc] init];
				int buyType = [[buyTypeArray objectAtIndex:i] intValue];
				if (buyType == 0) {
					[buyImg setImage:[UIImage imageNamed:@"金蛋ico.png"]];
					buyImg.frame = CGRectMake(rowinterval, listinterval+40, 7, 10);
				}else {
					[buyImg setImage:[UIImage imageNamed:@"蚂蚁ICO.png"]];
					buyImg.frame = CGRectMake(rowinterval, listinterval+40, 10, 10);
				}
				[m_ppopView addSubview:buyImg];
				[buyImg release];
				buyImg = nil;

				//label
				UILabel* showLabel = [[UILabel alloc] init];
				showLabel.text = [priceArray objectAtIndex:i];
				showLabel.frame = CGRectMake(rowinterval+12, listinterval+42, 40, 10);
				showLabel.backgroundColor = [UIColor clearColor];
				showLabel.font = [UIFont fontWithName:@"Arial" size:12];
				[m_ppopView addSubview:showLabel];
				[showLabel release];
				showLabel = nil;
				
			}
				break;
			default:
				break;
		}
		
		//button
		btn = [UIButton buttonWithType:UIButtonTypeCustom];
		UIImage* showImage = [UIImage imageNamed: [arrayPic objectAtIndex:i]];
		CGImageRef imgRef =showImage.CGImage;
		CGFloat _width = subSize.width;
		CGFloat _height = subSize.height;
		
		btn.frame = CGRectMake(rowinterval, listinterval, _width, _height);
		
		if ([[buyTypeArray objectAtIndex:i] intValue] == 0) {
			[btn setImage:showImage forState:UIControlStateNormal];
		}
		//图片翻转
		else {
			
			CGAffineTransform transform = CGAffineTransformIdentity;
			CGRect bounds = CGRectMake(0, 0, _width, _height);
			
			transform = CGAffineTransformMakeTranslation(0.0, _height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			
			UIGraphicsBeginImageContext(bounds.size);
			
			CGFloat scaleRatio = bounds.size.width / _width;
			CGFloat scaleRatioheight = bounds.size.height / _height;
			
			CGContextRef context = UIGraphicsGetCurrentContext();
			CGContextScaleCTM(context, -scaleRatio, scaleRatioheight);
			CGContextTranslateCTM(context, -_height, 0);
			CGContextConcatCTM(context, transform);
			
			CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, _width, _height), imgRef);
			UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
			UIGraphicsEndImageContext();
			
			[btn setImage:imageCopy forState:UIControlStateNormal];
		}
		
		[btn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
		btn.tag = i;
		[m_ppopView addSubview:btn];
	}
	
	// Select the first button
	[self selectButtonAtIndex:0];
}

- (void)selectButtonAtIndex:(NSUInteger)index{
	
//	UIButton *selectedBtn = [[m_ppopView subviews] objectAtIndex:index];
	
//	UIImage* btnImg = [UIImage imageNamed:@"动物结婚.png"];//TOP_SELECT];
//	UIImage* btnStretchImg = [btnImg stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	
//	[selectedBtn setBackgroundImage:btnStretchImg forState:UIControlStateNormal];
//	[selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];s

	prevButtonIndex = index;
}

- (void)deselectButtonAtIndex:(NSUInteger)prevIndex{
	
//	UIButton *deselectedBtn = [[m_ppopView subviews] objectAtIndex:prevIndex];
//	[deselectedBtn setBackgroundImage:nil forState:UIControlStateNormal];
//	[deselectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	m_nprevButtonIndex = -1;
}

- (void)buttonSelected:(id)sender{
	
	UIButton *selectedBtn = (UIButton *)sender;
	NSUInteger index = selectedBtn.tag;
	
	if (index != prevButtonIndex) {
		[self deselectButtonAtIndex:prevButtonIndex];
		[self selectButtonAtIndex:index];
	}

	[secPopView setM_npopViewType:m_npopViewType];
	
	switch (m_npopViewType) {
		case SHOP_POPVIEW:{
		
			NSString* fileName = [picFileNameArray objectAtIndex:index];
			[secPopView setItemId:index];
			[self.view addSubview:secPopView.view];
			[secPopView setShowImageName:fileName];
		}
			break;
		default:
			break;
	}
}


- (void)initWithBtn:(NSArray *)arrayBtn{
	
	for (int i = 0; i < [arrayBtn count]; i++) {
		
		//show position
		UIButton* topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 		[topBtn setImage:[UIImage imageNamed: @"婚姻管理.png"] forState:UIControlStateNormal];
		CGRect btnFrame = [[arrayBtn objectAtIndex:i] CGRectValue];
		topBtn.frame = btnFrame;
		[topBtn addTarget:self action:@selector(topBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
		topBtn.tag = i;
		[self.view addSubview:topBtn];
	}
}

- (void) topBtnSelected:(id)sender{
	
}

- (void) backBtnSelected:(id)sender{
	
	[self.view removeFromSuperview];
}


@end
