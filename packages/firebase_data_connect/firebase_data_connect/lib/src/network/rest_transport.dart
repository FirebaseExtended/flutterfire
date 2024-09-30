// Copyright 2024, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of firebase_data_connect_rest;

/// RestTransport makes requests out to the REST endpoints of the configured backend.
class RestTransport implements DataConnectTransport {
  /// Initializes necessary protocol and port.
  RestTransport(this.transportOptions, this.options, this.appId, this.sdkType,
      this.auth, this.appCheck) {
    String protocol = 'http';
    if (transportOptions.isSecure == null ||
        transportOptions.isSecure == true) {
      protocol += 's';
    }
    String host = transportOptions.host;
    int port = transportOptions.port ?? 443;
    String project = options.projectId;
    String location = options.location;
    String service = options.serviceId;
    String connector = options.connector;
    url =
        '$protocol://$host:$port/v1beta/projects/$project/locations/$location/services/$service/connectors/$connector';
  }

  @override
  FirebaseAuth? auth;

  @override
  FirebaseAppCheck? appCheck;

  CallerSDKType sdkType;

  /// Current endpoint URL.
  @visibleForTesting
  late String url;

  @visibleForTesting
  setHttp(http.Client client) {
    _client = client;
  }

  http.Client _client = http.Client();

  /// Current host configuration.
  @override
  TransportOptions transportOptions;

  /// Data Connect backend configuration options.
  @override
  DataConnectOptions options;

  /// Firebase application ID.
  @override
  String appId;

  /// Invokes the current operation, whether its a query or mutation.
  Future<Data> invokeOperation<Data, Variables>(
      String queryName,
      Deserializer<Data> deserializer,
      Serializer<Variables>? serializer,
      Variables? vars,
      String endpoint) async {
    String project = options.projectId;
    String location = options.location;
    String service = options.serviceId;
    String connector = options.connector;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-goog-api-client': getGoogApiVal(sdkType, packageVersion)
    };
    String? authToken;
    try {
      authToken = await auth?.currentUser?.getIdToken();
    } catch (e) {
      log('Unable to get auth token: $e');
    }
    String? appCheckToken;
    try {
      appCheckToken = await appCheck?.getToken();
    } catch (e) {
      log('Unable to get app check token: $e');
    }
    if (authToken != null) {
      headers['X-Firebase-Auth-Token'] = authToken;
    }
    if (appCheckToken != null) {
      headers['X-Firebase-AppCheck'] = appCheckToken;
    }
    headers['x-firebase-gmpid'] = appId;

    Map<String, dynamic> body = {
      'name':
          'projects/$project/locations/$location/services/$service/connectors/$connector',
      'operationName': queryName,
    };
    if (vars != null && serializer != null) {
      body['variables'] = json.decode(serializer(vars));
    }
    try {
      http.Response r = await _client.post(Uri.parse('$url:$endpoint'),
          body: json.encode(body), headers: headers);
      if (r.statusCode != 200) {
        Map<String, dynamic> bodyJson =
            jsonDecode(r.body) as Map<String, dynamic>;
        String message =
            bodyJson.containsKey('message') ? bodyJson['message']! : r.body;
        throw DataConnectError(
            r.statusCode == 401
                ? DataConnectErrorCode.unauthorized
                : DataConnectErrorCode.other,
            "Received a status code of ${r.statusCode} with a message '${message}'");
      } else {
        Map<String, dynamic> bodyJson =
            jsonDecode(r.body) as Map<String, dynamic>;
        if (bodyJson.containsKey("errors")) {
          throw DataConnectError(
              DataConnectErrorCode.other, bodyJson['errors'].toString());
        }
      }

      /// The response we get is in the data field of the response
      /// Once we get the data back, it's not quite json-encoded,
      /// so we have to encode it and then send it to the user's deserializer.
      return deserializer(jsonEncode(jsonDecode(r.body)['data']));
    } on Exception catch (e) {
      if (e is DataConnectError) {
        rethrow;
      }
      throw DataConnectError(DataConnectErrorCode.other,
          'Failed to invoke operation: ${e.toString()}');
    }
  }

  /// Invokes query REST endpoint.
  @override
  Future<Data> invokeQuery<Data, Variables>(
    String queryName,
    Deserializer<Data> deserializer,
    Serializer<Variables>? serializer,
    Variables? vars,
  ) async {
    return invokeOperation(
        queryName, deserializer, serializer, vars, 'executeQuery');
  }

  /// Invokes mutation REST endpoint.
  @override
  Future<Data> invokeMutation<Data, Variables>(
    String queryName,
    Deserializer<Data> deserializer,
    Serializer<Variables>? serializer,
    Variables? vars,
  ) async {
    return invokeOperation(
        queryName, deserializer, serializer, vars, 'executeMutation');
  }
}

/// Initializes Rest transport for Data Connect.
DataConnectTransport getTransport(
        TransportOptions transportOptions,
        DataConnectOptions options,
        String appId,
        CallerSDKType sdkType,
        FirebaseAuth? auth,
        FirebaseAppCheck? appCheck) =>
    RestTransport(transportOptions, options, appId, sdkType, auth, appCheck);
