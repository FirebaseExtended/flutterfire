part of firebase_database_web;

class QueryWeb extends Query {
  final DatabasePlatform _databasePlatform;
  final web.Query _delegate;
  final List<String> _pathComponents;

  QueryWeb(
    DatabasePlatform databasePlatform,
    List<String> pathComponents,
    web.Query query,
  )   : _databasePlatform = databasePlatform,
        _pathComponents = pathComponents,
        _delegate = query ??
            databasePlatform.reference().child(pathComponents.join("/"));

  /// Create a query constrained to only return child nodes with a value greater
  /// than or equal to the given value, using the given orderBy directive or
  /// priority as default, and optionally only child nodes with a key greater
  /// than or equal to the given key.
  Query startAt(dynamic value, {String key}) {
    return QueryWeb(
        _databasePlatform, _pathComponents, _delegate.startAt(value, key));
  }

  @override
  Query endAt(value, {String key}) {
    return QueryWeb(
        _databasePlatform, _pathComponents, _delegate.endAt(value, key));
  }

  @override
  Query equalTo(value, {String key}) {
    return QueryWeb(
        _databasePlatform, _pathComponents, _delegate.equalTo(value, key));
  }

  @override
  Future<void> keepSynced(bool value) {
    throw UnsupportedError("keeySynced() not supported on web");
  }

  @override
  Query limitToFirst(int limit) {
    return QueryWeb(
        _databasePlatform, _pathComponents, _delegate.limitToFirst(limit));
  }

  @override
  Query limitToLast(int limit) {
    return QueryWeb(
        _databasePlatform, _pathComponents, _delegate.limitToLast(limit));
  }

  @override

  /// Generate a view of the data sorted by values of a particular child key.
  ///
  /// Intended to be used in combination with [startAt], [endAt], or
  /// [equalTo].
  Query orderByChild(String key) {
    return QueryWeb(
        _databasePlatform, _pathComponents, _delegate.orderByChild(key));
  }

  @override

  /// Generate a view of the data sorted by key.
  ///
  /// Intended to be used in combination with [startAt], [endAt], or
  /// [equalTo].
  Query orderByKey() {
    return QueryWeb(_databasePlatform, _pathComponents, _delegate.orderByKey());
  }

  @override

  /// Generate a view of the data sorted by priority.
  ///
  /// Intended to be used in combination with [startAt], [endAt], or
  /// [equalTo].
  Query orderByPriority() {
    return QueryWeb(
        _databasePlatform, _pathComponents, _delegate.orderByValue());
  }

  @override

  /// Generate a view of the data sorted by value.
  ///
  /// Intended to be used in combination with [startAt], [endAt], or
  /// [equalTo].
  Query orderByValue() {
    return QueryWeb(
        _databasePlatform, _pathComponents, _delegate.orderByValue());
  }

  @override

  /// Slash-delimited path representing the database location of this query.
  String get path => _pathComponents.join('/');

  @override
  Stream<EventPlatform> observe(EventType eventType) {
    switch (eventType) {
      case EventType.childAdded:
        return _webStreamToPlatformStream(_delegate.onChildAdded);
        break;
      case EventType.childChanged:
        return _webStreamToPlatformStream(_delegate.onChildChanged);
        break;
      case EventType.childMoved:
        return _webStreamToPlatformStream(_delegate.onChildMoved);
        break;
      case EventType.childRemoved:
        return _webStreamToPlatformStream(_delegate.onChildRemoved);
        break;
      case EventType.value:
        return _webStreamToPlatformStream(_delegate.onValue);
        break;
      default:
        throw Exception("Invalid event type");
    }
  }

  Stream<EventPlatform> _webStreamToPlatformStream(
      Stream<web.QueryEvent> stream) {
    return stream
        .map((web.QueryEvent event) => _fromWebEventToPlatformEvent(event));
  }

  @override
  Future<EventPlatform> once() async {
    return _fromWebEventToPlatformEvent((await _delegate.once("value")));
  }

  @override
  Map<String, dynamic> buildArguments() {
    throw UnimplementedError();
  }

  /// Builds [EventPlatform] instance form web event instance
  EventPlatform _fromWebEventToPlatformEvent(web.QueryEvent event) {
    return EventPlatform(
        _fromWebSnapshotToPlatformSnapShot(event.snapshot), event.prevChildKey);
  }

  /// Builds [DataSnapshotPlatform] instance form web snapshot instance
  DataSnapshotPlatform _fromWebSnapshotToPlatformSnapShot(
      web.DataSnapshot snapshot) {
    return DataSnapshotPlatform(snapshot.key, snapshot.val());
  }
}
