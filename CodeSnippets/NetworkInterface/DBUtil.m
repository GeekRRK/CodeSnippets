//#import "DBUtil.h"
//
//@implementation DBUtil
//
//+ (FMDatabase *)shareDateBase {
//    static FMDatabase *db;
//    static dispatch_once_t onecToken;
//    dispatch_once(&onecToken, ^{
//        NSString *filePath = [CACHE_DIR stringByAppendingPathComponent:DATABASE_PATH];
//        db = [FMDatabase databaseWithPath:filePath];
//        if (![db open]) {
//            db = nil;
//        }
//    });
//    
//    return db;
//}
//
//+ (void)createUserTable {
//    NSString *createStarTable = [NSString stringWithFormat:@"create table if not exists %@ (id text primary key, name text, phone text, pwd text)", USER_TABLE];
//    [[DBUtil shareDateBase] executeUpdate:createStarTable];
//}
//
//+ (void)replaceUserModel:(UserModel *)userModel intoTable:(NSString *)tableName {
//    [DBUtil createUserTable];
//    
//    NSString *replaceSql = [NSString stringWithFormat:
//                            @"replace into %@ (id, name, phone, pwd) values ('%@', '%@', '%@', '%@')",
//                            tableName,
//                            userModel.m_id,
//                            userModel.name,
//                            userModel.phone,
//                            userModel.pwd];
//    [[DBUtil shareDateBase] executeUpdate:replaceSql];
//}
//
//+ (UserModel *)queryUserModelByMid:(NSString *)mid fromTable:(NSString *)tableName {
//    [DBUtil createUserTable];
//    
//    UserModel *userModel = [[UserModel alloc] init];
//    
//    NSString *querySql = [NSString stringWithFormat:@"select * from %@ where id = '%@'", tableName, mid];
//    FMResultSet *resultSet = [[NXHDB shareDateBase] executeQuery:querySql];
//    if ([resultSet next]) {
//        userModel.m_id = [resultSet stringForColumn:@"id"];
//        userModel.name = [resultSet stringForColumn:@"name"];
//        userModel.phone = [resultSet stringForColumn:@"phone"];
//        userModel.pwd = [resultSet stringForColumn:@"pwd"];
//        
//        return userModel;
//    }
//    
//    return nil;
//}
//
//@end
