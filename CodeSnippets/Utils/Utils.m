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


+ (NSString *)date2String:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}
+ (NSDate *)string2Date:(NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    return date;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (UIToolbar *)getKeyBoardToolBarWithCtrl:(UIViewController *)ctrl action:(SEL)act{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 0, 30)];
    UIBarButtonItem * button =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:ctrl action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:ctrl action:act];
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:button,doneButton,nil];
    [topView setItems:buttonsArray];
    
    return topView;
}

+ (NSDate *)getDateFromString:(NSString *)inputString{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:inputString];
    
    return inputDate;
}

+ (NSString *)getStringFromDate:(NSDate *)inputDate{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    
    return str;
}

+ (NSString *)base64Img:(UIImage *)img{
    NSData *imgData = UIImageJPEGRepresentation(img, 0);
    NSLog(@"The size after compress：%ldKB\n", [imgData length] / 1024);
    
    NSString *baseStr = [imgData base64Encoding];
    NSString *base64Str = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                        (CFStringRef)baseStr,
                                                                                        NULL,
                                                                                        CFSTR(":/?#[]@!$&’()*+,;="),
                                                                                        kCFStringEncodingUTF8);
    return base64Str;
}

+ (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}

+ (NSString *)reduceImg:(UIImage *)img{
    UIImage *scaledImg = [SRUtil image:img byScalingToSize:CGSizeMake(150, 150)];
    
    NSString *base64Str = [SRUtil base64Img:scaledImg];
    
    return base64Str;
}

+ (NSString *)reduceImg:(UIImage *)img scale:(CGSize)size{
    UIImage *scaledImg = [SRUtil image:img byScalingToSize:size];
    
    NSString *base64Str = [SRUtil base64Img:scaledImg];
    
    return base64Str;
}

#define IMAGE_MAX_SIZE_WIDTH 640
#define IMAGE_MAX_SIZE_GEIGHT 960
+ (CGSize)fitsize:(CGSize)thisSize
{
    if(thisSize.width == 0 && thisSize.height ==0)
        return CGSizeMake(0, 0);
    CGFloat wscale = thisSize.width/IMAGE_MAX_SIZE_WIDTH;
    CGFloat hscale = thisSize.height/IMAGE_MAX_SIZE_GEIGHT;
    CGFloat scale = (wscale>hscale)?wscale:hscale;
    CGSize newSize = CGSizeMake(thisSize.width/scale, thisSize.height/scale);
    return newSize;
}

+(UIImage *)fitSmallImage:(UIImage *)image
{
    if (nil == image)
    {
        return nil;
    }
    if (image.size.width<IMAGE_MAX_SIZE_WIDTH && image.size.height<IMAGE_MAX_SIZE_GEIGHT)
    {
        return image;
    }
    CGSize size = [SRUtil fitsize:image.size];
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:rect];
    UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newing;
}
