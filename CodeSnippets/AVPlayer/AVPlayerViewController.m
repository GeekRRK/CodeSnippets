//
//  AVPlayerViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/5/18.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "AVPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVPlayerViewController ()

@property (strong, nonatomic) AVPlayer *player;

@end

@implementation AVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        if (object == _player && _player.status == AVPlayerStatusReadyToPlay) {
            
        }
    }
}

- (void)setupPlayer {
    _player = [[AVPlayer alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [_player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    __weak typeof(self) weakSelf = self;
    __weak AVPlayer *weakPlayer = _player;
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float currentTime = weakPlayer.currentItem.currentTime.value / weakPlayer.currentItem.currentTime.timescale;
        NSTimeInterval timeInterval = [weakSelf availableDuration];
        CMTime duration = weakPlayer.currentItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
    }];
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;
    
    return result;
}

@end
