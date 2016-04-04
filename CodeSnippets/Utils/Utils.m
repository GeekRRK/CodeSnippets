#define WEAKSELF typeof(self) __weak weakSelf = self;
#define APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define cSCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define cSCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

//#define __GEEKDEBUG__
#ifdef __GEEKDEBUG__
    #define SERVERADDR @""
#else
    #define SERVERADDR @""
#endif

+ (void)showMessage:(NSString *)message
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((cSCREENWIDTH - LabelSize.width - 20)/2, cSCREENHEIGHT - 100, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:1.5 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

+ (NSString *) getFilePathBy:(NSString *) fileName{
    NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:fileName];
}

+ (NSMutableArray *) readFileBy:(NSString *)fileName{
    NSString *filepath = [SRUtil getFilePathBy:fileName];
    NSMutableArray *apps = [[NSMutableArray alloc] initWithContentsOfFile:filepath];
    if(apps == nil){
        apps = [[NSMutableArray alloc] init];
        if([apps writeToFile:filepath atomically:YES]){
            apps = [[NSMutableArray alloc] initWithContentsOfFile:filepath];
        }
    }
    
    return apps;
}

+ (NSMutableDictionary *)readDictBy:(NSString *)fileName{
    NSString *filepath = [SRUtil getFilePathBy:fileName];
    NSMutableDictionary *apps = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
    if(apps == nil){
        apps = [[NSMutableDictionary alloc] init];
        if([apps writeToFile:filepath atomically:YES]){
            apps = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
        }
    }
    
    return apps;
}

+ (NSData *)getDataFrom:(NSString *)urlAsString{
    NSURL    *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request  returningResponse:nil  error:&error];
    return data;
}

+ (void) downloadFile:(NSString *)urlAsString asFileName:(NSString *)fileName{
    NSURL    *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData   *data = [NSURLConnection sendSynchronousRequest:request  returningResponse:nil  error:&error];
    
    if (data != nil){
        NSLog(@"Download successfully");
        NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        if(!docDir) {
            NSLog(@"Can't find Documents");
        }
        NSString *filePath = [docDir stringByAppendingPathComponent:fileName];
        if([data writeToFile:filePath atomically:YES]){
            NSLog(@"Successful to save.");
        }else
        {
            NSLog(@"Failed to save.");
        }
    } else {
        NSLog(@"%@", error);
    }
}

+ (void) writeArray:(NSMutableArray *)array to:(NSString *)fileName{
    NSString *path = [SRUtil getFilePathBy:fileName];
    [array writeToFile:path atomically:YES];
}

+ (void) writeDict:(NSMutableDictionary *)dict to:(NSString *)fileName{
    NSString *path = [SRUtil getFilePathBy:fileName];
    [dict writeToFile:path atomically:YES];
}

+ (NSData *)readDataBy:(NSString *)fileName{
    NSString *filepath = [SRUtil getFilePathBy:fileName];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filepath];
    return data;
}

+ (void)writeData:(NSData *)data to:(NSString *)fileName{
    NSString *filepath = [SRUtil getFilePathBy:fileName];
    [data writeToFile:filepath atomically:YES];
}

+ (NSDictionary *)postString:(NSString *)dataAsString to:(NSString *)urlAsString{
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:360.0];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[dataAsString length]];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [dataAsString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *jsonAsData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil  error:nil];
    NSDictionary *dict;
    
    if(jsonAsData != nil){
        dict = [NSJSONSerialization JSONObjectWithData:jsonAsData options:NSJSONReadingAllowFragments error:nil];
        return dict;
    }
    
    return nil;
}
