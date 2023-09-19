// Copyright 2023, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#ifndef PIGEON_MESSAGES_G_H_
#define PIGEON_MESSAGES_G_H_
#include <flutter/basic_message_channel.h>
#include <flutter/binary_messenger.h>
#include <flutter/encodable_value.h>
#include <flutter/standard_message_codec.h>

#include "firestore_codec.h"

#include <map>
#include <optional>
#include <string>

namespace cloud_firestore_windows {


// Generated class from Pigeon.

class FlutterError {
 public:
  explicit FlutterError(const std::string& code)
    : code_(code) {}
  explicit FlutterError(const std::string& code, const std::string& message)
    : code_(code), message_(message) {}
  explicit FlutterError(const std::string& code, const std::string& message, const flutter::EncodableValue& details)
    : code_(code), message_(message), details_(details) {}

  const std::string& code() const { return code_; }
  const std::string& message() const { return message_; }
  const flutter::EncodableValue& details() const { return details_; }

 private:
  std::string code_;
  std::string message_;
  flutter::EncodableValue details_;
};

template<class T> class ErrorOr {
 public:
  ErrorOr(const T& rhs) : v_(rhs) {}
  ErrorOr(const T&& rhs) : v_(std::move(rhs)) {}
  ErrorOr(const FlutterError& rhs) : v_(rhs) {}
  ErrorOr(const FlutterError&& rhs) : v_(std::move(rhs)) {}

  bool has_error() const { return std::holds_alternative<FlutterError>(v_); }
  const T& value() const { return std::get<T>(v_); };
  const FlutterError& error() const { return std::get<FlutterError>(v_); };

 private:
  friend class FirebaseFirestoreHostApi;
  ErrorOr() = default;
  T TakeValue() && { return std::get<T>(std::move(v_)); }

  std::variant<T, FlutterError> v_;
};


// An enumeration of document change types.
enum class DocumentChangeType {
  // Indicates a new document was added to the set of documents matching the
  // query.
  added = 0,
  // Indicates a document within the query was modified.
  modified = 1,
  // Indicates a document within the query was removed (either deleted or no
  // longer matches the query.
  removed = 2
};

// An enumeration of firestore source types.
enum class Source {
  // Causes Firestore to try to retrieve an up-to-date (server-retrieved) snapshot, but fall back to
  // returning cached data if the server can't be reached.
  serverAndCache = 0,
  // Causes Firestore to avoid the cache, generating an error if the server cannot be reached. Note
  // that the cache will still be updated if the server request succeeds. Also note that
  // latency-compensation still takes effect, so any pending write operations will be visible in the
  // returned data (merged into the server-provided data).
  server = 1,
  // Causes Firestore to immediately return a value from the cache, ignoring the server completely
  // (implying that the returned value may be stale with respect to the value on the server). If
  // there is no data in the cache to satisfy the `get` call,
  // [DocumentReference.get] will throw a [FirebaseException] and
  // [Query.get] will return an empty [QuerySnapshotPlatform] with no documents.
  cache = 2
};

enum class ServerTimestampBehavior {
  // Return null for [FieldValue.serverTimestamp()] values that have not yet
  none = 0,
  // Return local estimates for [FieldValue.serverTimestamp()] values that have not yet been set to their final value.
  estimate = 1,
  // Return the previous value for [FieldValue.serverTimestamp()] values that have not yet been set to their final value.
  previous = 2
};

// [AggregateSource] represents the source of data for an [AggregateQuery].
enum class AggregateSource {
  // Indicates that the data should be retrieved from the server.
  server = 0
};

enum class PigeonTransactionResult {
  success = 0,
  failure = 1
};

enum class PigeonTransactionType {
  get = 0,
  update = 1,
  set = 2,
  deleteType = 3
};

// Generated class from Pigeon that represents data sent in messages.
class PigeonFirebaseSettings {
 public:
  // Constructs an object setting all non-nullable fields.
  explicit PigeonFirebaseSettings(bool ignore_undefined_properties);

  // Constructs an object setting all fields.
  explicit PigeonFirebaseSettings(
    const bool* persistence_enabled,
    const std::string* host,
    const bool* ssl_enabled,
    const int64_t* cache_size_bytes,
    bool ignore_undefined_properties);

  const bool* persistence_enabled() const;
  void set_persistence_enabled(const bool* value_arg);
  void set_persistence_enabled(bool value_arg);

  const std::string* host() const;
  void set_host(const std::string_view* value_arg);
  void set_host(std::string_view value_arg);

  const bool* ssl_enabled() const;
  void set_ssl_enabled(const bool* value_arg);
  void set_ssl_enabled(bool value_arg);

  const int64_t* cache_size_bytes() const;
  void set_cache_size_bytes(const int64_t* value_arg);
  void set_cache_size_bytes(int64_t value_arg);

  bool ignore_undefined_properties() const;
  void set_ignore_undefined_properties(bool value_arg);


 private:
  static PigeonFirebaseSettings FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class PigeonFirebaseApp;
  friend class FirebaseFirestoreHostApi;
  friend class FirebaseFirestoreHostApiCodecSerializer;
  std::optional<bool> persistence_enabled_;
  std::optional<std::string> host_;
  std::optional<bool> ssl_enabled_;
  std::optional<int64_t> cache_size_bytes_;
  bool ignore_undefined_properties_;

};


// Generated class from Pigeon that represents data sent in messages.
class PigeonFirebaseApp {
 public:
  // Constructs an object setting all fields.
  explicit PigeonFirebaseApp(
    const std::string& app_name,
    const PigeonFirebaseSettings& settings);

  const std::string& app_name() const;
  void set_app_name(std::string_view value_arg);

  const PigeonFirebaseSettings& settings() const;
  void set_settings(const PigeonFirebaseSettings& value_arg);


 private:
  static PigeonFirebaseApp FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class FirebaseFirestoreHostApi;
  friend class FirebaseFirestoreHostApiCodecSerializer;
  std::string app_name_;
  PigeonFirebaseSettings settings_;

};


// Generated class from Pigeon that represents data sent in messages.
class PigeonSnapshotMetadata {
 public:
  // Constructs an object setting all fields.
  explicit PigeonSnapshotMetadata(
    bool has_pending_writes,
    bool is_from_cache);

  bool has_pending_writes() const;
  void set_has_pending_writes(bool value_arg);

  bool is_from_cache() const;
  void set_is_from_cache(bool value_arg);
  static PigeonSnapshotMetadata FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;


 private:
  friend class PigeonDocumentSnapshot;
  friend class PigeonQuerySnapshot;
  friend class FirebaseFirestoreHostApi;
  friend class FirebaseFirestoreHostApiCodecSerializer;
  bool has_pending_writes_;
  bool is_from_cache_;

};


// Generated class from Pigeon that represents data sent in messages.
class PigeonDocumentSnapshot {
 public:
  // Constructs an object setting all non-nullable fields.
  explicit PigeonDocumentSnapshot(
    const std::string& path,
    const PigeonSnapshotMetadata& metadata);

  // Constructs an object setting all fields.
  explicit PigeonDocumentSnapshot(
    const std::string& path,
    const flutter::EncodableMap* data,
    const PigeonSnapshotMetadata& metadata);

  const std::string& path() const;
  void set_path(std::string_view value_arg);

  const flutter::EncodableMap* data() const;
  void set_data(const flutter::EncodableMap* value_arg);
  void set_data(const flutter::EncodableMap& value_arg);

  const PigeonSnapshotMetadata& metadata() const;
  void set_metadata(const PigeonSnapshotMetadata& value_arg);
  static PigeonDocumentSnapshot FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;



 private:
  friend class PigeonDocumentChange;
  friend class FirebaseFirestoreHostApi;
  friend class FirebaseFirestoreHostApiCodecSerializer;
  std::string path_;
  std::optional<flutter::EncodableMap> data_;
  PigeonSnapshotMetadata metadata_;

};


// Generated class from Pigeon that represents data sent in messages.
class PigeonDocumentChange {
 public:
  // Constructs an object setting all fields.
  explicit PigeonDocumentChange(
    const DocumentChangeType& type,
    const PigeonDocumentSnapshot& document,
    int64_t old_index,
    int64_t new_index);

  const DocumentChangeType& type() const;
  void set_type(const DocumentChangeType& value_arg);

  const PigeonDocumentSnapshot& document() const;
  void set_document(const PigeonDocumentSnapshot& value_arg);

  int64_t old_index() const;
  void set_old_index(int64_t value_arg);

  int64_t new_index() const;
  void set_new_index(int64_t value_arg);
    static PigeonDocumentChange FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;



 private:
  friend class FirebaseFirestoreHostApi;
  friend class FirebaseFirestoreHostApiCodecSerializer;
  DocumentChangeType type_;
  PigeonDocumentSnapshot document_;
  int64_t old_index_;
  int64_t new_index_;

};


// Generated class from Pigeon that represents data sent in messages.
class PigeonQuerySnapshot {
 public:
  // Constructs an object setting all fields.
  explicit PigeonQuerySnapshot(
    const flutter::EncodableList& documents,
    const flutter::EncodableList& document_changes,
    const PigeonSnapshotMetadata& metadata);

  const flutter::EncodableList& documents() const;
  void set_documents(const flutter::EncodableList& value_arg);

  const flutter::EncodableList& document_changes() const;
  void set_document_changes(const flutter::EncodableList& value_arg);

  const PigeonSnapshotMetadata& metadata() const;
  void set_metadata(const PigeonSnapshotMetadata& value_arg);


 private:
  static PigeonQuerySnapshot FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class FirebaseFirestoreHostApi;
  friend class FirebaseFirestoreHostApiCodecSerializer;
  flutter::EncodableList documents_;
  flutter::EncodableList document_changes_;
  PigeonSnapshotMetadata metadata_;

};


// Generated class from Pigeon that represents data sent in messages.
class PigeonGetOptions {
 public:
  // Constructs an object setting all fields.
  explicit PigeonGetOptions(
    const Source& source,
    const ServerTimestampBehavior& server_timestamp_behavior);

  const Source& source() const;
  void set_source(const Source& value_arg);

  const ServerTimestampBehavior& server_timestamp_behavior() const;
  void set_server_timestamp_behavior(const ServerTimestampBehavior& value_arg);


 private:
  static PigeonGetOptions FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class FirebaseFirestoreHostApi;
  friend class FirebaseFirestoreHostApiCodecSerializer;
  Source source_;
  ServerTimestampBehavior server_timestamp_behavior_;

};


// Generated class from Pigeon that represents data sent in messages.
class PigeonDocumentOption {
 public:
  // Constructs an object setting all non-nullable fields.
  PigeonDocumentOption();

  // Constructs an object setting all fields.
  explicit PigeonDocumentOption(
    const bool* merge,
    const flutter::EncodableList* merge_fields);

  const bool* merge() const;
  void set_merge(const bool* value_arg);
  void set_merge(bool value_arg);

  const flutter::EncodableList* merge_fields() const;
  void set_merge_fields(const flutter::EncodableList* value_arg);
  void set_merge_fields(const flutter::EncodableList& value_arg);


 private:
  static PigeonDocumentOption FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class PigeonTransactionCommand;
  friend class DocumentReferenceRequest;
  friend class FirebaseFirestoreHostApi;
  friend class FirebaseFirestoreHostApiCodecSerializer;
  std::optional<bool> merge_;
  std::optional<flutter::EncodableList> merge_fields_;

};


// Generated class from Pigeon that represents data sent in messages.
class PigeonTransactionCommand {
 public:
  // Constructs an object setting all non-nullable fields.
  explicit PigeonTransactionCommand(
    const PigeonTransactionType& type,
    const std::string& path);

  // Constructs an object setting all fields.
  explicit PigeonTransactionCommand(
    const PigeonTransactionType& type,
    const std::string& path,
    const flutter::EncodableMap* data,
    const PigeonDocumentOption* option);

  const PigeonTransactionType& type() const;
  void set_type(const PigeonTransactionType& value_arg);

  const std::string& path() const;
  void set_path(std::string_view value_arg);

  const flutter::EncodableMap* data() const;
  void set_data(const flutter::EncodableMap* value_arg);
  void set_data(const flutter::EncodableMap& value_arg);

  const PigeonDocumentOption* option() const;
  void set_option(const PigeonDocumentOption* value_arg);
  void set_option(const PigeonDocumentOption& value_arg);


 private:
  static PigeonTransactionCommand FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class FirebaseFirestoreHostApi;
  friend class FirebaseFirestoreHostApiCodecSerializer;
  PigeonTransactionType type_;
  std::string path_;
  std::optional<flutter::EncodableMap> data_;
  std::optional<PigeonDocumentOption> option_;

};


// Generated class from Pigeon that represents data sent in messages.
class DocumentReferenceRequest {
 public:
  // Constructs an object setting all non-nullable fields.
  explicit DocumentReferenceRequest(const std::string& path);

  // Constructs an object setting all fields.
  explicit DocumentReferenceRequest(
    const std::string& path,
    const flutter::EncodableMap* data,
    const PigeonDocumentOption* option,
    const Source* source,
    const ServerTimestampBehavior* server_timestamp_behavior);

  const std::string& path() const;
  void set_path(std::string_view value_arg);

  const flutter::EncodableMap* data() const;
  void set_data(const flutter::EncodableMap* value_arg);
  void set_data(const flutter::EncodableMap& value_arg);

  const PigeonDocumentOption* option() const;
  void set_option(const PigeonDocumentOption* value_arg);
  void set_option(const PigeonDocumentOption& value_arg);

  const Source* source() const;
  void set_source(const Source* value_arg);
  void set_source(const Source& value_arg);

  const ServerTimestampBehavior* server_timestamp_behavior() const;
  void set_server_timestamp_behavior(const ServerTimestampBehavior* value_arg);
  void set_server_timestamp_behavior(const ServerTimestampBehavior& value_arg);


 private:
  static DocumentReferenceRequest FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class FirebaseFirestoreHostApi;
  friend class FirebaseFirestoreHostApiCodecSerializer;
  std::string path_;
  std::optional<flutter::EncodableMap> data_;
  std::optional<PigeonDocumentOption> option_;
  std::optional<Source> source_;
  std::optional<ServerTimestampBehavior> server_timestamp_behavior_;

};


// Generated class from Pigeon that represents data sent in messages.
class PigeonQueryParameters {
 public:
  // Constructs an object setting all non-nullable fields.
  PigeonQueryParameters();

  // Constructs an object setting all fields.
  explicit PigeonQueryParameters(
    const flutter::EncodableList* where,
    const flutter::EncodableList* order_by,
    const int64_t* limit,
    const int64_t* limit_to_last,
    const flutter::EncodableList* start_at,
    const flutter::EncodableList* start_after,
    const flutter::EncodableList* end_at,
    const flutter::EncodableList* end_before,
    const flutter::EncodableMap* filters);

  const flutter::EncodableList* where() const;
  void set_where(const flutter::EncodableList* value_arg);
  void set_where(const flutter::EncodableList& value_arg);

  const flutter::EncodableList* order_by() const;
  void set_order_by(const flutter::EncodableList* value_arg);
  void set_order_by(const flutter::EncodableList& value_arg);

  const int64_t* limit() const;
  void set_limit(const int64_t* value_arg);
  void set_limit(int64_t value_arg);

  const int64_t* limit_to_last() const;
  void set_limit_to_last(const int64_t* value_arg);
  void set_limit_to_last(int64_t value_arg);

  const flutter::EncodableList* start_at() const;
  void set_start_at(const flutter::EncodableList* value_arg);
  void set_start_at(const flutter::EncodableList& value_arg);

  const flutter::EncodableList* start_after() const;
  void set_start_after(const flutter::EncodableList* value_arg);
  void set_start_after(const flutter::EncodableList& value_arg);

  const flutter::EncodableList* end_at() const;
  void set_end_at(const flutter::EncodableList* value_arg);
  void set_end_at(const flutter::EncodableList& value_arg);

  const flutter::EncodableList* end_before() const;
  void set_end_before(const flutter::EncodableList* value_arg);
  void set_end_before(const flutter::EncodableList& value_arg);

  const flutter::EncodableMap* filters() const;
  void set_filters(const flutter::EncodableMap* value_arg);
  void set_filters(const flutter::EncodableMap& value_arg);


 private:
  static PigeonQueryParameters FromEncodableList(const flutter::EncodableList& list);
  flutter::EncodableList ToEncodableList() const;
  friend class FirebaseFirestoreHostApi;
  friend class FirebaseFirestoreHostApiCodecSerializer;
  std::optional<flutter::EncodableList> where_;
  std::optional<flutter::EncodableList> order_by_;
  std::optional<int64_t> limit_;
  std::optional<int64_t> limit_to_last_;
  std::optional<flutter::EncodableList> start_at_;
  std::optional<flutter::EncodableList> start_after_;
  std::optional<flutter::EncodableList> end_at_;
  std::optional<flutter::EncodableList> end_before_;
  std::optional<flutter::EncodableMap> filters_;

};

class FirebaseFirestoreHostApiCodecSerializer
    : public cloud_firestore_windows::FirestoreCodec {
 public:
  FirebaseFirestoreHostApiCodecSerializer();
  inline static FirebaseFirestoreHostApiCodecSerializer& GetInstance() {
    static FirebaseFirestoreHostApiCodecSerializer sInstance;
    return sInstance;
  }

  void WriteValue(
    const flutter::EncodableValue& value,
    flutter::ByteStreamWriter* stream) const override;

 protected:
  flutter::EncodableValue ReadValueOfType(
    uint8_t type,
    flutter::ByteStreamReader* stream) const override;

};

// Generated interface from Pigeon that represents a handler of messages from Flutter.
class FirebaseFirestoreHostApi {
 public:
  FirebaseFirestoreHostApi(const FirebaseFirestoreHostApi&) = delete;
  FirebaseFirestoreHostApi& operator=(const FirebaseFirestoreHostApi&) = delete;
  virtual ~FirebaseFirestoreHostApi() {}
  virtual void LoadBundle(
    const PigeonFirebaseApp& app,
    const std::vector<uint8_t>& bundle,
    std::function<void(ErrorOr<std::string> reply)> result) = 0;
  virtual void NamedQueryGet(
    const PigeonFirebaseApp& app,
    const std::string& name,
    const PigeonGetOptions& options,
    std::function<void(ErrorOr<PigeonQuerySnapshot> reply)> result) = 0;
  virtual void ClearPersistence(
    const PigeonFirebaseApp& app,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void DisableNetwork(
    const PigeonFirebaseApp& app,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void EnableNetwork(
    const PigeonFirebaseApp& app,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void Terminate(
    const PigeonFirebaseApp& app,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void WaitForPendingWrites(
    const PigeonFirebaseApp& app,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void SetIndexConfiguration(
    const PigeonFirebaseApp& app,
    const std::string& index_configuration,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void SetLoggingEnabled(
    bool logging_enabled,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void SnapshotsInSyncSetup(
    const PigeonFirebaseApp& app,
    std::function<void(ErrorOr<std::string> reply)> result) = 0;
  virtual void TransactionCreate(
    const PigeonFirebaseApp& app,
    int64_t timeout,
    int64_t max_attempts,
    std::function<void(ErrorOr<std::string> reply)> result) = 0;
  virtual void TransactionStoreResult(
    const std::string& transaction_id,
    const PigeonTransactionResult& result_type,
    const flutter::EncodableList* commands,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void TransactionGet(
    const PigeonFirebaseApp& app,
    const std::string& transaction_id,
    const std::string& path,
    std::function<void(ErrorOr<PigeonDocumentSnapshot> reply)> result) = 0;
  virtual void DocumentReferenceSet(
    const PigeonFirebaseApp& app,
    const DocumentReferenceRequest& request,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void DocumentReferenceUpdate(
    const PigeonFirebaseApp& app,
    const DocumentReferenceRequest& request,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void DocumentReferenceGet(
    const PigeonFirebaseApp& app,
    const DocumentReferenceRequest& request,
    std::function<void(ErrorOr<PigeonDocumentSnapshot> reply)> result) = 0;
  virtual void DocumentReferenceDelete(
    const PigeonFirebaseApp& app,
    const DocumentReferenceRequest& request,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void QueryGet(
    const PigeonFirebaseApp& app,
    const std::string& path,
    bool is_collection_group,
    const PigeonQueryParameters& parameters,
    const PigeonGetOptions& options,
    std::function<void(ErrorOr<PigeonQuerySnapshot> reply)> result) = 0;
  virtual void AggregateQueryCount(
    const PigeonFirebaseApp& app,
    const std::string& path,
    const PigeonQueryParameters& parameters,
    const AggregateSource& source,
    std::function<void(ErrorOr<double> reply)> result) = 0;
  virtual void WriteBatchCommit(
    const PigeonFirebaseApp& app,
    const flutter::EncodableList& writes,
    std::function<void(std::optional<FlutterError> reply)> result) = 0;
  virtual void QuerySnapshot(
    const PigeonFirebaseApp& app,
    const std::string& path,
    bool is_collection_group,
    const PigeonQueryParameters& parameters,
    const PigeonGetOptions& options,
    bool include_metadata_changes,
    std::function<void(ErrorOr<std::string> reply)> result) = 0;
  virtual void DocumentReferenceSnapshot(
    const PigeonFirebaseApp& app,
    const DocumentReferenceRequest& parameters,
    bool include_metadata_changes,
    std::function<void(ErrorOr<std::string> reply)> result) = 0;

  // The codec used by FirebaseFirestoreHostApi.
  static const flutter::StandardMessageCodec& GetCodec();
  // Sets up an instance of `FirebaseFirestoreHostApi` to handle messages through the `binary_messenger`.
  static void SetUp(
    flutter::BinaryMessenger* binary_messenger,
    FirebaseFirestoreHostApi* api);
  static flutter::EncodableValue WrapError(std::string_view error_message);
  static flutter::EncodableValue WrapError(const FlutterError& error);

 protected:
  FirebaseFirestoreHostApi() = default;

};
}  // namespace cloud_firestore_windows
#endif  // PIGEON_MESSAGES_G_H_
