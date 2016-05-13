//
//  KVOViewController.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/5/4.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "KVOViewController.h"

@interface KVOViewController ()

@property (weak, nonatomic) IBOutlet UIView *toggleView;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.toggleView addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (IBAction)clickToggleBtn:(id)sender {
    self.toggleView.hidden = !self.toggleView.hidden;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"hidden"]) {
        if ([change[@"new"] intValue] == 1) {
            self.view.backgroundColor = [UIColor yellowColor];
        } else if ([change[@"new"] intValue] == 0) {
            self.view.backgroundColor = [UIColor purpleColor];
        }
    }
}

@end
