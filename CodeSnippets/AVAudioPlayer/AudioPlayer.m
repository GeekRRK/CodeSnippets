//
//  ViewController.m
//  AudioPlayer
//
//  Created by Geek on 16-5-22.
//  Copyright (c) 2016年 GeekRRK. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AFNetworking.h"

#define CACHE_DIR [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface ViewController () <AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *curTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (strong, nonatomic) NSTimer *progressTimer;

@property (copy, nonatomic) NSString *curMusicName;

@end

@implementation ViewController

#pragma mark - System

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPlayer];
}

- (void)viewWillAppear:(BOOL)animated {
    _curMusicName = _musicDict[@"musicName"];
    [self downloadMusic:_musicDict[@"musicName"]];
}

#pragma mark - Prepare

- (void)setupPlayer {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    
    [_progressSlider addTarget:self action:@selector(progressChanged) forControlEvents:UIControlEventValueChanged];
    [_progressSlider addTarget:self action:@selector(progressBegin2Change) forControlEvents:UIControlEventTouchDown];
    [_progressSlider addTarget:self action:@selector(progressEnd2Change) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
}

- (void)playMusic:(NSString *)musicName {
    NSString *path = [[CACHE_DIR stringByAppendingPathComponent:musicName] stringByAppendingString:@".mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    [_player prepareToPlay];
    _player.delegate = self;
    [_player play];
}

#pragma mark - IBAction

- (IBAction)clickPlayBtn:(id)sender {
    if (_player.isPlaying) {
        [_player pause];
        [_playBtn setTitle:@"Play" forState:UIControlStateNormal];
    } else {
        [_player play];
        [_playBtn setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

- (void)progressBegin2Change {
    [_progressTimer setFireDate:[NSDate distantFuture]];
}

- (void)progressEnd2Change {
    [_progressTimer setFireDate:[NSDate date]];
}

#pragma mark - Real-time update

- (void)updateCurTime {
    NSTimeInterval secondsFloat = [_player currentTime];
    int minutes = (int)secondsFloat / 60;
    int seconds = (int)secondsFloat % 60;
    
    _curTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

- (void)updateTotalTime {
    NSTimeInterval secondsFloat = [_player duration];
    int minutes = (int)secondsFloat / 60;
    int seconds = (int)secondsFloat % 60;
    
    _totalTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

-(void)updateProgress {
    if (_player.isPlaying) {
        _progressSlider.value = _player.currentTime / _player.duration;
    }
}

-(void)progressChanged {
    if (_player) {
        [_player setCurrentTime:_progressSlider.value * _player.duration];
    }
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag) {
        NSLog(@"play succeed");
    }
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags {
    [_player play];
}

- (void)downloadMusic:(NSString *)musicName {
    NSString *downloadPath = [[CACHE_DIR stringByAppendingPathComponent:musicName] stringByAppendingString:@".mp3"];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:downloadPath];
    if (isExist) {
        [self playMusic:musicName];
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_musicDict[@"url"][0]]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:downloadPath append:YES];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float progress = (float)totalBytesRead / totalBytesExpectedToRead;
        if (progress > 0.1 && [_curMusicName isEqualToString:musicName]) {
            [self playMusic:musicName];
        }
    }];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [operation start];
}

@end
