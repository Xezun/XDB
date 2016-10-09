//
//  XDBField.m
//  XZDB
//
//  Created by mlibai on 2016/10/9.
//  Copyright © 2016年 mlibai. All rights reserved.
//

#import "XDBField.h"
#import <sqlite3.h>


static NSUInteger XDBFundamentalDataTypeOfXDBDataType(XDBDataType dataType);
static NSUInteger XDBPrecisionOfXDBDataType(XDBDataType dataType);
static NSUInteger XDBNumericScaleOfXDBDataType(XDBDataType dataType);

@implementation XDBField



@end


NSString *NSStringFromXDBDataType(XDBDataType dataType) {
    switch (dataType) {
        case XDBDataTypeNull:
            return @"NULL";
            
        case XDBDataTypeInteger:
            return @"INTEGER";
        case XDBDataTypeInt:
            return @"INT";
        case XDBDataTypeTinyInt:
            return @"TINYINT";
        case XDBDataTypeSmallint:
            return @"SMALLINT";
        case XDBDataTypeMediumint:
            return @"MEDIUMINT";
        case XDBDataTypeBigInt:
            return @"BIGINT";
        case XDBDataTypeUnsignedBigInt:
            return @"UNSIGNED BIG INT";
        case XDBDataTypeInt2:
            return @"INT2";
        case XDBDataTypeInt8:
            return @"INT8";
        case XDBDataTypeNumeric:
            return @"NUMERIC";
        case XDBDataTypeDecimal:
            return @"DECIMAL";
        case XDBDataTypeBoolean:
            return @"BOOLEAN";
            
        case XDBDataTypeFloat:
            return @"FLOAT";
        case XDBDataTypeDouble:
            return @"DOUBLE";
        case XDBDataTypeReal:
            return @"REAL";
        case XDBDataTypeDoublePrecision:
            return @"DOUBLE PRECISION";
            
        case XDBDataTypeVarChar:
            return @"VARCHAR";
        case XDBDataTypeDate:
            return @"DATE";
        case XDBDataTypeDateTime:
            return @"DATETIME";
        case XDBDataTypeText:
            return @"TEXT";
        case XDBDataTypeCharacter:
            return @"CHARACTER";
        case XDBDataTypeVaryingCharacter:
            return @"VARYING CHARACTER";
        case XDBDataTypeNChar:
            return @"NCHAR";
        case XDBDataTypeNativeCharacter:
            return @"NATIVE CHARACTER";
        case XDBDataTypeNVarChar: 
            return @"NVARCHAR";
        case XDBDataTypeClob: 
            return @"CLOB";
            
        case XDBDataTypeBlob: 
            return @"BLOB";
        case XDBDataTypeNoDatatypeSpecified: 
            return @"VARIANT";
            
        case XDBDataTypeVariant: 
            return @"BLOB";
        default:
            return @"BLOB";
            break;
    }
}


static NSUInteger XDBFundamentalDataTypeOfXDBDataType(XDBDataType dataType) {
    switch (dataType) {
        case XDBDataTypeNull:
            return SQLITE_NULL;
            
        case XDBDataTypeInteger:
            return SQLITE_INTEGER;
        case XDBDataTypeInt:
            return SQLITE_INTEGER;
        case XDBDataTypeTinyInt:
            return SQLITE_INTEGER;
        case XDBDataTypeSmallint:
            return SQLITE_INTEGER;
        case XDBDataTypeMediumint:
            return SQLITE_INTEGER;
        case XDBDataTypeBigInt:
            return SQLITE_INTEGER;
        case XDBDataTypeUnsignedBigInt:
            return SQLITE_INTEGER;
        case XDBDataTypeInt2:
            return SQLITE_INTEGER;
        case XDBDataTypeInt8:
            return SQLITE_INTEGER;
        case XDBDataTypeNumeric:
            return SQLITE_INTEGER;
        case XDBDataTypeDecimal:
            return SQLITE_INTEGER;
        case XDBDataTypeBoolean:
            return SQLITE_INTEGER;
            
        case XDBDataTypeFloat:
            return SQLITE_FLOAT;
        case XDBDataTypeDouble:
            return SQLITE_FLOAT;
        case XDBDataTypeReal:
            return SQLITE_FLOAT;
        case XDBDataTypeDoublePrecision:
            return SQLITE_FLOAT;
            
        case XDBDataTypeVarChar:
            return SQLITE_TEXT;
        case XDBDataTypeDate:
            return SQLITE_TEXT;
        case XDBDataTypeDateTime:
            return SQLITE_TEXT;
        case XDBDataTypeText:
            return SQLITE_TEXT;
        case XDBDataTypeCharacter:
            return SQLITE_TEXT;
        case XDBDataTypeVaryingCharacter:
            return SQLITE_TEXT;
        case XDBDataTypeNChar:
            return SQLITE_TEXT;
        case XDBDataTypeNativeCharacter:
            return SQLITE_TEXT;
        case XDBDataTypeNVarChar: 
            return SQLITE_TEXT;
        case XDBDataTypeClob: 
            return SQLITE_TEXT;
            
        case XDBDataTypeBlob: 
            return SQLITE_BLOB;
        case XDBDataTypeNoDatatypeSpecified: 
            return SQLITE_BLOB;
            
        case XDBDataTypeVariant: 
            return SQLITE_BLOB;
        default:
            return SQLITE_BLOB;
            break;
    }
}

static NSUInteger XDBPrecisionOfXDBDataType(XDBDataType dataType) {
    switch (dataType) {
        case XDBDataTypeNull:
            return 0;
            
        case XDBDataTypeInteger:
            return 0;
        case XDBDataTypeInt:
            return 0;
        case XDBDataTypeTinyInt:
            return 0;
        case XDBDataTypeSmallint:
            return 0;
        case XDBDataTypeMediumint:
            return 0;
        case XDBDataTypeBigInt:
            return 0;
        case XDBDataTypeUnsignedBigInt:
            return 0;
        case XDBDataTypeInt2:
            return 0;
        case XDBDataTypeInt8:
            return 0;
        case XDBDataTypeNumeric:
            return 0;
        case XDBDataTypeDecimal:
            return 10;
        case XDBDataTypeBoolean:
            return 0;
            
        case XDBDataTypeFloat:
            return 0;
        case XDBDataTypeDouble:
            return 0;
        case XDBDataTypeReal:
            return 0;
        case XDBDataTypeDoublePrecision:
            return 0;
            
        case XDBDataTypeVarChar:
            return 255;
        case XDBDataTypeDate:
            return 0;
        case XDBDataTypeDateTime:
            return 0;
        case XDBDataTypeText:
            return 0;
        case XDBDataTypeCharacter:
            return 22;
        case XDBDataTypeVaryingCharacter:
            return 255;
        case XDBDataTypeNChar:
            return 55;
        case XDBDataTypeNativeCharacter: 
            return 70;
        case XDBDataTypeNVarChar: 
            return 100;
        case XDBDataTypeClob: 
            return 0;
            
        case XDBDataTypeBlob: 
            return 0;
        case XDBDataTypeNoDatatypeSpecified: 
            return 0;
            
        case XDBDataTypeVariant: 
            return 0;
            
        default:
            return 0;
            break;
    }
}

static NSUInteger XDBNumericScaleOfXDBDataType(XDBDataType dataType) {
    switch (dataType) {
        case XDBDataTypeNull:
            return 0;
            
        case XDBDataTypeInteger:
            return 0;
        case XDBDataTypeInt:
            return 0;
        case XDBDataTypeTinyInt:
            return 0;
        case XDBDataTypeSmallint:
            return 0;
        case XDBDataTypeMediumint:
            return 0;
        case XDBDataTypeBigInt:
            return 0;
        case XDBDataTypeUnsignedBigInt:
            return 0;
        case XDBDataTypeInt2:
            return 0;
        case XDBDataTypeInt8:
            return 0;
        case XDBDataTypeNumeric:
            return 0;
        case XDBDataTypeDecimal:
            return 5;
        case XDBDataTypeBoolean:
            return 0;
            
        case XDBDataTypeFloat:
            return 0;
        case XDBDataTypeDouble:
            return 0;
        case XDBDataTypeReal:
            return 0;
        case XDBDataTypeDoublePrecision:
            return 0;
            
        case XDBDataTypeVarChar:
            return 0;
        case XDBDataTypeDate:
            return 0;
        case XDBDataTypeDateTime:
            return 0;
        case XDBDataTypeText:
            return 0;
        case XDBDataTypeCharacter:
            return 0;
        case XDBDataTypeVaryingCharacter:
            return 0;
        case XDBDataTypeNChar:
            return 0;
        case XDBDataTypeNativeCharacter: 
            return 0;
        case XDBDataTypeNVarChar: 
            return 0;
        case XDBDataTypeClob: 
            return 0;
            
        case XDBDataTypeBlob: 
            return 0;
        case XDBDataTypeNoDatatypeSpecified: 
            return 0;
            
        case XDBDataTypeVariant: 
            return 0;
        default:
            return 0;
            break;
    }
}
