//
//  XDBRecordset.h
//  XZDB
//
//  Created by mlibai on 2016/10/9.
//  Copyright © 2016年 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XDBConnection;

@interface XDBRecordset : NSObject

- (void)open:(NSString *)SQL connection:(XDBConnection *)connection;

@end
