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
