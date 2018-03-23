//
//  TestView.m
//  NativeUIComponentProject
//
//  Created by Mr.GCY on 2018/3/23.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "TestView.h"
#import "CYTestCell.h"
/*
 static NSString const * LMJName = @"iOS开发者公会";
 static const NSString * LMJName = @"iOS开发者公会";
 这两种写法cons修饰的是* LMJName，*是指针指向符，也就是说此时指向内存地址是不可变的，而内存保存的内容时可变的。
 所以我们应该这样写：
 
 static NSString * const LMJName = @"iOS开发者公会";
 当我们定义一个对象类型常量的时候，要将const修饰符放到*指针指向符后面。
 */
static NSString const * TestCellIdentifier = @"CYTestCell";

@interface TestView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataSources;
@end
@implementation TestView
-(instancetype)init{
  if ([super init] == self) {
    [self setupSubviews];
  }
  return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
  if ([super initWithFrame:frame] == self) {
    [self setupSubviews];
  }
  return self;
}
-(void)layoutSubviews{
  //刷新布局
  self.tableView.frame = self.bounds;
}
-(void)setDataArray:(NSArray *)dataArray{
  _dataArray = dataArray;
  [self.dataSources removeAllObjects];
  [self.dataSources addObjectsFromArray:dataArray];
  [self.tableView reloadData];
}
-(NSMutableArray *)dataSources{
  if (!_dataSources) {
    _dataSources = [[NSMutableArray alloc] initWithCapacity:0];
  }
  return _dataSources;
}
//懒加载数据
-(UITableView *)tableView{
  if (!_tableView) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:TestCellIdentifier bundle:nil] forCellReuseIdentifier:TestCellIdentifier];
    _tableView.tableFooterView = [UIView new];
  }
  return _tableView;
}
//初始化视图
-(void)setupSubviews{
  [self addSubview:self.tableView];
}

//没有返回值
-(void)notCallBackValueMethod{
  NSLog(@"~~~~~~~~原生方法：没有返回值");
}
//有返回值的函数
-(NSString *)haveCallBackValueMethod{
  NSLog(@"~~~~~~~~原生方法：有返回值");
  return @"---------调用组件返回值：有返回值";
}

-(void)clickBtnEvent{
  NSLog(@"打印数据");
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  CYTestCell * cell = [tableView dequeueReusableCellWithIdentifier:TestCellIdentifier];
  cell.titleLabel.text = self.dataSources[indexPath.row];
  return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  if (self.onClickEvent) {
    self.onClickEvent(@{@"content" : self.dataSources[indexPath.row],@"index" : @(indexPath.row)});
  }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return 50;
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return self.isEdit;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
  return @"删除";
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    [self.dataSources removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
}
@end
