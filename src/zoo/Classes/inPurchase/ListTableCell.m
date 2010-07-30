//
//  ListTableCell.m
//  tableList
//
//  Created by shen lancy on 10-7-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ListTableCell.h"

#pragma mark -
#pragma mark SubviewFrames category

@interface ListTableCell (SubviewFrames)
- (CGRect)_backgroundViewFrame;
- (CGRect)_imageViewFrame;
- (CGRect)_purchaseLabelFrame;
@end

@implementation ListTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		backgroundImageView.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:backgroundImageView];
		
        showImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		showImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:showImageView];
		
        purchaseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [purchaseLabel setFont:[UIFont systemFontOfSize:14.0]];
        [purchaseLabel setTextColor:[UIColor darkGrayColor]];
        [purchaseLabel setHighlightedTextColor:[UIColor whiteColor]];
		[purchaseLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:purchaseLabel];
    }
	
    return self;
}

#pragma mark -
#pragma mark Laying out subviews

/*
 To save space, the prep time label disappears during editing.
 */
- (void)layoutSubviews {
    [super layoutSubviews];
	
	[backgroundImageView setFrame:[self _backgroundViewFrame]];
    [showImageView setFrame:[self _imageViewFrame]];
    [purchaseLabel setFrame:[self _purchaseLabelFrame]];
}


#define IMAGE_SIZE          40.0
#define EDITING_INSET       10.0
#define TEXT_LEFT_MARGIN    20.0
#define TEXT_RIGHT_MARGIN   10.0
#define PREP_TIME_WIDTH     10.0

/*
 Return the frame of the various subviews -- these are dependent on the editing state of the cell.
 */
- (CGRect)_backgroundViewFrame {
	return CGRectMake(10.0, 5.0, 460, 50);
}

- (CGRect)_imageViewFrame {
    return CGRectMake(10.0, 5.0, IMAGE_SIZE, IMAGE_SIZE);
}

- (CGRect)_purchaseLabelFrame {
	return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 20.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_RIGHT_MARGIN - PREP_TIME_WIDTH, 16.0);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)creatList:(NSString*)showString{
	
	//购买图像显示
	[backgroundImageView setImage:[UIImage imageNamed:@"bg.png"]];
	[showImageView setImage:[UIImage imageNamed:@"goldant.png"]];
	
	//购买咨询显示
	purchaseLabel.text = showString;	
}

- (void)dealloc {
	[backgroundImageView release];
	[showImageView release];
	[purchaseLabel release];
	
    [super dealloc];
}


@end
