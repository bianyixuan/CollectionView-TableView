//
//  CollectionDemoViewController.m
//  Demo
//
//  Created by bianyixuan on 16/3/22.
//  Copyright © 2016年 jzsec-byx. All rights reserved.
//

#define CellNumber 3.f
#define KMargin 20.f
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width


#import "ViewController.h"
/**
 *  随机颜色
 */
#define YXRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


@interface ViewController()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    float width;
    float viewCount;
}
/**
 *  存放假数据
 */
@property (strong, nonatomic) NSMutableArray *fakeColors;

@property (nonatomic,strong) UITableView *mainTableView;


@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation ViewController


#pragma mark - life cycle

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self.view addSubview:self.mainTableView];
    
    viewCount = self.fakeColors.count / 3 + (self.fakeColors.count%3 ==0 ? 0 : 1) ;
    
    width = (kScreenWidth-KMargin*4)/CellNumber;
    
    self.mainTableView.tableHeaderView=self.collectionView;
}



#pragma mark - 数据源方法
/**
 *  第section组有多少个格子（cell）
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fakeColors.count;
}

//每个格子的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundColor=self.fakeColors[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击collectionView的item");
}

#pragma mark TbaleViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text=@"cell";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击tableview的item");
}

#pragma mark - CustomDelegate

#pragma mark - event response

#pragma mark - private methods

- (void)addFooter
{
    
}

- (void)setUp
{
    self.collectionView.bounces = NO;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.delegate = self;
}

#pragma mark - getters and setters

-(NSString *)title
{
    return @"UICollectionViewController Demo";
}

- (NSMutableArray *)fakeColors
{
    if (!_fakeColors) {
        self.fakeColors = [NSMutableArray array];
        
        for (int i = 0; i<5; i++) {
            // 添加随机色
            [self.fakeColors addObject:YXRandomColor];
        }
    }
    return _fakeColors;
}

-(UITableView *)mainTableView
{
    if (_mainTableView==nil) {
        _mainTableView=[[UITableView alloc] init];
        _mainTableView.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _mainTableView.dataSource=self;
        _mainTableView.delegate=self;
    }
    return _mainTableView;
}

-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,  (viewCount * width) + (viewCount+1)*KMargin) collectionViewLayout:[self layout]];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
    }
    return _collectionView;
}


/**
 *  初始化
 */
-(UICollectionViewFlowLayout *)layout
{
    // UICollectionViewFlowLayout的初始化（与刷新控件无关）
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenWidth-KMargin*4)/CellNumber, (kScreenWidth-KMargin*4)/CellNumber);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    return layout;
}

@end
