//
//  XDBConnection.h
//  XZDB
//
//  Created by mlibai on 2016/10/9.
//  Copyright © 2016年 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XDBField, XDBRecordset, NSArray;

@interface XDBConnection : NSObject

@property (nonatomic, readonly, getter=isOpen) BOOL open;
@property (nonatomic, copy, readonly) NSString *path;

- (instancetype)initWithPath:(NSString *)path;

- (BOOL)open;

- (void)execute:(NSString *)sqlString recordHandle:(void (^)(NSArray<XDBField *> *aRecord))recordHandle error:(NSError **)error;
- (NSArray *)executeWithFormat:(NSString *)formate, ... NS_FORMAT_FUNCTION(1, 2);
- (BOOL)createTable:(NSString *)table fields:(XDBField *)field, ... NS_REQUIRES_NIL_TERMINATION;

- (BOOL)drop:(NSString *)table;
- (BOOL)truncate:(NSString *)table;

- (NSInteger)lastInsertRowid;



@end
