//
//  XDBField.h
//  XZDB
//
//  Created by mlibai on 2016/10/9.
//  Copyright © 2016年 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDBConstant.h"

NSString *NSStringFromXDBDataType(XDBDataType dataType);

@interface XDBField : NSObject

@property (nonatomic, readonly) XDBDataType dataType;
@property (nonatomic, readonly) NSUInteger fundamentalDataType; // 基本数据类型 SQLITE_INTEGER=1 SQLITE_FLOAT=2 SQLITE_TEXT=3 SQLITE_BLOB=4 SQLITE_NULL=5
@property (nonatomic, readonly) NSUInteger precision;    // 对于数字而言，表示数字的位数；其它数据表示字节数。
@property (nonatomic, readonly) NSUInteger numericScale; // 小数位个数

+ (XDBField *)fieldWithDataType:(XDBDataType)dataType;

@end
