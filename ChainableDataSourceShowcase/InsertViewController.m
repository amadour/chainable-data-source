//
//  InsertViewController.m
//  ChainableDataSource
//
//  Created by Amadour Griffais on 22/09/2016.
//  Copyright 2016 Dashlane
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "InsertViewController.h"

#import <ChainableDataSource/ChainableDataSource.h>
#import "FruitCellDataSource.h"

@interface InsertViewController ()

@property (nonatomic, strong) id<CDSCellDataSource> cellDataSource;

@end

@implementation InsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    NSArray* fruits = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"fruits" withExtension:@"plist"]];
    
    CDSCellDataSource* bannerCDS = [CDSCellDataSource new];
    bannerCDS.cellIdentifierOverride = @"banner-cell",
    bannerCDS.dataSource = @[@"banner info"];
    
    FruitCellDataSource* fruitsCDS = [FruitCellDataSource new];
    fruitsCDS.dataSource = fruits;
    
    CDSInsert* insert = [CDSInsert transformFromDataSources:@[fruitsCDS, bannerCDS]];
    insert.insertionIndexPath = [NSIndexPath cds_indexPathForObject:2 inSection:0];
    
    self.cellDataSource = insert;
    
    self.tableView.dataSource = self.cellDataSource;
    self.tableView.delegate = self.cellDataSource;
    self.cellDataSource.cds_updateDelegate = self.tableView;
    
}

@end
