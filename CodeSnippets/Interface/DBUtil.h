#import <FMDB.h>
#import "UserModel.h"

#define CACHE_DIR                 [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define DATABASE_PATH             @"geekrrk.db"
#define USER_TABLE                [NSString stringWithFormat:@"usertable%@", [[NSUserDefaults standardUserDefaults] stringForKey:USER_ID]]

@interface DBUtil : NSObject

+ (FMDatabase *)shareDateBase;

+ (void)createUserTable;

+ (void)replaceUserModel:(UserModel *)userModel intoTable:(NSString *)tableName;

+ (UserModel *)queryUserModelByMid:(NSString *)mid fromTable:(NSString *)tableName;

@end
