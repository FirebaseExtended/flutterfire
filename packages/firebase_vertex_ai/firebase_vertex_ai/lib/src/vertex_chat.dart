// // Copyright 2024 Google LLC
// //
// // Licensed under the Apache License, Version 2.0 (the "License");
// // you may not use this file except in compliance with the License.
// // You may obtain a copy of the License at
// //
// //     http://www.apache.org/licenses/LICENSE-2.0
// //
// // Unless required by applicable law or agreed to in writing, software
// // distributed under the License is distributed on an "AS IS" BASIS,
// // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// // See the License for the specific language governing permissions and
// // limitations under the License.

part of firebase_vertex_ai;

/// A back-and-forth chat with a generative model.
///
/// Records messages sent and received in [history]. The history will always
/// record the content from the first candidate in the
/// [GenerateContentResponse], other candidates may be available on the returned
/// response.
final class ChatSession {
  final List<Content> _history;
  final List<SafetySetting>? _safetySettings;
  final GenerationConfig? _generationConfig;
  final GenerativeModel _model;
  final google_ai.ChatSession _googleAIChatSession;

  /// Creates a new chat session with the provided model.

  ChatSession._(
      this._history, this._safetySettings, this._generationConfig, this._model)
      : _googleAIChatSession = _model.googleAIModel().startChat(
            history: _history.map((e) => e.toGoogleAIContent()).toList(),
            safetySettings: _safetySettings != null
                ? _safetySettings
                    .map((setting) => setting.toGoogleAISafetySetting())
                    .toList()
                : [],
            generationConfig: _model.generationConfig(_generationConfig));

  /// The content that has been successfully sent to, or received from, the
  /// generative model.
  ///
  /// If there are outstanding requests from calls to [sendMessage] or
  /// [sendMessageStream], these will not be reflected in the history.
  /// Messages without a candidate in the response are not recorded in history,
  /// including the message sent to the model.
  Iterable<Content> get history => _history.skip(0);

  /// Sends [message] to the model as a continuation of the chat [history].
  ///
  /// Prepends the history to the request and uses the provided model to
  /// generate new content.
  ///
  /// When there are no candidates in the response, the [message] and response
  /// are ignored and will not be recorded in the [history].
  ///
  /// Waits for any ongoing or pending requests to [sendMessage] or
  /// [sendMessageStream] to complete before generating new content.
  /// Successful messages and responses for ongoing or pending requests will
  /// be reflected in the history sent for this message.
  Future<GenerateContentResponse> sendMessage(Content message) async {
    return _googleAIChatSession.sendMessage(message.toGoogleAIContent()).then(
        (value) =>
            GenerateContentResponse.fromGoogleAIGenerateContentResponse(value));
  }

  /// Continues the chat with a new [message].
  ///
  /// Sends [message] to the model as a continuation of the chat [history] and
  /// reads the response in a stream.
  /// Prepends the history to the request and uses the provided model to
  /// generate new content.
  ///
  /// When there are no candidates in any response in the stream, the [message]
  /// and responses are ignored and will not be recorded in the [history].
  ///
  /// Waits for any ongoing or pending requests to [sendMessage] or
  /// [sendMessageStream] to complete before generating new content.
  /// Successful messages and responses for ongoing or pending requests will
  /// be reflected in the history sent for this message.
  ///
  /// Waits to read the entire streamed response before recording the message
  /// and response and allowing pending messages to be sent.
  Stream<GenerateContentResponse> sendMessageStream(Content message) {
    return _googleAIChatSession
        .sendMessageStream(message.toGoogleAIContent())
        .map((event) =>
            GenerateContentResponse.fromGoogleAIGenerateContentResponse(event));
  }
}

extension StartChatExtension on GenerativeModel {
  /// Starts a [ChatSession] that will use this model to respond to messages.
  ///
  /// ```dart
  /// final chat = model.startChat();
  /// final response = await chat.sendMessage(Content.text('Hello there.'));
  /// print(response.text);
  /// ```
  ChatSession startChat(
          {List<Content>? history,
          List<SafetySetting>? safetySettings,
          GenerationConfig? generationConfig}) =>
      ChatSession._(history ?? [], safetySettings, generationConfig, this);
}
