@implementation AppDelegate   
 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {   
    tickets = 100;   
    count = 0;   
    theLock = [[NSLock alloc] init];   
    ticketsCondition = [[NSCondition alloc] init];   
    ticketsThreadOne = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];   
    [ticketsThreadOne setName:@"Thread-1"];   
    [ticketsThreadOne start];   
 
    ticketsThreadTwo = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];   
    [ticketsThreadTwo setName:@"Thread-2"];   
    [ticketsThreadTwo start];   
 
    NSThread *ticketsThreadThree = [[NSThread alloc] initWithTarget:self selector:@selector(run3) object:nil];   
    [ticketsThreadthree setName:@"Thread-3"];   
    [ticketsThreadthree start];       
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];  
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];   
    self.window.rootViewController = self.viewController;   
    [self.window makeKeyAndVisible];   
    return YES;   
}   
 
-(void)run3{   
    while (YES) {   
        [ticketsCondition lock];   
        [NSThread sleepForTimeInterval:3];   
        [ticketsCondition signal];   
        [ticketsCondition unlock];   
    }   
}   
 
- (void)run{   
    while (TRUE) {   
        [ticketsCondition lock];   
        [ticketsCondition wait];   
        [theLock lock];   
        if(tickets >= 0){   
            [NSThread sleepForTimeInterval:0.09];   
            count = 100 - tickets;   
            NSLog(@"CurrentTicketNum:%d, Sold:%d, ThreadName:%@", tickets, count, [[NSThread currentThread] name]);   
            --tickets;   
        }else{   
            break;   
        }   
        [theLock unlock];   
        [ticketsCondition unlock];   
    }   
}