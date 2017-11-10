//
//  NetMusicTableViewController.m
//  Practice
//
//  Created by csm on 2017/10/9.
//  Copyright © 2017年 YiJu. All rights reserved.
//

#import "NetMusicTableViewController.h"
#import "MusicCell.h"
#import <AVFoundation/AVFoundation.h>

#define PYTHEME_COLOR(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define PYTHEME_RANDOM_COLOR  PYTHEME_COLOR(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

@interface NetMusicTableViewController (){
    AVPlayer * player;
    NSInteger _currentSong;
    NSArray * _musicArray;
}

@end

@implementation NetMusicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton * nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(100, 500, 100, 100);
    [nextButton setTitle:@"下一首" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextSong) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MusicCell * cell = [MusicCell cellWithTableView:tableView];
    
    cell.backgroundColor = PYTHEME_RANDOM_COLOR;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
    _currentSong = indexPath.row;
    
    NSString * musicSre = [[NSBundle mainBundle]pathForResource:@"music" ofType:@"json"];
    NSData * data = [NSData dataWithContentsOfFile:musicSre];
    
    _musicArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary * musicInfoDic = _musicArray[indexPath.row];
     AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:musicInfoDic[@"url"]]];
    
    if (player) {
        [player replaceCurrentItemWithPlayerItem:item];
    }else{
        
       
        player = [[AVPlayer alloc]initWithPlayerItem:item];
        
        [player play];
    }
}

-(void)nextSong{
    NSInteger nextSong = _currentSong+1;
    if (nextSong > 7) {
        nextSong = 0;
    }
    NSDictionary * musicDic = _musicArray[_currentSong+1];
    
    AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:musicDic[@"url"]]];
    [player replaceCurrentItemWithPlayerItem:item];

}


@end
