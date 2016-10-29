//
//  XDBConnection.m
//  XZDB
//
//  Created by mlibai on 2016/10/9.
//  Copyright © 2016年 mlibai. All rights reserved.
//

#import "XDBConnection.h"
#import "XDBConstant.h"
#import <sqlite3.h>
#import "XDBField.h"
#import "XDBRecordset.h"

int sqlite3_exec_callback(void *execResult, int column_count, char **column_value, char **column_name);

@interface XDBField (XDB)

- (NSString *)sqlString;

@end

@interface XDBConnection ()

@property (nonatomic, assign, readonly) sqlite3 *conn;

@end

@implementation XDBConnection

- (instancetype)initWithPath:(NSString *)path {
    self = [super init];
    if (self != nil) {
        _path = path.copy;
    }
    return self;
}

- (BOOL)open {
    if ([self isOpen]) {
        return YES;
    }
    int result = sqlite3_open(_path.UTF8String, &_conn);
    _open = (result == SQLITE_OK);
    return _open;
}

- (BOOL)close {
    if (![self isOpen]) {
        return YES;
    }
    int result = sqlite3_close(_conn);
    _open = !(result == SQLITE_OK);
    return !_open;
}

- (XDBRecordset *)execute:(NSString *)sqlString error:(NSError *__autoreleasing *)error {
    NSArray *result;
    if ([self isOpen]) {
        char *errmsg = NULL;
        NSMutableArray *select_result = [[NSMutableArray alloc] init];
        int result_code = sqlite3_exec(_conn, sqlString.UTF8String, sqlite3_exec_callback, (__bridge void *)select_result, &errmsg);
        if (errmsg != NULL || result_code != SQLITE_OK) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:kXDBErrorDomain code:result_code userInfo:@{NSLocalizedFailureReasonErrorKey: [NSString stringWithCString:errmsg encoding:NSUTF8StringEncoding]}];
            }
            sqlite3_free(errmsg);
        } else {
            if (select_result == nil) {
                result = [NSArray arrayWithObject:[NSNumber numberWithInteger:result_code]];
            } else {
                result = [NSArray arrayWithObjects:[NSNumber numberWithInteger:result_code], select_result, nil];
            }
        }
    } else {
        result = [NSArray arrayWithObjects:[NSNumber numberWithInteger:SQLITE_ERROR], [SQLiteData descriptionForResultCode:SQLITE_ERROR], nil];
    }
    return result;
}

+ (void)handleError:(NSError **)error statusCode:(NSInteger)statusCode errorMessage:(const char *)errorMessage {
    if (error != NULL) {
        NSDictionary *userInfo = nil;
        if (errorMessage != NULL) {
            userInfo = @{NSLocalizedFailureReasonErrorKey: [NSString stringWithCString:errorMessage encoding:(NSUTF8StringEncoding)]};
        }
        *error = [NSError errorWithDomain:kXDBErrorDomain code:statusCode userInfo:userInfo];
    }
}

@end

@implementation XDBField (XDB)

- (NSString *)sqlString {
    NSString *type = NSStringFromXDBDataType(self.dataType);
    if (self.precision == 0) {
        return NSStringFromXDBDataType(self.dataType);
    } else if (self.numericScale == 0) {
        return [NSString stringWithFormat:@"%@(%lu)", type, (unsigned long)self.precision];
    }
    return [NSString stringWithFormat:@"%@(%lu, %lu)", type, (unsigned long)self.precision, (unsigned long)self.numericScale];
}

@end


static int sqlite3_exec_callback(void *execResult, int column_count, char **column_value, char **column_name) {
    NSMutableArray *array = (__bridge NSMutableArray *)(execResult);
    NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < column_count; i ++) {
        NSString *field; id value;
        if (column_name[i]) {
            field = [NSString stringWithUTF8String:column_name[i]];
        }else{
            field = [NSString stringWithFormat:@"(%ld)", i];
        }
        if (column_value[i]) {
            value = [NSString stringWithUTF8String:column_value[i]];
        }else{
            value = [NSNull null];
        }
        tmp[field] = value;
    }
    [array addObject:tmp];
    return 0;
}
