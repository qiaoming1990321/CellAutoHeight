//
//  TableViewController.m
//  CellAutoHeight
//
//  Created by lanouhn on 15-1-21.
//  Copyright (c) 2015年 qiaoming. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"
#import "ViewController.h"

static NSString *ID = @"cell";
@interface TableViewController ()
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, retain) CustomCell *cell;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.array = @[@[@"最近", @"一段",@"咏春高手",@"大战散打冠",@"军",@"搏击擂"],@[@"台赛视频在",@"各大门户网站疯传"],@[@"点击"],@[@"量高达2000多万次",@"该段视频之所以被疯传",@"主要卖点为",@"咏春高手杨成章遭散打",@"冠军曹"],@[@"亚光暴打",@"肋骨被",@"踢断",@"当场",@"送医",@"视频中的"],@[@"比赛是海"],@[@"南省",@"武",@"术",@"协会副秘",@"书长",@"杨成章",@"对阵",@"世界",@"散打",@"冠军"],@[@"正确的选项它会紧张",@"曹亚光",@"我睡着了",@"曹亚光"],@[@"高三的同桌",@"你要相信",@"曹",@"傻"],@[@"乎乎的",@"其实我还有一个同胞妹妹",@"我告诉她"],@[@"家里穷",@"曹亚光曹"],@[@"供不起两个人",@"我们一人读一天"],@[@"第二天",@"她神秘的对我说",@"你姐"],@[@"已经把",@"你们的事都告诉我了",@"只要放空你的大脑"],@[@"用你的灵魂去思考",@"沉下心来",@"你是能听见它的心跳的然后我试了一下"],@[@"只盯着每一个选项光",@"把头埋在卷子上",@"不要想别的事"]];
    
    //注册
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _array.count;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    for (UIButton *button in self.cell.contentView.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            [button removeFromSuperview];
        }
    }
    [_cell resetFrame:_array[indexPath.row]];
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cell resetWidth:_array[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
