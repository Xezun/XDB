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

const XDBDataTypeDescription XDBDataTypeNotSupportedDescription = {XDBDataTypeVariant, "BLOB", SQLITE_BLOB, 0, 0};

const XDBDataTypeDescription *XDBSupportedDataTypeDescriptions() {
    static XDBDataTypeDescription const _allSupportedDataTypeDescriptions[XDBDataTypeNotSupported] = {
        {XDBDataTypeNull, "NULL", SQLITE_NULL, 0, 0},
        
        {XDBDataTypeInteger, "INTEGER", SQLITE_INTEGER, 0, 0},
        {XDBDataTypeInt, "INT", SQLITE_INTEGER, 0, 0},
        {XDBDataTypeTinyInt, "TINYINT", SQLITE_INTEGER, 0, 0},
        {XDBDataTypeSmallint, "SMALLINT", SQLITE_INTEGER, 0, 0},
        {XDBDataTypeMediumint, "MEDIUMINT", SQLITE_INTEGER, 0, 0},
        {XDBDataTypeBigInt, "BIGINT", SQLITE_INTEGER, 0, 0},
        {XDBDataTypeUnsignedBigInt, "UNSIGNED BIG INT", SQLITE_INTEGER, 0, 0},
        {XDBDataTypeInt2, "INT2", SQLITE_INTEGER, 0, 0},
        {XDBDataTypeInt8, "INT8", SQLITE_INTEGER, 0, 0},
        {XDBDataTypeNumeric, "NUMERIC", SQLITE_INTEGER, 0, 0},
        {XDBDataTypeDecimal,  "DECIMAL", SQLITE_INTEGER, 10, 5},
        {XDBDataTypeBoolean, "BOOLEAN", SQLITE_INTEGER, 0, 0},
        
        {XDBDataTypeFloat, "FLOAT", SQLITE_FLOAT, 0, 0},
        {XDBDataTypeDouble, "DOUBLE", SQLITE_FLOAT, 0, 0},
        {XDBDataTypeReal, "REAL", SQLITE_FLOAT, 0, 0},
        {XDBDataTypeDoublePrecision, "DOUBLE PRECISION", SQLITE_FLOAT, 0, 0},
        
        {XDBDataTypeVarChar, "VARCHAR", SQLITE_TEXT, 255, 0},
        {XDBDataTypeDate, "DATE", SQLITE_TEXT, 0, 0},
        {XDBDataTypeDateTime, "DATETIME", SQLITE_TEXT, 0, 0},
        {XDBDataTypeText, "TEXT", SQLITE_TEXT, 0, 0},
        {XDBDataTypeCharacter, "CHARACTER", SQLITE_TEXT, 22, 0},
        {XDBDataTypeVaryingCharacter, "VARYING CHARACTER", SQLITE_TEXT, 255, 0},
        {XDBDataTypeNChar, "NCHAR", SQLITE_TEXT, 55, 0},
        {XDBDataTypeNativeCharacter, "NATIVE CHARACTER",  SQLITE_TEXT, 70, 0},
        {XDBDataTypeNVarChar, "NVARCHAR", SQLITE_TEXT, 100, 0},
        {XDBDataTypeClob, "CLOB", SQLITE_TEXT, 0, 0},
        
        {XDBDataTypeBlob, "BLOB", SQLITE_BLOB, 0, 0},
        {XDBDataTypeNoDatatypeSpecified, "VARIANT", SQLITE_BLOB, 0, 0},
        
        {XDBDataTypeVariant, "BLOB", SQLITE_BLOB, 0, 0},
    };
    return _allSupportedDataTypeDescriptions;
}

XDBDataTypeDescription XDBDataTypeDescriptionFromCString(const char *cName) {
    XDBDataTypeDescription sqliteDataDescription = XDBDataTypeNotSupportedDescription;
    if (cName != NULL) {
        NSUInteger cNameLength = strlen(cName);
        if (cNameLength < 3) {
            return sqliteDataDescription;
        }
        const XDBDataTypeDescription *supportedDataDescription = XDBSupportedDataTypeDescriptions();
        unsigned char *tmpNameStr = calloc((cNameLength + 1), sizeof(char));
        int m = 0, n = 0, j = 0;
        BOOL isFirstNumber = YES;
        BOOL breakLoop = NO;
        for (NSUInteger i = 0; i < cNameLength; i ++) {
            switch (cName[i]) {
                case ' ': // 当前是空格
                    // 移动到不是空格的位置
                    while (i++ < cNameLength && cName[i] == ' ') {
                    }
                    if (cName[i] == '\0') { // 如果到了末尾
                        breakLoop = YES;
                    }else if (cName[i] == '(') { // 如果是左括号
                        goto meet_data_size_branch;
                    }else{
                        if (j > 0) {
                            tmpNameStr[j++] = ' ';
                        }
                        tmpNameStr[j++] = toupper(cName[i]);
                        tmpNameStr[j] = '\0';
                    }
                    break;
                case '(': // 当前是左括号
                meet_data_size_branch:
                    while (i < cNameLength && !breakLoop) {
                        switch (cName[i + 1]) {
                            case '0':
                            case '1':
                            case '2':
                            case '3':
                            case '4':
                            case '5':
                            case '6':
                            case '7':
                            case '8':
                            case '9':
                                if (isFirstNumber) {
                                    m = m * 10 + cName[i + 1] - 48;
                                }else{
                                    n = n * 10 + cName[i + 1] - 48;
                                }
                                break;
                            case ',':
                                isFirstNumber = NO;
                                break;
                            case ')':
                            case '\0':
                                breakLoop = YES;
                                break;
                            default:
                                break;
                        }
                        i ++;
                    }
                    break;
                case '\0':
                    //tmpNameStr[i] = '\0';
                    breakLoop = YES;
                    break;
                default:
                    tmpNameStr[j ++] = toupper(cName[i]);
                    tmpNameStr[j] = '\0';
                    break;
            }
            if (breakLoop) {
                break;
            }
        }
        for (NSInteger i = 0; i < XDBDataTypeNotSupported; i ++) {
            if (strcmp((const char *)tmpNameStr, (const char *)supportedDataDescription[i].name) == 0) {
                sqliteDataDescription = supportedDataDescription[i];
                sqliteDataDescription.fundamental = m;
                sqliteDataDescription.scale = n;
                break;
            }
        }
        free(tmpNameStr);
    }
    return sqliteDataDescription;
}

XDBDataTypeDescription XDBDataTypeDescriptionFromNSString(NSString *name) {
    return XDBDataTypeDescriptionFromCString(name.UTF8String);
}

XDBDataTypeDescription XDBDataTypeDescriptionMake(XDBDataType dataType, unsigned int precision, unsigned scale) {
    if (dataType < XDBDataTypeNotSupported) {
        const XDBDataTypeDescription *all = XDBSupportedDataTypeDescriptions();
        for (XDBDataType i = XDBDataTypeNull; i < XDBDataTypeNotSupported; i++) {
            if (all[dataType].type == dataType) {
                XDBDataTypeDescription dept = all[dataType];
                if (precision < dept.precision) {
                    dept.precision = precision;
                }
                if (scale < dept.scale) {
                    dept.scale = scale;
                }
                return dept;
            }
        }
    }
    return XDBDataTypeNotSupportedDescription;
}

XDBDataType XDBDataTypeFromNSString(NSString *name) {
    return XDBDataTypeDescriptionFromNSString(name).type;
}

NSString *NSStringFromXDBDataTypeDescription(XDBDataTypeDescription dataTypeDescription) {
    if (dataTypeDescription.fundamental == 0 && dataTypeDescription.scale == 0) {
        return [NSString stringWithCString:(const char *)dataTypeDescription.name encoding:NSUTF8StringEncoding];
    }
    return [NSString stringWithFormat:@"%s(%d, %d)", dataTypeDescription.name, dataTypeDescription.fundamental, dataTypeDescription.scale];
}

NSUInteger XDBFundamentalDataTypeFromXDBDataType(XDBDataType dataType) {
    const XDBDataTypeDescription *all = XDBSupportedDataTypeDescriptions();
    for (XDBDataType i = XDBDataTypeNull; i < XDBDataTypeNotSupported; i++) {
        if (dataType == all[i].type) {
            return all[i].fundamental;
        }
    }
    return XDBDataTypeNotSupportedDescription.fundamental;
}

static void XDBRegisterErrorDescription() {
    [NSError setUserInfoValueProviderForDomain:kXDBErrorDomain provider:^id _Nullable(NSError * _Nonnull err, NSString * _Nonnull userInfoKey) {
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
    }];
}




