// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: EventMessage.proto

#ifndef PROTOBUF_EventMessage_2eproto__INCLUDED
#define PROTOBUF_EventMessage_2eproto__INCLUDED

#include <string>

#include <google/protobuf/stubs/common.h>

#if GOOGLE_PROTOBUF_VERSION < 2005000
#error This file was generated by a newer version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please update
#error your headers.
#endif
#if 2005000 < GOOGLE_PROTOBUF_MIN_PROTOC_VERSION
#error This file was generated by an older version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please
#error regenerate this file with a newer version of protoc.
#endif

#include <google/protobuf/generated_message_util.h>
#include <google/protobuf/message.h>
#include <google/protobuf/repeated_field.h>
#include <google/protobuf/extension_set.h>
#include <google/protobuf/unknown_field_set.h>
// @@protoc_insertion_point(includes)

namespace WeWrite {

// Internal implementation detail -- do not call these.
void  protobuf_AddDesc_EventMessage_2eproto();
void protobuf_AssignDesc_EventMessage_2eproto();
void protobuf_ShutdownFile_EventMessage_2eproto();

class NSRange;
class EventMessage;

// ===================================================================

class NSRange : public ::google::protobuf::Message {
 public:
  NSRange();
  virtual ~NSRange();

  NSRange(const NSRange& from);

  inline NSRange& operator=(const NSRange& from) {
    CopyFrom(from);
    return *this;
  }

  inline const ::google::protobuf::UnknownFieldSet& unknown_fields() const {
    return _unknown_fields_;
  }

  inline ::google::protobuf::UnknownFieldSet* mutable_unknown_fields() {
    return &_unknown_fields_;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const NSRange& default_instance();

  void Swap(NSRange* other);

  // implements Message ----------------------------------------------

  NSRange* New() const;
  void CopyFrom(const ::google::protobuf::Message& from);
  void MergeFrom(const ::google::protobuf::Message& from);
  void CopyFrom(const NSRange& from);
  void MergeFrom(const NSRange& from);
  void Clear();
  bool IsInitialized() const;

  int ByteSize() const;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input);
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const;
  ::google::protobuf::uint8* SerializeWithCachedSizesToArray(::google::protobuf::uint8* output) const;
  int GetCachedSize() const { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const;
  public:

  ::google::protobuf::Metadata GetMetadata() const;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // required int64 location = 1;
  inline bool has_location() const;
  inline void clear_location();
  static const int kLocationFieldNumber = 1;
  inline ::google::protobuf::int64 location() const;
  inline void set_location(::google::protobuf::int64 value);

  // required int64 length = 2;
  inline bool has_length() const;
  inline void clear_length();
  static const int kLengthFieldNumber = 2;
  inline ::google::protobuf::int64 length() const;
  inline void set_length(::google::protobuf::int64 value);

  // @@protoc_insertion_point(class_scope:WeWrite.NSRange)
 private:
  inline void set_has_location();
  inline void clear_has_location();
  inline void set_has_length();
  inline void clear_has_length();

  ::google::protobuf::UnknownFieldSet _unknown_fields_;

  ::google::protobuf::int64 location_;
  ::google::protobuf::int64 length_;

  mutable int _cached_size_;
  ::google::protobuf::uint32 _has_bits_[(2 + 31) / 32];

  friend void  protobuf_AddDesc_EventMessage_2eproto();
  friend void protobuf_AssignDesc_EventMessage_2eproto();
  friend void protobuf_ShutdownFile_EventMessage_2eproto();

  void InitAsDefaultInstance();
  static NSRange* default_instance_;
};
// -------------------------------------------------------------------

class EventMessage : public ::google::protobuf::Message {
 public:
  EventMessage();
  virtual ~EventMessage();

  EventMessage(const EventMessage& from);

  inline EventMessage& operator=(const EventMessage& from) {
    CopyFrom(from);
    return *this;
  }

  inline const ::google::protobuf::UnknownFieldSet& unknown_fields() const {
    return _unknown_fields_;
  }

  inline ::google::protobuf::UnknownFieldSet* mutable_unknown_fields() {
    return &_unknown_fields_;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const EventMessage& default_instance();

  void Swap(EventMessage* other);

  // implements Message ----------------------------------------------

  EventMessage* New() const;
  void CopyFrom(const ::google::protobuf::Message& from);
  void MergeFrom(const ::google::protobuf::Message& from);
  void CopyFrom(const EventMessage& from);
  void MergeFrom(const EventMessage& from);
  void Clear();
  bool IsInitialized() const;

  int ByteSize() const;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input);
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const;
  ::google::protobuf::uint8* SerializeWithCachedSizesToArray(::google::protobuf::uint8* output) const;
  int GetCachedSize() const { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const;
  public:

  ::google::protobuf::Metadata GetMetadata() const;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // required int64 participant_id = 1;
  inline bool has_participant_id() const;
  inline void clear_participant_id();
  static const int kParticipantIdFieldNumber = 1;
  inline ::google::protobuf::int64 participant_id() const;
  inline void set_participant_id(::google::protobuf::int64 value);

  // required int64 local_id = 2;
  inline bool has_local_id() const;
  inline void clear_local_id();
  static const int kLocalIdFieldNumber = 2;
  inline ::google::protobuf::int64 local_id() const;
  inline void set_local_id(::google::protobuf::int64 value);

  // required string original_string = 3;
  inline bool has_original_string() const;
  inline void clear_original_string();
  static const int kOriginalStringFieldNumber = 3;
  inline const ::std::string& original_string() const;
  inline void set_original_string(const ::std::string& value);
  inline void set_original_string(const char* value);
  inline void set_original_string(const char* value, size_t size);
  inline ::std::string* mutable_original_string();
  inline ::std::string* release_original_string();
  inline void set_allocated_original_string(::std::string* original_string);

  // required string replacement_string = 4;
  inline bool has_replacement_string() const;
  inline void clear_replacement_string();
  static const int kReplacementStringFieldNumber = 4;
  inline const ::std::string& replacement_string() const;
  inline void set_replacement_string(const ::std::string& value);
  inline void set_replacement_string(const char* value);
  inline void set_replacement_string(const char* value, size_t size);
  inline ::std::string* mutable_replacement_string();
  inline ::std::string* release_replacement_string();
  inline void set_allocated_replacement_string(::std::string* replacement_string);

  // required .WeWrite.NSRange range = 5;
  inline bool has_range() const;
  inline void clear_range();
  static const int kRangeFieldNumber = 5;
  inline const ::WeWrite::NSRange& range() const;
  inline ::WeWrite::NSRange* mutable_range();
  inline ::WeWrite::NSRange* release_range();
  inline void set_allocated_range(::WeWrite::NSRange* range);

  // required int64 confirmed_gid = 6;
  inline bool has_confirmed_gid() const;
  inline void clear_confirmed_gid();
  static const int kConfirmedGidFieldNumber = 6;
  inline ::google::protobuf::int64 confirmed_gid() const;
  inline void set_confirmed_gid(::google::protobuf::int64 value);

  // required bool is_undo = 7;
  inline bool has_is_undo() const;
  inline void clear_is_undo();
  static const int kIsUndoFieldNumber = 7;
  inline bool is_undo() const;
  inline void set_is_undo(bool value);

  // @@protoc_insertion_point(class_scope:WeWrite.EventMessage)
 private:
  inline void set_has_participant_id();
  inline void clear_has_participant_id();
  inline void set_has_local_id();
  inline void clear_has_local_id();
  inline void set_has_original_string();
  inline void clear_has_original_string();
  inline void set_has_replacement_string();
  inline void clear_has_replacement_string();
  inline void set_has_range();
  inline void clear_has_range();
  inline void set_has_confirmed_gid();
  inline void clear_has_confirmed_gid();
  inline void set_has_is_undo();
  inline void clear_has_is_undo();

  ::google::protobuf::UnknownFieldSet _unknown_fields_;

  ::google::protobuf::int64 participant_id_;
  ::google::protobuf::int64 local_id_;
  ::std::string* original_string_;
  ::std::string* replacement_string_;
  ::WeWrite::NSRange* range_;
  ::google::protobuf::int64 confirmed_gid_;
  bool is_undo_;

  mutable int _cached_size_;
  ::google::protobuf::uint32 _has_bits_[(7 + 31) / 32];

  friend void  protobuf_AddDesc_EventMessage_2eproto();
  friend void protobuf_AssignDesc_EventMessage_2eproto();
  friend void protobuf_ShutdownFile_EventMessage_2eproto();

  void InitAsDefaultInstance();
  static EventMessage* default_instance_;
};
// ===================================================================


// ===================================================================

// NSRange

// required int64 location = 1;
inline bool NSRange::has_location() const {
  return (_has_bits_[0] & 0x00000001u) != 0;
}
inline void NSRange::set_has_location() {
  _has_bits_[0] |= 0x00000001u;
}
inline void NSRange::clear_has_location() {
  _has_bits_[0] &= ~0x00000001u;
}
inline void NSRange::clear_location() {
  location_ = GOOGLE_LONGLONG(0);
  clear_has_location();
}
inline ::google::protobuf::int64 NSRange::location() const {
  return location_;
}
inline void NSRange::set_location(::google::protobuf::int64 value) {
  set_has_location();
  location_ = value;
}

// required int64 length = 2;
inline bool NSRange::has_length() const {
  return (_has_bits_[0] & 0x00000002u) != 0;
}
inline void NSRange::set_has_length() {
  _has_bits_[0] |= 0x00000002u;
}
inline void NSRange::clear_has_length() {
  _has_bits_[0] &= ~0x00000002u;
}
inline void NSRange::clear_length() {
  length_ = GOOGLE_LONGLONG(0);
  clear_has_length();
}
inline ::google::protobuf::int64 NSRange::length() const {
  return length_;
}
inline void NSRange::set_length(::google::protobuf::int64 value) {
  set_has_length();
  length_ = value;
}

// -------------------------------------------------------------------

// EventMessage

// required int64 participant_id = 1;
inline bool EventMessage::has_participant_id() const {
  return (_has_bits_[0] & 0x00000001u) != 0;
}
inline void EventMessage::set_has_participant_id() {
  _has_bits_[0] |= 0x00000001u;
}
inline void EventMessage::clear_has_participant_id() {
  _has_bits_[0] &= ~0x00000001u;
}
inline void EventMessage::clear_participant_id() {
  participant_id_ = GOOGLE_LONGLONG(0);
  clear_has_participant_id();
}
inline ::google::protobuf::int64 EventMessage::participant_id() const {
  return participant_id_;
}
inline void EventMessage::set_participant_id(::google::protobuf::int64 value) {
  set_has_participant_id();
  participant_id_ = value;
}

// required int64 local_id = 2;
inline bool EventMessage::has_local_id() const {
  return (_has_bits_[0] & 0x00000002u) != 0;
}
inline void EventMessage::set_has_local_id() {
  _has_bits_[0] |= 0x00000002u;
}
inline void EventMessage::clear_has_local_id() {
  _has_bits_[0] &= ~0x00000002u;
}
inline void EventMessage::clear_local_id() {
  local_id_ = GOOGLE_LONGLONG(0);
  clear_has_local_id();
}
inline ::google::protobuf::int64 EventMessage::local_id() const {
  return local_id_;
}
inline void EventMessage::set_local_id(::google::protobuf::int64 value) {
  set_has_local_id();
  local_id_ = value;
}

// required string original_string = 3;
inline bool EventMessage::has_original_string() const {
  return (_has_bits_[0] & 0x00000004u) != 0;
}
inline void EventMessage::set_has_original_string() {
  _has_bits_[0] |= 0x00000004u;
}
inline void EventMessage::clear_has_original_string() {
  _has_bits_[0] &= ~0x00000004u;
}
inline void EventMessage::clear_original_string() {
  if (original_string_ != &::google::protobuf::internal::kEmptyString) {
    original_string_->clear();
  }
  clear_has_original_string();
}
inline const ::std::string& EventMessage::original_string() const {
  return *original_string_;
}
inline void EventMessage::set_original_string(const ::std::string& value) {
  set_has_original_string();
  if (original_string_ == &::google::protobuf::internal::kEmptyString) {
    original_string_ = new ::std::string;
  }
  original_string_->assign(value);
}
inline void EventMessage::set_original_string(const char* value) {
  set_has_original_string();
  if (original_string_ == &::google::protobuf::internal::kEmptyString) {
    original_string_ = new ::std::string;
  }
  original_string_->assign(value);
}
inline void EventMessage::set_original_string(const char* value, size_t size) {
  set_has_original_string();
  if (original_string_ == &::google::protobuf::internal::kEmptyString) {
    original_string_ = new ::std::string;
  }
  original_string_->assign(reinterpret_cast<const char*>(value), size);
}
inline ::std::string* EventMessage::mutable_original_string() {
  set_has_original_string();
  if (original_string_ == &::google::protobuf::internal::kEmptyString) {
    original_string_ = new ::std::string;
  }
  return original_string_;
}
inline ::std::string* EventMessage::release_original_string() {
  clear_has_original_string();
  if (original_string_ == &::google::protobuf::internal::kEmptyString) {
    return NULL;
  } else {
    ::std::string* temp = original_string_;
    original_string_ = const_cast< ::std::string*>(&::google::protobuf::internal::kEmptyString);
    return temp;
  }
}
inline void EventMessage::set_allocated_original_string(::std::string* original_string) {
  if (original_string_ != &::google::protobuf::internal::kEmptyString) {
    delete original_string_;
  }
  if (original_string) {
    set_has_original_string();
    original_string_ = original_string;
  } else {
    clear_has_original_string();
    original_string_ = const_cast< ::std::string*>(&::google::protobuf::internal::kEmptyString);
  }
}

// required string replacement_string = 4;
inline bool EventMessage::has_replacement_string() const {
  return (_has_bits_[0] & 0x00000008u) != 0;
}
inline void EventMessage::set_has_replacement_string() {
  _has_bits_[0] |= 0x00000008u;
}
inline void EventMessage::clear_has_replacement_string() {
  _has_bits_[0] &= ~0x00000008u;
}
inline void EventMessage::clear_replacement_string() {
  if (replacement_string_ != &::google::protobuf::internal::kEmptyString) {
    replacement_string_->clear();
  }
  clear_has_replacement_string();
}
inline const ::std::string& EventMessage::replacement_string() const {
  return *replacement_string_;
}
inline void EventMessage::set_replacement_string(const ::std::string& value) {
  set_has_replacement_string();
  if (replacement_string_ == &::google::protobuf::internal::kEmptyString) {
    replacement_string_ = new ::std::string;
  }
  replacement_string_->assign(value);
}
inline void EventMessage::set_replacement_string(const char* value) {
  set_has_replacement_string();
  if (replacement_string_ == &::google::protobuf::internal::kEmptyString) {
    replacement_string_ = new ::std::string;
  }
  replacement_string_->assign(value);
}
inline void EventMessage::set_replacement_string(const char* value, size_t size) {
  set_has_replacement_string();
  if (replacement_string_ == &::google::protobuf::internal::kEmptyString) {
    replacement_string_ = new ::std::string;
  }
  replacement_string_->assign(reinterpret_cast<const char*>(value), size);
}
inline ::std::string* EventMessage::mutable_replacement_string() {
  set_has_replacement_string();
  if (replacement_string_ == &::google::protobuf::internal::kEmptyString) {
    replacement_string_ = new ::std::string;
  }
  return replacement_string_;
}
inline ::std::string* EventMessage::release_replacement_string() {
  clear_has_replacement_string();
  if (replacement_string_ == &::google::protobuf::internal::kEmptyString) {
    return NULL;
  } else {
    ::std::string* temp = replacement_string_;
    replacement_string_ = const_cast< ::std::string*>(&::google::protobuf::internal::kEmptyString);
    return temp;
  }
}
inline void EventMessage::set_allocated_replacement_string(::std::string* replacement_string) {
  if (replacement_string_ != &::google::protobuf::internal::kEmptyString) {
    delete replacement_string_;
  }
  if (replacement_string) {
    set_has_replacement_string();
    replacement_string_ = replacement_string;
  } else {
    clear_has_replacement_string();
    replacement_string_ = const_cast< ::std::string*>(&::google::protobuf::internal::kEmptyString);
  }
}

// required .WeWrite.NSRange range = 5;
inline bool EventMessage::has_range() const {
  return (_has_bits_[0] & 0x00000010u) != 0;
}
inline void EventMessage::set_has_range() {
  _has_bits_[0] |= 0x00000010u;
}
inline void EventMessage::clear_has_range() {
  _has_bits_[0] &= ~0x00000010u;
}
inline void EventMessage::clear_range() {
  if (range_ != NULL) range_->::WeWrite::NSRange::Clear();
  clear_has_range();
}
inline const ::WeWrite::NSRange& EventMessage::range() const {
  return range_ != NULL ? *range_ : *default_instance_->range_;
}
inline ::WeWrite::NSRange* EventMessage::mutable_range() {
  set_has_range();
  if (range_ == NULL) range_ = new ::WeWrite::NSRange;
  return range_;
}
inline ::WeWrite::NSRange* EventMessage::release_range() {
  clear_has_range();
  ::WeWrite::NSRange* temp = range_;
  range_ = NULL;
  return temp;
}
inline void EventMessage::set_allocated_range(::WeWrite::NSRange* range) {
  delete range_;
  range_ = range;
  if (range) {
    set_has_range();
  } else {
    clear_has_range();
  }
}

// required int64 confirmed_gid = 6;
inline bool EventMessage::has_confirmed_gid() const {
  return (_has_bits_[0] & 0x00000020u) != 0;
}
inline void EventMessage::set_has_confirmed_gid() {
  _has_bits_[0] |= 0x00000020u;
}
inline void EventMessage::clear_has_confirmed_gid() {
  _has_bits_[0] &= ~0x00000020u;
}
inline void EventMessage::clear_confirmed_gid() {
  confirmed_gid_ = GOOGLE_LONGLONG(0);
  clear_has_confirmed_gid();
}
inline ::google::protobuf::int64 EventMessage::confirmed_gid() const {
  return confirmed_gid_;
}
inline void EventMessage::set_confirmed_gid(::google::protobuf::int64 value) {
  set_has_confirmed_gid();
  confirmed_gid_ = value;
}

// required bool is_undo = 7;
inline bool EventMessage::has_is_undo() const {
  return (_has_bits_[0] & 0x00000040u) != 0;
}
inline void EventMessage::set_has_is_undo() {
  _has_bits_[0] |= 0x00000040u;
}
inline void EventMessage::clear_has_is_undo() {
  _has_bits_[0] &= ~0x00000040u;
}
inline void EventMessage::clear_is_undo() {
  is_undo_ = false;
  clear_has_is_undo();
}
inline bool EventMessage::is_undo() const {
  return is_undo_;
}
inline void EventMessage::set_is_undo(bool value) {
  set_has_is_undo();
  is_undo_ = value;
}


// @@protoc_insertion_point(namespace_scope)

}  // namespace WeWrite

#ifndef SWIG
namespace google {
namespace protobuf {


}  // namespace google
}  // namespace protobuf
#endif  // SWIG

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_EventMessage_2eproto__INCLUDED
