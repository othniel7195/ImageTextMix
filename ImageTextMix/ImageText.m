//
//  ViewController.m
//  ImageTextMix
//
//  Created by 赵锋 on 15/6/8.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "ImageText.h"

@interface ImageText ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ImageText

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.messagesList.hidden=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark  --tableView 的代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
@end
