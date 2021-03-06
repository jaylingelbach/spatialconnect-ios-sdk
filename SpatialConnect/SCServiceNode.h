/**
 * Copyright 2017 Boundless http://boundlessgeo.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License
 */

#import "SCService.h"
#import <Foundation/Foundation.h>

@interface SCServiceNode : NSObject

@property(nonatomic, readonly) id<SCServiceLifecycle> service;
// Services this node depends on
@property(nonatomic, readonly) NSArray<SCServiceNode *> *dependencies;
// Services this node is a dependency of
@property(nonatomic, readonly) NSArray<SCServiceNode *> *recipients;

- (id)initWithService:(id<SCServiceLifecycle>)s
      andDependencies:(NSArray<SCServiceNode *> *)d;

- (void)addRecipient:(SCServiceNode *)node;

@end
