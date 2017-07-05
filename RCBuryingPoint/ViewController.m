//
//  ViewController.m
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import "ViewController.h"
#import "RCBPManager.h"
@interface ViewController () <RCBPManagerDelegate>

@end

@implementation ViewController
#pragma mark - RCBPManagerDelegate
- (void)maiDianManager:(RCBPManager *_Nonnull)mgr shouldPostMaiDian:(NSString *_Nullable)str
{
    NSLog(@"%@",str);
}


- (void)viewDidLoad
{
    [RCBPManager shareInstance].delegate = self;
    [[RCBPManager shareInstance] setConfigFile:@"detailPointText.json"];
}


- (void)viewWillAppear:(BOOL)animated
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //列距
    flowLayout.minimumInteritemSpacing = 5;
    //行距
    flowLayout.minimumLineSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.itemSize = CGSizeMake((self.collection.frame.size.width - (6 * 10)) / 5 , (self.collection.frame.size.height - 40) / 2);
    NSLog(@"%@",NSStringFromCGSize(flowLayout.itemSize));
    //初始化
    [self.collection setCollectionViewLayout:flowLayout];
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
}

-(void)btnSendMessage:(id)sender
{
    NSLog(@"%@",((UIButton *)sender).currentTitle);
}

- (void)saveDetailText:(id)sender
{
    NSLog(@"%@",((UIButton *)sender).currentTitle);
}



#pragma mark - UITableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bpCell = @"buryingPointCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bpCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bpCell];
    }
    cell.backgroundColor = [UIColor grayColor];
    cell.textLabel.text = @"RCTableViewCell";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"UITableViewCell-%ld-%ld", indexPath.section, indexPath.row);
}


#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor brownColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"UICollectionViewCell-%ld-%ld", indexPath.section, indexPath.row);
}



@end
