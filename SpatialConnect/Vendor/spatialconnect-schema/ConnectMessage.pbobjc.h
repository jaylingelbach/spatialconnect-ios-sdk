// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: ConnectMessage.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_GEN_VERSION != 30001
#error This file was generated by a different version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

#pragma mark - ConnectMessageRoot

/// Exposes the extension registry for this file.
///
/// The base class provides:
/// @code
///   + (GPBExtensionRegistry *)extensionRegistry;
/// @endcode
/// which is a @c GPBExtensionRegistry that includes all the extensions defined by
/// this file and all files that it depends on.
@interface ConnectMessageRoot : GPBRootObject
@end

#pragma mark - ConnectMessage

typedef GPB_ENUM(ConnectMessage_FieldNumber) {
  ConnectMessage_FieldNumber_Context = 1,
  ConnectMessage_FieldNumber_CorrelationId = 2,
  ConnectMessage_FieldNumber_To = 3,
  ConnectMessage_FieldNumber_Action = 4,
  ConnectMessage_FieldNumber_Payload = 5,
  ConnectMessage_FieldNumber_Jwt = 6,
};

@interface ConnectMessage : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *context;

@property(nonatomic, readwrite) int32_t correlationId;

@property(nonatomic, readwrite, copy, null_resettable) NSString *to;

@property(nonatomic, readwrite, copy, null_resettable) NSString *action;

@property(nonatomic, readwrite, copy, null_resettable) NSString *payload;

@property(nonatomic, readwrite, copy, null_resettable) NSString *jwt;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
