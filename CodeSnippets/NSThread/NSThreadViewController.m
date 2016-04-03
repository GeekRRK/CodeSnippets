#define kURL @"http://img02.tooopen.com/images/20160216/tooopen_sy_156324542564.jpg"   
 
@implementation ViewController   
 
- (void)downloadImage:(NSString *)url{   
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];   
    UIImage *image = [[UIImage alloc] initWithData:data];   
    if (image == nil){   
        NSLog("The image doesn't exist.");
    } else {   
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];   
    }   
}   
 
- (void)updateUI:(UIImage*) image{   
    self.imageView.image = image;   
}   
 
- (void)viewDidLoad {   
    [super viewDidLoad];   
 
//    [NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:kURL];   
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:kURL];   
    [thread start];   
} 

@end
