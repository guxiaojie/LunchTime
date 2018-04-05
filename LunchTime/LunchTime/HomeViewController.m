//
//  HomeViewController.m
//  LunchTime
//
//  Created by Guxiaojie on 04/04/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "HomeTableViewCell.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource> {

}
@property(nonatomic,strong) HomeViewModel *myHomeViewModel;
@property(nonatomic,strong) UITableView *myTableView;

@end

@implementation HomeViewController

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self initViewModel];
    [self bindViewModel];

    if (!_myTableView) {
        _myTableView =[[UITableView alloc] initWithFrame:CGRectMake(0,0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator=NO;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        [_myTableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HomeTableViewCell class])];
        _myTableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
//        _myTableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreData)];
        
        [_myTableView.mj_header beginRefreshing];
        [self.view addSubview:_myTableView];
        
        [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).with.offset(0);
            make.right.mas_equalTo(self.view.mas_right).with.offset(0);
            make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
            make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        }];
    }
    
    [self loadData];
}

//init
- (void)initViewModel {
    
    if (!self.myHomeViewModel) {
        self.myHomeViewModel = [[HomeViewModel alloc] init];
    }
    
    @weakify(self)
    [self.myHomeViewModel.fetchProductCommand.executing subscribeNext:^(NSNumber *executing) {
        DDLogError(@"command executing:%@", executing);
        if (!executing.boolValue) {
            @strongify(self)
            [self.myTableView.mj_header endRefreshing];
        }
    }];
    
    
    [self.myHomeViewModel.errors subscribeNext:^(NSError *error) {
        DDLogError(@"something error:%@", error);
        //TODO: 这里可以选择一种合适的方式将错误信息展示出来
    }];
}

//bind
- (void)bindViewModel {
    @weakify(self);
    [RACObserve(self.myHomeViewModel, items) subscribeNext:^(id x) {
        @strongify(self);
        [self.myTableView reloadData];
    }];
    
    [RACObserve(self.myHomeViewModel, title) subscribeNext:^(id x) {
        @strongify(self);
        self.title = self.myHomeViewModel.title;
    }];
    //没有更多数据时，隐藏table的footer
//    RAC(self.myTableView.mj_footer, hidden) = [self.myHomeViewModel.hasMoreData not];
}

//load data
-(void)loadData
{
    [self.myHomeViewModel.fetchProductCommand execute:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myHomeViewModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeTableViewCell class]) forIndexPath:indexPath];
    cell.viewModel = [self.myHomeViewModel itemViewModelForIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
