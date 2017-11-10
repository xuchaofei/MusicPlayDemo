//
//  MusicTableViewController.m
//  Practice
//
//  Created by csm on 2017/10/9.
//  Copyright © 2017年 YiJu. All rights reserved.
//

#import "MusicTableViewController.h"
#import "MusicCell.h"
#import <AVFoundation/AVFoundation.h>
@interface MusicTableViewController ()<UITableViewDelegate,UITableViewDataSource,AVPlayerItemOutputPullDelegate>{
    NSArray * _musicArray;
    AVPlayer * avplaer;
}

@end

@implementation MusicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)setAVPlayerWith:(NSInteger )indexPath{
    _musicArray = @[@"1769036407_672038_h",@"小幸运",@"endstudy"];
    
    NSString * pathStr = [[NSBundle mainBundle] pathForResource:_musicArray[indexPath] ofType:@"mp3"];
    
    AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:[NSURL fileURLWithPath:pathStr]];
    if (!avplaer) {
        avplaer = [[AVPlayer alloc]initWithPlayerItem:item];
    }else{
        NSString * pathString = [[NSBundle mainBundle]pathForResource:_musicArray[indexPath] ofType:@"mp3"];
        AVPlayerItem * playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL fileURLWithPath:pathString]];
        [avplaer replaceCurrentItemWithPlayerItem:playerItem];
    }
    
    [avplaer play];
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MusicCell * cell = [MusicCell cellWithTableView:tableView];
    
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor redColor];
    }else if (indexPath.row == 1){
        cell.backgroundColor = [UIColor blueColor];
    }else{
        cell.backgroundColor = [UIColor greenColor];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self setAVPlayerWith:indexPath.row];

}



@end
