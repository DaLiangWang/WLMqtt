// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: gamemsg.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

 #import "Gamemsg.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - GamemsgRoot

@implementation GamemsgRoot

@end

#pragma mark - GamemsgRoot_FileDescriptor

static GPBFileDescriptor *GamemsgRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPBDebugCheckRuntimeVersion();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"protodata"
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - UserInfo

@implementation UserInfo

@dynamic id_p;
@dynamic nickName;
@dynamic headimgurl;
@dynamic sex;
@dynamic teamId;
@dynamic level;
@dynamic levelIcon;
@dynamic anchorId;
@dynamic loginType;

typedef struct UserInfo__storage_ {
  uint32_t _has_storage_[1];
  int32_t loginType;
  NSString *id_p;
  NSString *nickName;
  NSString *headimgurl;
  NSString *sex;
  NSString *teamId;
  NSString *level;
  NSString *levelIcon;
  NSString *anchorId;
} UserInfo__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = UserInfo_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(UserInfo__storage_, id_p),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "nickName",
        .dataTypeSpecific.className = NULL,
        .number = UserInfo_FieldNumber_NickName,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(UserInfo__storage_, nickName),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "headimgurl",
        .dataTypeSpecific.className = NULL,
        .number = UserInfo_FieldNumber_Headimgurl,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(UserInfo__storage_, headimgurl),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "sex",
        .dataTypeSpecific.className = NULL,
        .number = UserInfo_FieldNumber_Sex,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(UserInfo__storage_, sex),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "teamId",
        .dataTypeSpecific.className = NULL,
        .number = UserInfo_FieldNumber_TeamId,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(UserInfo__storage_, teamId),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "level",
        .dataTypeSpecific.className = NULL,
        .number = UserInfo_FieldNumber_Level,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(UserInfo__storage_, level),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "levelIcon",
        .dataTypeSpecific.className = NULL,
        .number = UserInfo_FieldNumber_LevelIcon,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(UserInfo__storage_, levelIcon),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "anchorId",
        .dataTypeSpecific.className = NULL,
        .number = UserInfo_FieldNumber_AnchorId,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(UserInfo__storage_, anchorId),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "loginType",
        .dataTypeSpecific.className = NULL,
        .number = UserInfo_FieldNumber_LoginType,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(UserInfo__storage_, loginType),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[UserInfo class]
                                     rootClass:[GamemsgRoot class]
                                          file:GamemsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(UserInfo__storage_)
                                         flags:0];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\005\002\010\000\005\006\000\007\t\000\010\010\000\t\t\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - Login

@implementation Login

@dynamic token;
@dynamic loginType;
@dynamic roomId;

typedef struct Login__storage_ {
  uint32_t _has_storage_[1];
  int32_t loginType;
  NSString *token;
  NSString *roomId;
} Login__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "token",
        .dataTypeSpecific.className = NULL,
        .number = Login_FieldNumber_Token,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Login__storage_, token),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "loginType",
        .dataTypeSpecific.className = NULL,
        .number = Login_FieldNumber_LoginType,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Login__storage_, loginType),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "roomId",
        .dataTypeSpecific.className = NULL,
        .number = Login_FieldNumber_RoomId,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Login__storage_, roomId),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Login class]
                                     rootClass:[GamemsgRoot class]
                                          file:GamemsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Login__storage_)
                                         flags:0];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\002\002\t\000\003\006\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - ChatMessage

@implementation ChatMessage

@dynamic roomId;
@dynamic userId;
@dynamic nickName;
@dynamic msgBody;
@dynamic msgType;
@dynamic level;

typedef struct ChatMessage__storage_ {
  uint32_t _has_storage_[1];
  int32_t msgType;
  NSString *roomId;
  NSString *userId;
  NSString *nickName;
  NSString *msgBody;
  NSString *level;
} ChatMessage__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "roomId",
        .dataTypeSpecific.className = NULL,
        .number = ChatMessage_FieldNumber_RoomId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(ChatMessage__storage_, roomId),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "userId",
        .dataTypeSpecific.className = NULL,
        .number = ChatMessage_FieldNumber_UserId,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(ChatMessage__storage_, userId),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "nickName",
        .dataTypeSpecific.className = NULL,
        .number = ChatMessage_FieldNumber_NickName,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(ChatMessage__storage_, nickName),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "msgBody",
        .dataTypeSpecific.className = NULL,
        .number = ChatMessage_FieldNumber_MsgBody,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(ChatMessage__storage_, msgBody),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "msgType",
        .dataTypeSpecific.className = NULL,
        .number = ChatMessage_FieldNumber_MsgType,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(ChatMessage__storage_, msgType),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "level",
        .dataTypeSpecific.className = NULL,
        .number = ChatMessage_FieldNumber_Level,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(ChatMessage__storage_, level),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[ChatMessage class]
                                     rootClass:[GamemsgRoot class]
                                          file:GamemsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(ChatMessage__storage_)
                                         flags:0];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\005\001\006\000\002\006\000\003\010\000\004\007\000\005\007\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - UserChatAction

@implementation UserChatAction

@dynamic roomId;
@dynamic game;
@dynamic userId;
@dynamic nickName;
@dynamic action;

typedef struct UserChatAction__storage_ {
  uint32_t _has_storage_[1];
  int32_t action;
  NSString *roomId;
  NSString *game;
  NSString *userId;
  NSString *nickName;
} UserChatAction__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "roomId",
        .dataTypeSpecific.className = NULL,
        .number = UserChatAction_FieldNumber_RoomId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(UserChatAction__storage_, roomId),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "game",
        .dataTypeSpecific.className = NULL,
        .number = UserChatAction_FieldNumber_Game,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(UserChatAction__storage_, game),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "userId",
        .dataTypeSpecific.className = NULL,
        .number = UserChatAction_FieldNumber_UserId,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(UserChatAction__storage_, userId),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "nickName",
        .dataTypeSpecific.className = NULL,
        .number = UserChatAction_FieldNumber_NickName,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(UserChatAction__storage_, nickName),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "action",
        .dataTypeSpecific.className = NULL,
        .number = UserChatAction_FieldNumber_Action,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(UserChatAction__storage_, action),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[UserChatAction class]
                                     rootClass:[GamemsgRoot class]
                                          file:GamemsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(UserChatAction__storage_)
                                         flags:0];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\003\001\006\000\003\006\000\004\010\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - RoomData

@implementation RoomData

@dynamic roomId;
@dynamic roomName;
@dynamic onlineUserNum;

typedef struct RoomData__storage_ {
  uint32_t _has_storage_[1];
  NSString *roomId;
  NSString *roomName;
  NSString *onlineUserNum;
} RoomData__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "roomId",
        .dataTypeSpecific.className = NULL,
        .number = RoomData_FieldNumber_RoomId,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(RoomData__storage_, roomId),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "roomName",
        .dataTypeSpecific.className = NULL,
        .number = RoomData_FieldNumber_RoomName,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(RoomData__storage_, roomName),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "onlineUserNum",
        .dataTypeSpecific.className = NULL,
        .number = RoomData_FieldNumber_OnlineUserNum,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(RoomData__storage_, onlineUserNum),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[RoomData class]
                                     rootClass:[GamemsgRoot class]
                                          file:GamemsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(RoomData__storage_)
                                         flags:0];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\003\001\006\000\002\010\000\003\r\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - MsgCommon

@implementation MsgCommon

@dynamic code;
@dynamic msg;
@dynamic other, other_Count;
@dynamic hasUserInfo, userInfo;
@dynamic hasLogin, login;
@dynamic hasChatMessage, chatMessage;
@dynamic hasUserChatAction, userChatAction;
@dynamic hasRoomData, roomData;

typedef struct MsgCommon__storage_ {
  uint32_t _has_storage_[1];
  int32_t code;
  NSString *msg;
  NSMutableDictionary *other;
  UserInfo *userInfo;
  Login *login;
  ChatMessage *chatMessage;
  UserChatAction *userChatAction;
  RoomData *roomData;
} MsgCommon__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "code",
        .dataTypeSpecific.className = NULL,
        .number = MsgCommon_FieldNumber_Code,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(MsgCommon__storage_, code),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt32,
      },
      {
        .name = "msg",
        .dataTypeSpecific.className = NULL,
        .number = MsgCommon_FieldNumber_Msg,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(MsgCommon__storage_, msg),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "other",
        .dataTypeSpecific.className = NULL,
        .number = MsgCommon_FieldNumber_Other,
        .hasIndex = GPBNoHasBit,
        .offset = (uint32_t)offsetof(MsgCommon__storage_, other),
        .flags = GPBFieldMapKeyString,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "userInfo",
        .dataTypeSpecific.className = GPBStringifySymbol(UserInfo),
        .number = MsgCommon_FieldNumber_UserInfo,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(MsgCommon__storage_, userInfo),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "login",
        .dataTypeSpecific.className = GPBStringifySymbol(Login),
        .number = MsgCommon_FieldNumber_Login,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(MsgCommon__storage_, login),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "chatMessage",
        .dataTypeSpecific.className = GPBStringifySymbol(ChatMessage),
        .number = MsgCommon_FieldNumber_ChatMessage,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(MsgCommon__storage_, chatMessage),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "userChatAction",
        .dataTypeSpecific.className = GPBStringifySymbol(UserChatAction),
        .number = MsgCommon_FieldNumber_UserChatAction,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(MsgCommon__storage_, userChatAction),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeMessage,
      },
      {
        .name = "roomData",
        .dataTypeSpecific.className = GPBStringifySymbol(RoomData),
        .number = MsgCommon_FieldNumber_RoomData,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(MsgCommon__storage_, roomData),
        .flags = GPBFieldOptional | GPBFieldTextFormatNameCustom,
        .dataType = GPBDataTypeMessage,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[MsgCommon class]
                                     rootClass:[GamemsgRoot class]
                                          file:GamemsgRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(MsgCommon__storage_)
                                         flags:0];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\004\310\001\010\000\312\001\013\000\313\001\016\000\314\001\010\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
