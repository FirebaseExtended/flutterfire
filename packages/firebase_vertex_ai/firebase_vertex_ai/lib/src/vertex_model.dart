// Copyright 2024 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of firebase_vertex_ai;

const _baseUrl = 'staging-firebaseml.sandbox.googleapis.com';
//const _baseUrl = 'firebaseml.googleapis.com';
const _apiVersion = 'v2beta';

/// A multimodel generative model (like Gemini).
///
/// Allows generating content, creating embeddings, and counting the number of
/// tokens in a piece of content.
final class GenerativeModel {
  final google_ai.GenerativeModel _googleAIModel;

  /// Create a [GenerativeModel] backed by the generative model named [model].
  ///
  /// The [model] argument can be a model name (such as `'gemini-pro'`) or a
  /// model code (such as `'models/gemini-pro'`).
  /// There is no creation time check for whether the `model` string identifies
  /// a known and supported model. If not, attempts to generate content
  /// will fail.
  ///
  /// The optional [safetySettings] and [generationConfig] can be used to
  /// control and guide the generation. See [SafetySetting] and
  /// [GenerationConfig] for details.
  ///
  GenerativeModel._({
    required String modelName,
    required String location,
    required FirebaseApp app,
    List<SafetySetting>? safetySettings,
    GenerationConfig? generationConfig,
  }) : _googleAIModel = google_ai.createModelWithBaseUri(
            model: _normalizeModelName(modelName),
            baseUri: _vertexUri(app, location),
            apiKey: app.options.apiKey,
            safetySettings: safetySettings != null
                ? safetySettings
                    .map((setting) => setting.toGoogleAISafetySetting())
                    .toList()
                : [],
            generationConfig: generationConfig?.toGoogleAIGenerationConfig());

  static const _modelsPrefix = 'models/';
  static String _normalizeModelName(String modelName) =>
      modelName.startsWith(_modelsPrefix)
          ? modelName.substring(_modelsPrefix.length)
          : modelName;

  static Uri _vertexUri(FirebaseApp app, String location) {
    var projectId = app.options.projectId;
    return Uri.https(
      _baseUrl,
      '/$_apiVersion/projects/$projectId/locations/$location/publishers/google/',
    );
  }

  /// Generates content responding to [prompt].
  ///
  /// Sends a "generateContent" API request for the configured model,
  /// and waits for the response.
  ///
  /// Example:
  /// ```dart
  /// final response = await model.generateContent([Content.text(prompt)]);
  /// print(response.text);
  /// ```
  Future<GenerateContentResponse> generateContent(Iterable<Content> prompt,
      {List<SafetySetting>? safetySettings,
      GenerationConfig? generationConfig}) async {
    Iterable<google_ai.Content> googlePrompt =
        prompt.map((content) => content.toGoogleAIContent());
    List<google_ai.SafetySetting> googleSafetySettings = safetySettings != null
        ? safetySettings
            .map((setting) => setting.toGoogleAISafetySetting())
            .toList()
        : [];
    return _googleAIModel
        .generateContent(googlePrompt,
            safetySettings: googleSafetySettings,
            generationConfig: generationConfig?.toGoogleAIGenerationConfig())
        .then((value) =>
            GenerateContentResponse.fromGoogleAIGenerateContentResponse(value));
  }

  /// Generates a stream of content responding to [prompt].
  ///
  /// Sends a "streamGenerateContent" API request for the configured model,
  /// and waits for the response.
  ///
  /// Example:
  /// ```dart
  /// final responses = await model.generateContent([Content.text(prompt)]);
  /// await for (final response in responses) {
  ///   print(response.text);
  /// }
  /// ```
  Stream<GenerateContentResponse> generateContentStream(
      Iterable<Content> prompt,
      {List<SafetySetting>? safetySettings,
      GenerationConfig? generationConfig}) {
    return _googleAIModel
        .generateContentStream(
            prompt.map((content) => content.toGoogleAIContent()),
            safetySettings: safetySettings != null
                ? safetySettings
                    .map((setting) => setting.toGoogleAISafetySetting())
                    .toList()
                : [],
            generationConfig: generationConfig?.toGoogleAIGenerationConfig())
        .map((event) =>
            GenerateContentResponse.fromGoogleAIGenerateContentResponse(event));
  }

  /// Counts the total number of tokens in [contents].
  ///
  /// Sends a "countTokens" API request for the configured model,
  /// and waits for the response.
  ///
  /// Example:
  /// ```dart
  /// final promptContent = [Content.text(prompt)];
  /// final totalTokens =
  ///     (await model.countTokens(promptContent)).totalTokens;
  /// if (totalTokens > maxPromptSize) {
  ///   print('Prompt is too long!');
  /// } else {
  ///   final response = await model.generateContent(promptContent);
  ///   print(response.text);
  /// }
  /// ```
  Future<CountTokensResponse> countTokens(Iterable<Content> contents) async {
    return _googleAIModel
        .countTokens(contents.map((e) => e.toGoogleAIContent()))
        .then((value) =>
            CountTokensResponse.fromGoogleAICountTokensResponse(value));
  }

  /// Creates an embedding (list of float values) representing [content].
  ///
  /// Sends a "embedContent" API request for the configured model,
  /// and waits for the response.
  ///
  /// Example:
  /// ```dart
  /// final promptEmbedding =
  ///     (await model.embedContent([Content.text(prompt)])).embedding.values;
  /// ```
  Future<EmbedContentResponse> embedContent(Content content,
      {TaskType? taskType, String? title}) async {
    return _googleAIModel
        .embedContent(content.toGoogleAIContent(),
            taskType: taskType?.toGoogleAITaskType(), title: title)
        .then((value) =>
            EmbedContentResponse.fromGoogleAIEmbedContentResponse(value));
  }

  google_ai.GenerativeModel googleAIModel() => _googleAIModel;

  google_ai.GenerationConfig? generationConfig(GenerationConfig? config) {
    return config?.toGoogleAIGenerationConfig();
  }
}
