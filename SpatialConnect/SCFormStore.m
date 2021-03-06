/**
 * Copyright 2016 Boundless http://boundlessgeo.com
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

#import "SCFormStore.h"
#import "Commands.h"
#import "SCHttpUtils.h"
#import "SCPoint+GeoJSON.h"
#import "SpatialConnect.h"

@implementation SCFormStore

@synthesize storeType = _storeType;
@synthesize storeVersion = _storeVersion;
@synthesize hasForms = _hasForms;

- (id)initWithStoreConfig:(SCStoreConfig *)config {
  self = [super initWithStoreConfig:config];
  if (self) {
    self.name = config.name;
    self.permission = SC_DATASTORE_READWRITE;
    formIds = [NSMutableDictionary new];
    _storeType = @"gpkg";
    _storeVersion = @"1";
    storeForms = [NSMutableDictionary new];
    _hasForms = [RACBehaviorSubject behaviorSubjectWithDefaultValue:@(NO)];
    [super connectBlocking];
  }
  return self;
}

- (id)initWithStoreConfig:(SCStoreConfig *)config withStyle:(SCStyle *)style {
  self = [self initWithStoreConfig:config];
  if (self) {
    self.style = style;
  }
  return self;
}

- (RACSignal *)start {
  return [super start];
}

- (void)stop {
  self.status = SC_DATASTORE_STOPPED;
}

- (void)resume {
}

- (void)pause {
}

- (void)destroy {
  [super destroy];
}

- (void)registerFormByConfig:(SCFormConfig *)f {
  [storeForms setObject:f forKey:f.key];
  [formIds setObject:@(f.identifier) forKey:f.key];
  [super addLayer:f.key withDef:[f sqlTypes]];
  [_hasForms sendNext:@(YES)];
}

- (void)updateFormByConfig:(SCFormConfig *)f {
  [storeForms setObject:f forKey:f.key];
  [formIds setObject:@(f.identifier) forKey:f.key];
  [super addLayer:f.key withDef:[f sqlTypes]];
  [_hasForms sendNext:@(YES)];
}

- (void)unregisterFormByConfig:(SCFormConfig *)f {
  [storeForms removeObjectForKey:f.key];
  [formIds removeObjectForKey:f.key];
  [_hasForms sendNext:@(storeForms.count > 0)];
}

- (void)unregisterFormByKey:(NSString *)key {
  [storeForms removeObjectForKey:key];
  [formIds removeObjectForKey:key];
  [_hasForms sendNext:@(storeForms.count > 0)];
}

- (NSArray *)formsDictionaryArray {
  NSMutableArray *arr = [[NSMutableArray alloc] init];
  [storeForms
   enumerateKeysAndObjectsUsingBlock:^(id key, SCFormConfig *f, BOOL *stop) {
     [arr addObject:[f dictionary]];
   }];
  return [NSArray arrayWithArray:arr];
}

#pragma mark -
#pragma mark SCSpatialStore
- (RACSignal *)queryById:(SCKeyTuple *)key {
  return
  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [subscriber sendCompleted];
    return nil;
  }];
}

- (NSNumber *)formIdForLayer:(NSString *)layer {
  return [formIds objectForKey:layer];
}

- (RACSignal *)update:(SCSpatialFeature *)feature {
  return nil;
}

- (RACSignal *) delete:(SCKeyTuple *)tuple {
  return nil;
}

- (NSDictionary *)generateSendPayload:(SCSpatialFeature *)f {
  NSNumber *formId = [formIds objectForKey:f.layerId];
  NSDictionary *payload = @{
    @"form_id" : formId,
    @"feature" : f.JSONDict
  };
  return payload;
}

- (NSString *)syncChannel {
  return @"/store/form";
}

@end
