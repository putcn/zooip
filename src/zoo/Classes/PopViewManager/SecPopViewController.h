//
//  SecPopViewController.h
//  zoo
//
//  Created by shen lancy on 10-8-2.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecPopViewController : UIViewController {

	int					m_npopViewType;
	int					m_ntabFlag;
	
	int					buyAniId;
	int					itemId;
	int					tempPrice;
	int					tempCount;
	int					curr_itemType;
	int					mixCount;
	
	NSString*			labelString;
	NSString*			farmerId;
	
	IBOutlet UIImageView*	showImage;
	IBOutlet UIImageView*	iconImage;
	IBOutlet UILabel*		priceLabel;
	IBOutlet UILabel*		nameLabel;
	IBOutlet UILabel*		describeLabel;
	IBOutlet UISlider*		buySlider;
	IBOutlet UILabel*		countLabel;
	IBOutlet UILabel*		wrongLabel;
}

@property(nonatomic, readwrite) int m_npopViewType;
@property(nonatomic, readwrite) int m_ntabFlag;
@property(nonatomic, readwrite) int itemId;
@property(nonatomic, readwrite) int tempCount;
@property(nonatomic, readwrite) int curr_itemType;

@property(nonatomic, retain) NSString* labelString;

- (IBAction) OKSelected:(id)sender;
- (IBAction) CancelSelected:(id)sender;
- (IBAction) sliderAction:(id)sender;

- (void) setShowImageName:(NSString*)fileName;
- (void) resultCallback:(NSObject *)value;
- (void) faultCallback:(NSObject *)value;

@end
