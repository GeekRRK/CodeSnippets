//
//  MoviePlayerVC.m
//  iFan
//
//  Created by GeekRRK on 16/6/29.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "VideoPlayerVC.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoPlayerVC ()

@property (strong, nonatomic) AVPlayerLayer *curPlayerLayer;
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UIProgressView *bufferProgressView;
@property (weak, nonatomic) IBOutlet UILabel *curTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIView *controlView;

@property (assign, nonatomic) CGFloat currentTime;
@property (assign, nonatomic) int timeScale;
@property (assign, nonatomic) BOOL isPause;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isBuffering;

@end

@implementation VideoPlayerVC

#pragma mark - 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [self playVideo];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player pause];
    [self.player setRate:0];
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [self.player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    [self.timer invalidate];
    self.timer = nil;
    self.player = nil;
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(remove:) userInfo:nil repeats:NO];
    self.timer = time;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)setupControlView {
    self.titleLabel.text = self.videoUrl;
    
    [self setupTimeSlider];
    [self setupBufferProgressView];
    
    self.controlView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.controlView.hidden = YES;
    
    UITapGestureRecognizer *tapControlGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapControlView:)];
    tapControlGesture.numberOfTouchesRequired = 1;
    [self.controlView addGestureRecognizer:tapControlGesture];
    
    UITapGestureRecognizer *tapVideoViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVideoView:)];
    tapVideoViewGesture.numberOfTouchesRequired = 1;
    [self.videoView addGestureRecognizer:tapVideoViewGesture];
}

- (void)setupTimeSlider {
    UIImage *image = [UIImage imageNamed:@"video_slider"];
    [self.timeSlider setThumbImage:image forState:UIControlStateNormal];
    self.timeSlider.minimumTrackTintColor = [UIColor whiteColor];
    self.timeSlider.maximumTrackTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3];
    self.timeSlider.translatesAutoresizingMaskIntoConstraints = NO;
    self.timeSlider.maximumValue = self.player.currentItem.asset.duration.value / self.player.currentItem.asset.duration.timescale;
    
    self.totalTimeLabel.text = [self getTime:self.player.currentItem.asset.duration.value / self.player.currentItem.asset.duration.timescale];
}

- (void)setupBufferProgressView {
    self.bufferProgressView.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    self.bufferProgressView.trackTintColor = [UIColor clearColor];
}

#pragma mark - IBAction

- (IBAction)clickBackBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)clickPauseBtn:(id)sender {
    [sender setShowsTouchWhenHighlighted:YES];
    
    if (!self.isPause) {
        [self.pauseBtn setImage:[UIImage imageNamed:@"video_play.png"] forState:UIControlStateNormal];
        [self.player pause];
        self.isPause = YES;
    }else{
        [self.pauseBtn setImage:[UIImage imageNamed:@"video_pause.png"] forState:UIControlStateNormal];
        [_player play];
        self.isPause = NO;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideControlView:) userInfo:nil repeats:NO];
    }
}

- (void)hideControlView:(id)sender {
    self.controlView.hidden = YES;
}

- (IBAction)dragTimeSlider:(UISlider *)sender {
    CMTime cmtime = CMTimeMakeWithSeconds(sender.value, self.player.currentTime.timescale);
    [self.player seekToTime:cmtime completionHandler:^(BOOL finished) {
        if (finished) {
            [self.pauseBtn setImage:[UIImage imageNamed:@"video_pause.png"] forState:UIControlStateNormal];
            [self.player play];
        }
    }];
}

- (NSString *)getTime:(NSInteger)time {
    NSInteger min;
    NSInteger sec;
    min = time / 60;
    sec = time % 60;
    return [NSString stringWithFormat:@"%.2ld:%.2ld",min,sec];
}

- (void)playVideo {
    NSURL *playURl = [NSURL URLWithString:self.videoUrl];
    AVAsset *asset = [AVAsset assetWithURL:playURl];
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    [item addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    self.player = [AVPlayer playerWithPlayerItem:item];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    self.playerLayer.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.videoView.layer addSublayer:self.playerLayer];
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [self setupControlView];
}

- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    __weak VideoPlayerVC *blockSelf = self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1.0 / 60.0, NSEC_PER_SEC) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;
        _currentTime = currentSecond;
        double t = CMTimeGetSeconds(blockSelf.player.currentTime);
        blockSelf.timeSlider.value = t;
        blockSelf.curTimeLabel.text = [blockSelf getTime:blockSelf.currentTime];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            if( [UIApplication sharedApplication].applicationState == UIApplicationStateActive ||  [UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
                self.isPause = NO;
                [self.pauseBtn setImage:[UIImage imageNamed:@"video_pause.png"] forState:UIControlStateNormal];
                [self.player play];
            } else {
                self.isPause = YES;
                [self.pauseBtn setImage:[UIImage imageNamed:@"video_play.png"] forState:UIControlStateNormal];
                [self.player pause];
            }
            self.controlView.hidden = YES;
            
            [self monitoringPlayback:_player.currentItem];
            
            self.timeScale = playerItem.currentTime.timescale;
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval result = startSeconds + durationSeconds;
        
        float bufferProgress = (float)result / self.player.currentItem.duration.value * self.player.currentItem.duration.timescale;
        self.bufferProgressView.progress = bufferProgress;
    }
    
    if (object == self.player.currentItem && [keyPath isEqualToString:@"playbackBufferEmpty"]) {
        if (self.player.currentItem.playbackBufferEmpty) {
            self.isBuffering = YES;
            [self.pauseBtn setImage:[UIImage imageNamed:@"video_play.png"] forState:UIControlStateNormal];
            
            [self.player pause];
        }
    } else if (object == self.player.currentItem && [keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        if (self.player.currentItem.playbackLikelyToKeepUp) {
            if (!self.isPause) {
                self.isBuffering = NO;
                [self.pauseBtn setImage:[UIImage imageNamed:@"video_pause.png"] forState:UIControlStateNormal];
                
                [self.player play];
            }
        }
    }
}

- (void)remove:(NSTimer *)sender {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)tapControlView:(UITapGestureRecognizer *)gesture {
    self.controlView.hidden = YES;
}

- (void)tapVideoView:(UITapGestureRecognizer *)gesture {
    self.controlView.hidden = NO;
}

@end
