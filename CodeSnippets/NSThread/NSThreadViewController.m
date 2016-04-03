#define kURL @"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"   
@interface ViewController ()   
 
@end   
 
@implementation ViewController   
 
- (void)downloadImage:(NSString *) url{   
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];   
    UIImage *image = [[UIImage alloc]initWithData:data];   
    if(image == nil){   
 
    }else{   
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];   
    }   
}   
 
- (void)updateUI:(UIImage*) image{   
    self.imageView.image = image;   
}   
 
- (void)viewDidLoad   
{   
    [super viewDidLoad];   
 
//    [NSThread detachNewThreadSelector:@selector(downloadImage:) toTarget:self withObject:kURL];   
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(downloadImage:) object:kURL];   
    [thread start];   
} 
@end
