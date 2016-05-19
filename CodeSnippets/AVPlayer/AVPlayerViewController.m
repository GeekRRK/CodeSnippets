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

@end
