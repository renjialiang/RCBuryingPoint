//
//  ViewController.h
//  RCBuryingPoint
//
//  Created by lichen on 2017/4/26.
//  Copyright © 2017年 RenJialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *table;

@property (nonatomic, weak) IBOutlet UICollectionView *collection;

@property (nonatomic, weak) IBOutlet UIButton *btn1;

@property (nonatomic, weak) IBOutlet UIButton *btn2;

- (IBAction)saveDetailText:(id)sender;

- (IBAction)btnSendMessage:(id)sender;
@end

