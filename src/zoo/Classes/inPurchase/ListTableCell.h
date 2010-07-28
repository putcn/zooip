//
//  ListTableCell.h
//  tableList
//
//  Created by shen lancy on 10-7-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListTableCell : UITableViewCell {

	//显示
	UIImageView *backgroundImageView;
    UIImageView *showImageView;
    UILabel *purchaseLabel;
}

- (void)creatList:(NSString*)showString;

@end
