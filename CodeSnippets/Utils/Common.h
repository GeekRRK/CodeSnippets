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

#define LRWeakSelf(type)  __weak typeof(type) weak##type = type;
#define LRToast(str) [NSString stringWithFormat:@"%@",@#str]
#define APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

#define DatabasePath [NSHomeDirectory() stringByAppendingString:@"/Library/GeekRRK.db"]
