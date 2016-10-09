//
//  XDBConstant.h
//  XZDB
//
//  Created by mlibai on 2016/10/9.
//  Copyright © 2016年 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XDBDataType) {
    // 空
    XDBDataTypeNull = 0,    // NULL
    // 整数
    XDBDataTypeInteger, // 整形 最大 8 字节
    XDBDataTypeBigInt,
    XDBDataTypeUnsignedBigInt,
    XDBDataTypeInt8,
    XDBDataTypeNumeric,
    XDBDataTypeDecimal,          // 十进制，范围(10,5)，即有效位最大10位，小数最多5位
    XDBDataTypeInt2,
    XDBDataTypeInt,
    XDBDataTypeTinyInt,
    XDBDataTypeSmallint,
    XDBDataTypeMediumint,
    XDBDataTypeBoolean,          // 布尔
    // 浮点数
    XDBDataTypeFloat,
    XDBDataTypeDouble,
    XDBDataTypeReal,
    XDBDataTypeDoublePrecision,
    // 字符
    XDBDataTypeVarChar,                    // 字符，255
    XDBDataTypeDate,                       // 日期，YYYY-mm-DD
    XDBDataTypeDateTime,                   // 日期时间，YYYY-mm-DD HH:MM:SS
    XDBDataTypeText,                       // 文本
    XDBDataTypeCharacter,          // 22
    XDBDataTypeVaryingCharacter,   // 255
    XDBDataTypeNChar,              // 55
    XDBDataTypeNativeCharacter,    // 70
    XDBDataTypeNVarChar,           // 100
    XDBDataTypeClob,               // 超大数据
    // 二进制
    XDBDataTypeBlob,               // 二进制
    XDBDataTypeBinary = XDBDataTypeBlob,
    XDBDataTypeNoDatatypeSpecified,
    // 变体，任意类型，未指定类型
    XDBDataTypeVariant,
    // 不支持的类型
    XDBDataTypeNotSupported
};

typedef struct XDBDataTypeDescription {
    XDBDataType   type;
    unsigned char name[32];     // 类型名
    unsigned int  fundamental;  // 存储方式，基本数据类型 SQLITE_INTEGER=1 SQLITE_FLOAT=2 SQLITE_TEXT=3 SQLITE_BLOB=4 SQLITE_NULL=5
    unsigned int  precision;    // 位数
    unsigned int  scale;        // 精确度
} XDBDataTypeDescription;

const XDBDataTypeDescription *XDBSupportedDataTypeDescriptions();
XDBDataTypeDescription XDBDataTypeDescriptionFromCString(const char *);
XDBDataTypeDescription XDBDataTypeDescriptionFromNSString(NSString *);
XDBDataTypeDescription XDBDataTypeDescriptionMake(XDBDataType dataType, unsigned int precision, unsigned scale);

XDBDataType XDBDataTypeFromNSString(NSString *);

NSString *NSStringFromXDBDataTypeDescription(XDBDataTypeDescription);

NSUInteger XDBFundamentalDataTypeFromXDBDataType(XDBDataType);

FOUNDATION_EXTERN NSString *const kXDBErrorDomain;


