//
//  ViewController.m
//  Practice
//
//  Created by csm on 2017/10/9.
//  Copyright © 2017年 YiJu. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicTableViewController.h"
#import "NetMusicTableViewController.h"

@interface ViewController ()<AVAudioPlayerDelegate>{
    
    AVAudioPlayer * player;
    AVPlayer * avplayer;
}
@property (weak, nonatomic) IBOutlet UIButton *checkMusic;
@property (weak, nonatomic) IBOutlet UIButton *netMusic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSString * pathString = [[NSBundle mainBundle] pathForResource:@"小幸运" ofType:@"mp3"];
//    [self setAudioPlayerWith:pathString];
    
     NSString * urlStr = @"http://download.lingyongqian.cn//music//ForElise.mp3";
    
    [self setAVPlayerWith:urlStr];
    
    NSString * baikeStr = @"《驾驶培训学员意外伤害保险电子保险单》";
    CGFloat width = [baikeStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width;
    NSLog(@"------%f",width);
}

-(void)setAudioToolBox{
    
    NSBundle * bundle = [NSBundle mainBundle];
    NSString * path = [bundle pathForResource:@"endstudy" ofType:@"mp3"];
    NSURL * url = [NSURL URLWithString:path];
    
    SystemSoundID soundID = 0;
    // 将URL所在的音频文件注册为系统声音,soundID音频ID标示该音频
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    
    //播放音频
    AudioServicesPlaySystemSound(soundID);
    
    //播放系统震动
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    //声音销毁
    AudioServicesPlayAlertSoundWithCompletion(soundID, ^{
        NSLog(@"播放完成");
    });
    
}

-(void)setAudioPlayerWith:(NSString *)pathString{
    

    NSURL * url = [[NSURL alloc]initFileURLWithPath:pathString];
    
    //player必须为全局的对象,不然播放不出来
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    player.delegate = self;
    player.volume = 0.9;
    player.currentTime = 2.0;
    [player prepareToPlay];
 
   // 如果想设置播放速率  必须得先开启允许设置
    
//    player.enableRate = YES;
//    player.rate = 10;
    
    if ([player play]) {
        NSLog(@"音乐正在播放");

        NSLog(@"duration:%f",player.duration);
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [player pause];

}
#pragma mark -- AVAudioPlayerDelegate
//此方法只有在成功播放完成的时候才调用
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{

    NSString * retainCount = [player valueForKey:@"retainCount"];
    NSLog(@"---%@",retainCount);
    
    
}

-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    
    NSLog(@"解码错误");
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    
    [player pause];
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
    
    
}

-(void)setAVPlayerWith:(NSString *)pathString{

    AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:pathString]];
    avplayer = [[AVPlayer alloc]initWithPlayerItem:item];
    [avplayer play];
    
}
- (IBAction)checkMusic:(id)sender {
    
    MusicTableViewController * musicVC = [[MusicTableViewController alloc]init];
    
    [self presentViewController:musicVC animated:YES completion:nil];
}
- (IBAction)checkNetMusic:(id)sender {
    
    NetMusicTableViewController * netMusicVC = [[NetMusicTableViewController alloc]init];
    
    [self presentViewController:netMusicVC animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
