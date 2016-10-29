//
//  XDBConstant.m
//  XZDB
//
//  Created by mlibai on 2016/10/9.
//  Copyright © 2016年 mlibai. All rights reserved.
//

#import "XDBConstant.h"
#import <sqlite3.h>

NSString *const kXDBErrorDomain = @"kXDBErrorDomain";

@implementation NSError (XDBErrorRegister)

+ (void)load {
    [NSError setUserInfoValueProviderForDomain:kXDBErrorDomain provider:^id _Nullable(NSError * _Nonnull err, NSString * _Nonnull userInfoKey) {
        if ([userInfoKey isEqualToString:NSLocalizedDescriptionKey]) {
            switch (err.code) {
                case SQLITE_OK:
                    return @"Successful result";
                    break;
                    
                case SQLITE_ERROR:
                    return @"SQL error or missing database";
                    break;
                    
                case SQLITE_INTERNAL:
                    return @"Internal logic error in SQLite";
                    break;
                    
                case SQLITE_PERM:
                    return @"Access permission denied";
                    break;
                    
                case SQLITE_ABORT:
                    return @"Callback routine requested an abort";
                    break;
                    
                case SQLITE_BUSY:
                    return @"The database file is locked";
                    break;
                    
                case SQLITE_LOCKED:
                    return @"A table in the database is locked";
                    break;
                    
                case SQLITE_NOMEM:
                    return @"A malloc() failed";
                    break;
                    
                case SQLITE_READONLY:
                    return @"Attempt to write a readonly database";
                    break;
                    
                case SQLITE_INTERRUPT:
                    return @"Operation terminated by sqlite3_interrupt()";
                    break;
                    
                case SQLITE_IOERR:
                    return @"Some kind of disk I/O error occurred";
                    break;
                    
                case SQLITE_CORRUPT:
                    return @"The database disk image is malformed";
                    break;
                    
                case SQLITE_NOTFOUND:
                    return @"Unknown opcode in sqlite3_file_control()";
                    break;
                    
                case SQLITE_FULL:
                    return @"Insertion failed because database is full";
                    break;
                    
                case SQLITE_CANTOPEN:
                    return @"Unable to open the database file";
                    break;
                    
                case SQLITE_PROTOCOL:
                    return @"Database lock protocol error";
                    break;
                    
                case SQLITE_EMPTY:
                    return @"Database is empty";
                    break;
                    
                case SQLITE_SCHEMA:
                    return @"The database schema changed";
                    break;
                    
                case SQLITE_TOOBIG:
                    return @"String or BLOB exceeds size limit";
                    break;
                    
                case SQLITE_CONSTRAINT:
                    return @"Abort due to constraint violation";
                    break;
                    
                case SQLITE_MISMATCH:
                    return @"Data type mismatch";
                    break;
                    
                case SQLITE_MISUSE:
                    return @"Library used incorrectly";
                    break;
                    
                case SQLITE_NOLFS:
                    return @"Uses OS features not supported on host";
                    break;
                    
                case SQLITE_AUTH:
                    return @"Authorization denied";
                    break;
                    
                case SQLITE_FORMAT:
                    return @"Auxiliary database format error";
                    break;
                    
                case SQLITE_RANGE:
                    return @"2nd parameter to sqlite3_bind out of range";
                    break;
                    
                case SQLITE_NOTADB:
                    return @"File opened that is not a database file";
                    break;
                    
                case SQLITE_NOTICE:
                    return @"Notifications from sqlite3_log()";
                    break;
                    
                case SQLITE_WARNING:
                    return @"Warnings from sqlite3_log()";
                    break;
                    
                case SQLITE_ROW:
                    return @"sqlite3_step() has another row ready";
                    break;
                    
                case SQLITE_DONE:
                    return @"sqlite3_step() has finished executing";
                    break;
                    
                default:
                    return @"Unknown result code";
                    break;
            }
        }
        return nil;
    }];
}

@end
