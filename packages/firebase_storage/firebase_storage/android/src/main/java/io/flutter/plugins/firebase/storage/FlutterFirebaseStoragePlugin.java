// Copyright 2021 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.firebase.storage;

import android.net.Uri;
import android.util.Base64;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.FirebaseApp;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.ListResult;
import com.google.firebase.storage.StorageException;
import com.google.firebase.storage.StorageMetadata;
import com.google.firebase.storage.StorageReference;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.firebase.core.FlutterFirebasePlugin;
import io.flutter.plugins.firebase.core.FlutterFirebasePluginRegistry;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

public class FlutterFirebaseStoragePlugin
    implements FlutterFirebasePlugin,
    FlutterPlugin,
    GeneratedAndroidFirebaseStorage.FirebaseStorageHostApi {

  private MethodChannel channel;
  @Nullable
  private BinaryMessenger messenger;

  static final String STORAGE_METHOD_CHANNEL_NAME = "plugins.flutter.io/firebase_storage";
  static final String STORAGE_TASK_EVENT_NAME = "taskEvent";
  static final String DEFAULT_ERROR_CODE = "firebase_storage";

  private final Map<String, EventChannel> eventChannels = new HashMap<>();
  private final Map<String, StreamHandler> streamHandlers = new HashMap<>();

  static Map<String, Object> parseMetadata(StorageMetadata storageMetadata) {
    if (storageMetadata == null) {
      return null;
    }

    Map<String, Object> out = new HashMap<>();
    if (storageMetadata.getName() != null) {
      out.put("name", storageMetadata.getName());
    }

    if (storageMetadata.getBucket() != null) {
      out.put("bucket", storageMetadata.getBucket());
    }

    if (storageMetadata.getGeneration() != null) {
      out.put("generation", storageMetadata.getGeneration());
    }

    if (storageMetadata.getMetadataGeneration() != null) {
      out.put("metadataGeneration", storageMetadata.getMetadataGeneration());
    }

    out.put("fullPath", storageMetadata.getPath());

    out.put("size", storageMetadata.getSizeBytes());

    out.put("creationTimeMillis", storageMetadata.getCreationTimeMillis());

    out.put("updatedTimeMillis", storageMetadata.getUpdatedTimeMillis());

    if (storageMetadata.getMd5Hash() != null) {
      out.put("md5Hash", storageMetadata.getMd5Hash());
    }

    if (storageMetadata.getCacheControl() != null) {
      out.put("cacheControl", storageMetadata.getCacheControl());
    }

    if (storageMetadata.getContentDisposition() != null) {
      out.put("contentDisposition", storageMetadata.getContentDisposition());
    }

    if (storageMetadata.getContentEncoding() != null) {
      out.put("contentEncoding", storageMetadata.getContentEncoding());
    }

    if (storageMetadata.getContentLanguage() != null) {
      out.put("contentLanguage", storageMetadata.getContentLanguage());
    }

    if (storageMetadata.getContentType() != null) {
      out.put("contentType", storageMetadata.getContentType());
    }

    Map<String, String> customMetadata = new HashMap<>();
    for (String key : storageMetadata.getCustomMetadataKeys()) {
      if (storageMetadata.getCustomMetadata(key) == null) {
        customMetadata.put(key, "");
      } else {
        customMetadata.put(key, Objects.requireNonNull(storageMetadata.getCustomMetadata(key)));
      }
    }
    out.put("customMetadata", customMetadata);
    return out;
  }

  static Map<String, String> getExceptionDetails(Exception exception) {
    Map<String, String> details = new HashMap<>();
    FlutterFirebaseStorageException storageException = null;

    if (exception instanceof StorageException) {
      storageException = new FlutterFirebaseStorageException(exception, exception.getCause());
    } else if (exception.getCause() != null && exception.getCause() instanceof StorageException) {
      storageException = new FlutterFirebaseStorageException(
          (StorageException) exception.getCause(),
          exception.getCause().getCause() != null
              ? exception.getCause().getCause()
              : exception.getCause());
    }

    if (storageException != null) {
      details.put("code", storageException.getCode());
      details.put("message", storageException.getMessage());
    }

    return details;
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    initInstance(binding.getBinaryMessenger());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    FlutterFirebaseStorageTask.cancelInProgressTasks();
    channel.setMethodCallHandler(null);
    channel = null;
    messenger = null;
    GeneratedAndroidFirebaseStorage.FirebaseStorageHostApi.setup(messenger, null);

    removeEventListeners();
  }

  private void initInstance(BinaryMessenger messenger) {
    channel = new MethodChannel(messenger, STORAGE_METHOD_CHANNEL_NAME);
    FlutterFirebasePluginRegistry.registerPlugin(STORAGE_METHOD_CHANNEL_NAME, this);

    GeneratedAndroidFirebaseStorage.FirebaseStorageHostApi.setup(messenger, this);
    this.messenger = messenger;
  }

  private String registerEventChannel(String prefix, StreamHandler handler) {
    String identifier = UUID.randomUUID().toString().toLowerCase(Locale.US);
    return registerEventChannel(prefix, identifier, handler);
  }

  private String registerEventChannel(String prefix, String identifier, StreamHandler handler) {
    final String channelName = prefix + "/" + identifier;

    EventChannel channel = new EventChannel(messenger, channelName);
    channel.setStreamHandler(handler);
    eventChannels.put(identifier, channel);
    streamHandlers.put(identifier, handler);

    return identifier;
  }

  private void removeEventListeners() {
    for (String identifier : eventChannels.keySet()) {
      eventChannels.get(identifier).setStreamHandler(null);
    }
    eventChannels.clear();

    for (String identifier : streamHandlers.keySet()) {
      streamHandlers.get(identifier).onCancel(null);
    }
    streamHandlers.clear();
  }

  private FirebaseStorage getStorageFromPigeon(GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app) {
    return getStorageFromPigeon(app, null);
  }

  private FirebaseStorage getStorageFromPigeon(GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @Nullable String bucket) {
    FirebaseApp androidApp = FirebaseApp.getInstance(app.getAppName());
    if (bucket == null) {
      return FirebaseStorage.getInstance(androidApp);
    } else {
      return FirebaseStorage.getInstance(androidApp, "gs://" + bucket);
    }
  }

  private FirebaseStorage getStorage(Map<String, Object> arguments) {
    String appName = (String) Objects.requireNonNull(arguments.get("appName"));
    FirebaseApp app = FirebaseApp.getInstance(appName);
    String bucket = (String) arguments.get("bucket");

    FirebaseStorage storage;

    if (bucket == null) {
      storage = FirebaseStorage.getInstance(app);
    } else {
      storage = FirebaseStorage.getInstance(app, "gs://" + bucket);
    }

    Object maxOperationRetryTime = arguments.get("maxOperationRetryTime");
    if (maxOperationRetryTime != null) {
      storage.setMaxOperationRetryTimeMillis(getLongValue(maxOperationRetryTime));
    }

    Object maxDownloadRetryTime = arguments.get("maxDownloadRetryTime");
    if (maxDownloadRetryTime != null) {
      storage.setMaxDownloadRetryTimeMillis(getLongValue(maxDownloadRetryTime));
    }

    Object maxUploadRetryTime = arguments.get("maxUploadRetryTime");
    if (maxUploadRetryTime != null) {
      storage.setMaxUploadRetryTimeMillis(getLongValue(maxUploadRetryTime));
    }

    return storage;
  }

  private StorageReference getReferenceFromPigeon(GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      GeneratedAndroidFirebaseStorage.PigeonStorageReference reference) {
    FirebaseStorage androidStorage = getStorageFromPigeon(app, reference.getBucket());
    return androidStorage.getReference(reference.getFullPath());
  }

  private StorageReference getReference(Map<String, Object> arguments) {
    String path = (String) Objects.requireNonNull(arguments.get("path"));
    return getStorage(arguments).getReference(path);
  }

  private GeneratedAndroidFirebaseStorage.PigeonStorageReference convertToPigeonReference(StorageReference reference) {
    return new GeneratedAndroidFirebaseStorage.PigeonStorageReference.Builder()
        .setBucket(reference.getBucket())
        .setFullPath(reference.getPath())
        .setName(reference.getName())
        .build();
  }

  @Override
  public void getReferencebyPath(
      @NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app, @NonNull String path,
      @Nullable String bucket,
      @NonNull GeneratedAndroidFirebaseStorage.Result<GeneratedAndroidFirebaseStorage.PigeonStorageReference> result) {
    StorageReference androidReference = getStorageFromPigeon(app, bucket).getReference(path);

    result.success(convertToPigeonReference(androidReference));
  }

  private Map<String, Object> parseListResult(ListResult listResult) {
    Map<String, Object> out = new HashMap<>();

    if (listResult.getPageToken() != null) {
      out.put("nextPageToken", listResult.getPageToken());
    }

    List<String> items = new ArrayList<>();
    List<String> prefixes = new ArrayList<>();

    for (StorageReference reference : listResult.getItems()) {
      items.add(reference.getPath());
    }

    for (StorageReference reference : listResult.getPrefixes()) {
      prefixes.add(reference.getPath());
    }

    out.put("items", items);
    out.put("prefixes", prefixes);
    return out;
  }

  @Override
  public void useStorageEmulator(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app, @NonNull String host,
      @NonNull Long port,
      @NonNull GeneratedAndroidFirebaseStorage.Result<Void> result) {
    try {
      FirebaseStorage androidStorage = getStorageFromPigeon(app);
      androidStorage.useEmulator(host, port.intValue());
      result.success(null);
    } catch (Exception e) {
      result.error(e);
    }
  }

  // FirebaseStorageHostApi Reference releated api override
  @Override
  public void referenceDelete(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonStorageReference reference,
      @NonNull GeneratedAndroidFirebaseStorage.Result<Void> result) {
    FirebaseStorage firebaseStorage = getStorageFromPigeon(app);
    StorageReference androidReference = firebaseStorage.getReference(reference.getFullPath());
    androidReference.delete().addOnCompleteListener(
        task -> {
          if (task.isSuccessful()) {
            result.success(null);
          } else {
            result.error(
                task.getException());
          }
        });

  }

  @Override
  public void referenceGetDownloadURL(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonStorageReference reference,
      @NonNull GeneratedAndroidFirebaseStorage.Result<String> result) {
    FirebaseStorage firebaseStorage = getStorageFromPigeon(app);
    StorageReference androidReference = firebaseStorage.getReference(reference.getFullPath());
    androidReference.getDownloadUrl().addOnCompleteListener(
        task -> {
          if (task.isSuccessful()) {
            Uri androidUrl = task.getResult();
            result.success(androidUrl.toString());
          } else {
            result.error(
                task.getException());
          }
        });
  }

  @Override
  public void referenceGetData(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonStorageReference reference,
      @NonNull Long maxSize, @NonNull GeneratedAndroidFirebaseStorage.Result<byte[]> result) {
    FirebaseStorage firebaseStorage = getStorageFromPigeon(app);
    StorageReference androidReference = firebaseStorage.getReference(reference.getFullPath());
    androidReference.getBytes(maxSize).addOnCompleteListener(
        task -> {
          if (task.isSuccessful()) {
            byte[] androidData = task.getResult();
            result.success(androidData);
          } else {
            result.error(
                task.getException());
          }
        });
  }

  GeneratedAndroidFirebaseStorage.PigeonFullMetaData convertToPigeonMetaData(StorageMetadata meteData) {
    return new GeneratedAndroidFirebaseStorage.PigeonFullMetaData.Builder().setMetadata(parseMetadata(meteData))
        .build();
  }

  @Override
  public void referenceGetMetaData(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonStorageReference reference,
      @NonNull GeneratedAndroidFirebaseStorage.Result<GeneratedAndroidFirebaseStorage.PigeonFullMetaData> result) {
    FirebaseStorage firebaseStorage = getStorageFromPigeon(app);
    StorageReference androidReference = firebaseStorage.getReference(reference.getFullPath());
    androidReference.getMetadata().addOnCompleteListener(
        task -> {
          if (task.isSuccessful()) {
            StorageMetadata androidMetaData = task.getResult();
            result.success(convertToPigeonMetaData(androidMetaData));
          } else {
            result.error(
                task.getException());
          }
        });
  }

  GeneratedAndroidFirebaseStorage.PigeonListResult convertToPigeonListResult(ListResult listResult) {
    List<GeneratedAndroidFirebaseStorage.PigeonStorageReference> pigeonItems = new ArrayList<>();
    for (StorageReference storageReference : listResult.getItems()) {
      pigeonItems.add(convertToPigeonReference(storageReference));
    }
    List<GeneratedAndroidFirebaseStorage.PigeonStorageReference> pigeonPrefixes = new ArrayList<>();
    for (StorageReference storageReference : listResult.getPrefixes()) {
      pigeonPrefixes.add(convertToPigeonReference(storageReference));
    }
    return new GeneratedAndroidFirebaseStorage.PigeonListResult.Builder().setItems(pigeonItems)
        .setPageToken(listResult.getPageToken())
        .setPrefixs(pigeonPrefixes).build();
  }

  @Override
  public void referenceList(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonStorageReference reference,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonListOptions options,
      @NonNull GeneratedAndroidFirebaseStorage.Result<GeneratedAndroidFirebaseStorage.PigeonListResult> result) {
    FirebaseStorage firebaseStorage = getStorageFromPigeon(app);
    StorageReference androidReference = firebaseStorage.getReference(reference.getFullPath());
    androidReference.list(options.getMaxResults().intValue(), options.getPageToken()).addOnCompleteListener(
        task -> {
          if (task.isSuccessful()) {
            ListResult androidListResult = task.getResult();
            result.success(convertToPigeonListResult(androidListResult));
          } else {
            result.error(
                task.getException());
          }
        });
  }

  @Override
  public void referenceListAll(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonStorageReference reference,
      @NonNull GeneratedAndroidFirebaseStorage.Result<GeneratedAndroidFirebaseStorage.PigeonListResult> result) {
    FirebaseStorage firebaseStorage = getStorageFromPigeon(app);
    StorageReference androidReference = firebaseStorage.getReference(reference.getFullPath());
    androidReference.listAll().addOnCompleteListener(
        task -> {
          if (task.isSuccessful()) {
            ListResult androidListResult = task.getResult();
            result.success(convertToPigeonListResult(androidListResult));
          } else {
            result.error(
                task.getException());
          }
        });
  }

  StorageMetadata getMetaDataFromPigeon(
      GeneratedAndroidFirebaseStorage.PigeonSettableMetadata pigeonSettableMetatdata) {
    StorageMetadata.Builder androidMetaDataBuilder = new StorageMetadata.Builder()
        .setCacheControl(pigeonSettableMetatdata.getCacheControl())
        .setContentDisposition(pigeonSettableMetatdata.getContentDisposition())
        .setContentEncoding(pigeonSettableMetatdata.getContentEncoding())
        .setContentLanguage(pigeonSettableMetatdata.getContentLanguage())
        .setContentType(pigeonSettableMetatdata.getContentType());

    for (Map.Entry<String, String> entry : pigeonSettableMetatdata.getCustomMetadata().entrySet()) {
      androidMetaDataBuilder.setCustomMetadata(entry.getKey(), entry.getValue());
      // System.out.println(entry.getKey() + "/" + entry.getValue());
    }
    // pigeonSettableMetatdata.getCustomMetadata()
    // .foreach((key, value) -> androidMetaDataBuilder.setCustomMetadata(key,
    // value));
    return androidMetaDataBuilder.build();
  }

  @Override
  public void referenceUpdateMetadata(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonStorageReference reference,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonSettableMetadata metadata,
      @NonNull GeneratedAndroidFirebaseStorage.Result<GeneratedAndroidFirebaseStorage.PigeonFullMetaData> result) {
    FirebaseStorage firebaseStorage = getStorageFromPigeon(app);
    StorageReference androidReference = firebaseStorage.getReference(reference.getFullPath());
    androidReference.updateMetadata(getMetaDataFromPigeon(metadata)).addOnCompleteListener(
        task -> {
          if (task.isSuccessful()) {
            StorageMetadata androidMetadata = task.getResult();
            result.success(convertToPigeonMetaData(androidMetadata));
          } else {
            result.error(
                task.getException());
          }
        });
  }

  @Override
  public void referencePutData(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonStorageReference reference,
      @NonNull byte[] data,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonSettableMetadata settableMetaData, @NonNull Long handle,
      @NonNull GeneratedAndroidFirebaseStorage.Result<String> result) {

    StorageReference androidReference = getReferenceFromPigeon(app, reference);
    StorageMetadata androidMetaData = getMetaDataFromPigeon(settableMetaData);

    FlutterFirebaseStorageTask storageTask = FlutterFirebaseStorageTask.uploadBytes(
        handle.intValue(), androidReference, data, androidMetaData);
    try {
      TaskStateChannelStreamHandler handler = storageTask.startTaskWithMethodChannel(channel);
      result.success(registerEventChannel(
          STORAGE_METHOD_CHANNEL_NAME + "/" + STORAGE_TASK_EVENT_NAME, handler));
    } catch (Exception e) {
      result.error(e);
    }
  }

  @Override
  public void referencePutString(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonStorageReference reference,
      @NonNull String data, @NonNull Long format,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonSettableMetadata settableMetaData,
      @NonNull Long handle, @NonNull GeneratedAndroidFirebaseStorage.Result<String> result) {

    StorageReference androidReference = getReferenceFromPigeon(app, reference);
    StorageMetadata androidMetaData = getMetaDataFromPigeon(settableMetaData);

    FlutterFirebaseStorageTask storageTask = FlutterFirebaseStorageTask.uploadBytes(
        handle.intValue(), androidReference, stringToByteData(data, format.intValue()), androidMetaData);

    try {
      TaskStateChannelStreamHandler handler = storageTask.startTaskWithMethodChannel(channel);
      result.success(registerEventChannel(
          STORAGE_METHOD_CHANNEL_NAME + "/" + STORAGE_TASK_EVENT_NAME, handler));
    } catch (Exception e) {
      result.error(e);
    }
  }

  @Override
  public void referencePutFile(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonStorageReference reference,
      @NonNull String filePath, @NonNull GeneratedAndroidFirebaseStorage.PigeonSettableMetadata settableMetaData,
      @NonNull Long handle,
      @NonNull GeneratedAndroidFirebaseStorage.Result<String> result) {

    StorageReference androidReference = getReferenceFromPigeon(app, reference);
    StorageMetadata androidMetaData = getMetaDataFromPigeon(settableMetaData);

    FlutterFirebaseStorageTask storageTask = FlutterFirebaseStorageTask.uploadFile(
        handle.intValue(), androidReference, Uri.fromFile(new File(filePath)), androidMetaData);

    try {
      TaskStateChannelStreamHandler handler = storageTask.startTaskWithMethodChannel(channel);
      result.success(registerEventChannel(
          STORAGE_METHOD_CHANNEL_NAME + "/" + STORAGE_TASK_EVENT_NAME, handler));
    } catch (Exception e) {
      result.error(e);
    }
  }

  @Override
  public void referenceDownloadFile(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull GeneratedAndroidFirebaseStorage.PigeonStorageReference reference,
      @NonNull String filePath, @NonNull Long handle, @NonNull GeneratedAndroidFirebaseStorage.Result<String> result) {

    StorageReference androidReference = getReferenceFromPigeon(app, reference);
    FlutterFirebaseStorageTask storageTask = FlutterFirebaseStorageTask.downloadFile(handle.intValue(),
        androidReference,
        new File(filePath));

    try {
      TaskStateChannelStreamHandler handler = storageTask.startTaskWithMethodChannel(channel);
      result.success(registerEventChannel(
          STORAGE_METHOD_CHANNEL_NAME + "/" + STORAGE_TASK_EVENT_NAME, handler));
    } catch (Exception e) {
      result.error(e);
    }
  }

  // FirebaseStorageHostApi Task releated api override
  @Override
  public void taskPause(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull Long handle,
      @NonNull GeneratedAndroidFirebaseStorage.Result<Map<String, Object>> result) {

    FlutterFirebaseStorageTask storageTask = FlutterFirebaseStorageTask.getInProgressTaskForHandle(handle.intValue());

    if (storageTask == null) {
      Exception e = new Exception("Pause operation was called on a task which does not exist.");
      result.error(e);
      return;
    }

    Map<String, Object> statusMap = new HashMap<>();
    try {
      boolean paused = Tasks.await(storageTask.pause());
      statusMap.put("status", paused);
      if (paused) {
        statusMap.put(
            "snapshot",
            FlutterFirebaseStorageTask.parseTaskSnapshot(storageTask.getSnapshot()));
      }
      result.success(statusMap);
    } catch (Exception e) {
      result.error(e);
    }
  }

  @Override
  public void taskResume(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull Long handle,
      @NonNull GeneratedAndroidFirebaseStorage.Result<Map<String, Object>> result) {

    FlutterFirebaseStorageTask storageTask = FlutterFirebaseStorageTask.getInProgressTaskForHandle(handle.intValue());

    if (storageTask == null) {
      Exception e = new Exception("Resume operation was called on a task which does notexist.");
      result.error(e);
      return;
    }

    try {
      boolean resumed = Tasks.await(storageTask.resume());
      Map<String, Object> statusMap = new HashMap<>();
      statusMap.put("status", resumed);
      if (resumed) {
        statusMap.put(
            "snapshot",
            FlutterFirebaseStorageTask.parseTaskSnapshot(storageTask.getSnapshot()));
      }
      result.success(statusMap);
    } catch (Exception e) {
      result.error(e);
    }
  }

  @Override
  public void taskCancel(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull Long handle,
      @NonNull GeneratedAndroidFirebaseStorage.Result<Map<String, Object>> result) {
    FlutterFirebaseStorageTask storageTask = FlutterFirebaseStorageTask.getInProgressTaskForHandle(handle.intValue());
    if (storageTask == null) {
      Exception e = new Exception("Cancel operation was called on a task which does not exist.");
      result.error(e);
      return;
    }

    try {
      boolean canceled = Tasks.await(storageTask.cancel());
      Map<String, Object> statusMap = new HashMap<>();
      statusMap.put("status", canceled);
      if (canceled) {
        statusMap.put(
            "snapshot",
            FlutterFirebaseStorageTask.parseTaskSnapshot(storageTask.getSnapshot()));
      }
      result.success(statusMap);
    } catch (Exception e) {
      result.error(e);
    }
  }

  @Override
  public void setMaxOperationRetryTime(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull Long time, @NonNull GeneratedAndroidFirebaseStorage.Result<Void> result) {
    FirebaseStorage androidStorage = getStorageFromPigeon(app);
    androidStorage.setMaxOperationRetryTimeMillis(time);
    result.success(null);
  }

  @Override
  public void setMaxUploadRetryTime(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull Long time, @NonNull GeneratedAndroidFirebaseStorage.Result<Void> result) {
    FirebaseStorage androidStorage = getStorageFromPigeon(app);
    androidStorage.setMaxUploadRetryTimeMillis(time);
    result.success(null);
  }

  @Override
  public void setMaxDownloadRetryTime(@NonNull GeneratedAndroidFirebaseStorage.PigeonFirebaseApp app,
      @NonNull Long time, @NonNull GeneratedAndroidFirebaseStorage.Result<Void> result) {
    FirebaseStorage androidStorage = getStorageFromPigeon(app);
    androidStorage.setMaxDownloadRetryTimeMillis(time);
    result.success(null);
  }

  private StorageMetadata parseMetadata(Map<String, Object> metadata) {
    if (metadata == null) {
      return null;
    }

    StorageMetadata.Builder builder = new StorageMetadata.Builder();

    if (metadata.get("cacheControl") != null) {
      builder.setCacheControl((String) metadata.get("cacheControl"));
    }
    if (metadata.get("contentDisposition") != null) {
      builder.setContentDisposition((String) metadata.get("contentDisposition"));
    }
    if (metadata.get("contentEncoding") != null) {
      builder.setContentEncoding((String) metadata.get("contentEncoding"));
    }
    if (metadata.get("contentLanguage") != null) {
      builder.setContentLanguage((String) metadata.get("contentLanguage"));
    }
    if (metadata.get("contentType") != null) {
      builder.setContentType((String) metadata.get("contentType"));
    }
    if (metadata.get("customMetadata") != null) {
      @SuppressWarnings("unchecked")
      Map<String, String> customMetadata = (Map<String, String>) Objects.requireNonNull(metadata.get("customMetadata"));
      for (String key : customMetadata.keySet()) {
        builder.setCustomMetadata(key, customMetadata.get(key));
      }
    }

    return builder.build();
  }

  private byte[] stringToByteData(@NonNull String data, int format) {
    switch (format) {
      case 1: // PutStringFormat.base64
        return Base64.decode(data, Base64.DEFAULT);
      case 2: // PutStringFormat.base64Url
        return Base64.decode(data, Base64.URL_SAFE);
      default:
        return null;
    }
  }

  private Long getLongValue(Object value) {
    if (value instanceof Long) {
      return (Long) value;
    } else if (value instanceof Integer) {
      return Long.valueOf((Integer) value);
    } else {
      return 0L;
    }
  }

  @Override
  public Task<Map<String, Object>> getPluginConstantsForFirebaseApp(FirebaseApp firebaseApp) {
    TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();
    cachedThreadPool.execute(
        () -> {
          HashMap<String, Object> obj = new HashMap<String, Object>();
          taskCompletionSource.setResult(obj);
        });

    return taskCompletionSource.getTask();
  }

  @Override
  public Task<Void> didReinitializeFirebaseCore() {
    TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();
    cachedThreadPool.execute(
        () -> {
          FlutterFirebaseStorageTask.cancelInProgressTasks();
          taskCompletionSource.setResult(null);
        });

    return taskCompletionSource.getTask();
  }

}
