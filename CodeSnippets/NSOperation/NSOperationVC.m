#import "NSOperationVC.h"

@interface NSOperationVC ()

@end

@implementation NSOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(test) object:nil];
    // It will run synchronously in the main thread by default unless put it into the NSOperationQueue.
//    [invocation start];
    
    NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"Thread - blockOperationWithBlock: %@", [NSThread currentThread]);
    }];
    
    // Only if the count of the block is greater than one, it will run asynchronously.
    [block addExecutionBlock:^{
        NSLog(@"NSBlockOperation1------%@",[NSThread currentThread]);
    }];
    [block addExecutionBlock:^{
        NSLog(@"NSBlockOperation2------%@",[NSThread currentThread]);
    }];
    
//    [block start];
    
    // System will run the operations asynchronously in the NSOperationQueue by default.
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:invocation];
    [queue addOperation:block];
    [queue addOperationWithBlock:^{
       NSLog(@"Thread - addOperationWithBlock: %@", [NSThread currentThread]);
    }];
}

- (void)test {
    NSLog(@"Thread: %@", [NSThread currentThread]);
}

@end
