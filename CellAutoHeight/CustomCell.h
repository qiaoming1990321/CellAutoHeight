//
//  CustomCell.h
//  CellAutoHeight
//
//  Created by lanouhn on 15-1-21.
//  Copyright (c) 2015年 qiaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

- (CGFloat)resetWidth:(NSArray *)array;
- (void)resetFrame:(NSArray *)array;

@end
