@interface CustomTabBar : UITabBar

@property (strong, nonatomic) UIButton *midBtn;

@end

- (void)addBtn {
    if (_midBtn == nil) {
        UIView *bkgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 49)];
        bkgView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:1];
        [self addSubview:bkgView];
        
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0];
        
        _midBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _midBtn.frame = CGRectMake(0, 0, 80, 80);
        [_midBtn setBackgroundColor:[UIColor greenColor]];
        
        [self addSubview:_midBtn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addBtn];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = 44;
    
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / 3;
    CGFloat btnH = h;
    
    int i = 0;
    
    for (UIView *tabBarBtn in self.subviews) {
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            btnX = i * btnW;
            
            tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);

            if (i==0) {
                ++i;
            }
            
            ++i;
        }
    }
    
    _midBtn.center = CGPointMake(w * 0.5, h * 0.5);
}
