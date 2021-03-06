/*****************************************************************************
* Licensed to the Apache Software Foundation (ASF) under one
* or more contributor license agreements.  See the NOTICE file
* distributed with this work for additional information
* regarding copyright ownership.  The ASF licenses this file
* to you under the Apache License, Version 2.0 (the
* "License"); you may not use this file except in compliance
* with the License.  You may obtain a copy of the License at
*
*   http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing,
* software distributed under the License is distributed on an
* "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
* KIND, either express or implied.  See the License for the
* specific language governing permissions and limitations
* under the License.
******************************************************************************/

#import "SCFilterIn.h"

@implementation SCFilterIn

- (id)initWithArray:(NSArray *)arr andKeyPath:(NSString *)keypath {
  self = [super init];
  if (!self) {
    return nil;
  }
  array = arr;
  keyPath = keypath;
  return self;
}

- (id)initWithArray:(NSArray *)arr {
  self = [super init];
  if (!self) {
    return nil;
  }
  array = arr;
  keyPath = nil;
  return self;
}

- (NSString *)asSQL {
  NSAssert(keyPath, @"KeyPath must be set");
  return [NSString stringWithFormat:@"%@ IN %@", (NSString *)keyPath, array];
}

- (BOOL)compareLHS:(NSObject *)v {
  NSAssert(array, @"Test Value must be set");
  __block BOOL in = NO;
  [array
      enumerateObjectsUsingBlock:^(NSObject *obj, NSUInteger idx, BOOL *stop) {
        if ([v isEqual:obj]) {
          in = YES;
          *stop = YES;
        }
      }];
  return in;
}

@end
