//
//  DBUtils.m
//  CodeSnippets
//
//  Created by GeekRRK on 16/7/4.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "DBUtils.h"
#import <FMDB/FMDB.h>
#import "Model.h"

#define CACHE_DIR [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define DATABASE_PATH               @"al.db"
#define FOLLOW_STAR_TABLE           @"usertable"

@implementation DBUtils

+ (FMDatabase *)shareDateBase {
    static FMDatabase *db;
    static dispatch_once_t onecToken;
    dispatch_once(&onecToken, ^{
        NSString *filePath = [CACHE_DIR stringByAppendingPathComponent:DATABASE_PATH];
        db = [FMDatabase databaseWithPath:filePath];
        if (![db open]) {
            db = nil;
        } else {
            NSString *createStarTable = [NSString stringWithFormat:@"create table if not exists %@ (mid text primary key, name text)", FOLLOW_STAR_TABLE];
            [db executeUpdate:createStarTable];
        }
    });
    
    return db;
}

+ (void)insertStar:(Model *)model intoTable:(NSString *)tableName {
    NSString *insertSql = [NSString stringWithFormat:
                           @"insert into %@ (mid, name) values ('%@', '%@')",
                           tableName,
                           model.mid,
                           model.name];
    [[DBUtils shareDateBase] executeUpdate:insertSql];
}

+ (Model *)queryStarById:(NSString *)mid fromTable:(NSString *)tableName {
    Model *model = [[Model alloc] init];
    
    NSString *querySql = [NSString stringWithFormat:@"select * from %@ where mid = '%@'", tableName, mid];
    FMResultSet *resultSet = [[DBUtils shareDateBase] executeQuery:querySql];
    if ([resultSet next]) {
        model.mid = [resultSet stringForColumn:@"mid"];
        model.name = [resultSet stringForColumn:@"name"];
        
        return model;
    }
    
    return nil;
}


+ (void)deleteStarById:(NSString *)mid fromTable:(NSString *)tableName {
    Model *model = [DBUtils queryStarById:mid fromTable:tableName];
    if (model) {
        NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where mid = '%@'", tableName, mid];
        [[DBUtils shareDateBase] executeUpdate:deleteSql];
    }
}

+ (NSMutableArray *)queryAllModelFromTable:(NSString *)tableName {
    NSMutableArray *modelMutableArr = [[NSMutableArray alloc] init];
    
    NSString *querySql = [NSString stringWithFormat:@"select * from %@", tableName];
    FMResultSet *resultSet = [[DBUtils shareDateBase] executeQuery:querySql];
    while ([resultSet next]) {
        Model *model = [[Model alloc] init];
        model.mid = [resultSet stringForColumn:@"mid"];
        model.name = [resultSet stringForColumn:@"name"];
        
        [modelMutableArr addObject:model];
    }
    
    if (modelMutableArr.count == 0) {
        return nil;
    }
    
    return modelMutableArr;
}

@end
