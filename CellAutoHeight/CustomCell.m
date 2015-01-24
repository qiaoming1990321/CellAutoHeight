//
//  CustomCell.m
//  CellAutoHeight
//
//  Created by lanouhn on 15-1-21.
//  Copyright (c) 2015年 qiaoming. All rights reserved.
//

#import "CustomCell.h"
#define MARGN 10

@interface CustomCell()
{
    CGFloat Y;
    CGFloat X;
}
@end
@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

//返回cell的总高度
- (CGFloat)resetWidth:(NSArray *)array
{
    X = MARGN;
    Y = MARGN;
    for (int i = 0; i < array.count; i++) {
        CGFloat W = [self resetSize:array[i]].width + 2 * MARGN;
        //判断是否换行
        if (X + W + MARGN > self.frame.size.width) {
            Y += 30 + MARGN;
            X = MARGN;
        }
        X += W + MARGN;
    }
    return Y + 30 + MARGN;
}

//重设cell内部子控件的frame
- (void)resetFrame:(NSArray *)array
{
    X = MARGN;
    Y = MARGN;
    for (int i = 0; i < array.count; i++) {
        CGFloat W = [self resetSize:array[i]].width + 20;
        //判断是否换行
        if (self.frame.size.width - X < W + MARGN) {
            Y += 30 + MARGN;
            X = MARGN;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(X, Y, W, 30);
        button.backgroundColor = [UIColor grayColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //字体大小要和调用的计算string宽度的字体大小一致
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:array[i] forState:UIControlStateNormal];
        X += W + MARGN;
        [self.contentView addSubview:button];
    }
}

//计算string的宽度
- (CGSize)resetSize:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 30) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
    return rect.size;
}

@end
