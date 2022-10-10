part of cloud_firestore;

class AggregateQuery {
  AggregateQuery._(this._delegate) {
    AggregateQueryPlatform.verifyExtends(_delegate);
  }
  final AggregateQueryPlatform _delegate;

  Future<AggregateQuerySnapshot> get({required AggregateSource source}) async {
    return AggregateQuerySnapshot._(await _delegate.get(source: source));
  }
}
