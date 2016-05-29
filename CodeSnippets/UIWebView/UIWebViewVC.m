#import "UIWebViewVC.h"

@interface UIWebViewVC () <UIWebViewDelegate>

@end

@implementation UIWebViewVC

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 1
//    CGFloat webViewHeight = [webView.scrollView contentSize].height;
    
    // 2
//    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    // CGFloat webViewHeight= [[webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"] floatValue];
    
    // 3
//    CGSize webViewHeight = [webView sizeThatFits:CGSizeZero];
    
    // 4
    CGFloat webViewHeight = 0.0f;
    if ([webView.subviews count] > 0) {
        UIView * scrollerView = webView.subviews[0];
        if ([scrollerView.subviews count] > 0) {
            UIView *webDocView = scrollerView.subviews.lastObject;
            if ([webDocView isKindOfClass:[NSClassFromString(@"UIWebDocumentView") class]]) {
                webViewHeight = webDocView.frame.size.height;
            }
        }
    }
    
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
}

@end
