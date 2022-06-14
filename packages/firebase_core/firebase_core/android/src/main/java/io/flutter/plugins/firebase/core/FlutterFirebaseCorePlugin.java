// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
package io.flutter.plugins.firebase.core;

import static io.flutter.plugins.firebase.core.FlutterFirebasePlugin.cachedThreadPool;

import android.content.Context;
import android.os.Looper;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Flutter plugin implementation controlling the entrypoint for the Firebase SDK.
 *
 * <p>Instantiate this in an add to app scenario to gracefully handle activity and context changes.
 */
public class FlutterFirebaseCorePlugin implements FlutterPlugin, MethodChannel.MethodCallHandler, GeneratedAndroidFirebaseCore.FirebaseCoreHostApi {
  private static final String KEY_API_KEY = "apiKey";
  private static final String KEY_APP_NAME = "appName";
  private static final String KEY_APP_ID = "appId";
  private static final String KEY_MESSAGING_SENDER_ID = "messagingSenderId";
  private static final String KEY_PROJECT_ID = "projectId";
  private static final String KEY_DATABASE_URL = "databaseURL";
  private static final String KEY_STORAGE_BUCKET = "storageBucket";
  private static final String KEY_OPTIONS = "options";
  private static final String KEY_NAME = "name";
  private static final String KEY_TRACKING_ID = "trackingId";
  private static final String KEY_ENABLED = "enabled";
  private static final String KEY_IS_AUTOMATIC_DATA_COLLECTION_ENABLED =
      "isAutomaticDataCollectionEnabled";
  private static final String KEY_PLUGIN_CONSTANTS = "pluginConstants";

  private static final String CHANNEL_NAME = "plugins.flutter.io/firebase_core";

  private MethodChannel channel;
  private Context applicationContext;
  private boolean coreInitialized = false;

  /**
   * Default Constructor.
   *
   * <p>Use this constructor in an add to app scenario to gracefully handle activity and context
   * changes.
   */
  public FlutterFirebaseCorePlugin() {}

  private FlutterFirebaseCorePlugin(Context applicationContext) {
    this.applicationContext = applicationContext;
  }

  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    applicationContext = binding.getApplicationContext();
    channel = new MethodChannel(binding.getBinaryMessenger(), CHANNEL_NAME);
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    applicationContext = null;
  }

  private Map<String, String> firebaseOptionsToMap(FirebaseOptions options) {
    Map<String, String> optionsMap = new HashMap<>();

    optionsMap.put(KEY_API_KEY, options.getApiKey());
    optionsMap.put(KEY_APP_ID, options.getApplicationId());

    if (options.getGcmSenderId() != null) {
      optionsMap.put(KEY_MESSAGING_SENDER_ID, options.getGcmSenderId());
    }

    if (options.getProjectId() != null) {
      optionsMap.put(KEY_PROJECT_ID, options.getProjectId());
    }

    if (options.getDatabaseUrl() != null) {
      optionsMap.put(KEY_DATABASE_URL, options.getDatabaseUrl());
    }

    if (options.getStorageBucket() != null) {
      optionsMap.put(KEY_STORAGE_BUCKET, options.getStorageBucket());
    }

    if (options.getGaTrackingId() != null) {
      optionsMap.put(KEY_TRACKING_ID, options.getGaTrackingId());
    }

    return optionsMap;
  }

  private Task<Map<String, Object>> firebaseAppToMap(FirebaseApp firebaseApp) {
    TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

    cachedThreadPool.execute(
        () -> {
          try {
            Map<String, Object> appMap = new HashMap<>();

            appMap.put(KEY_NAME, firebaseApp.getName());
            appMap.put(KEY_OPTIONS, firebaseOptionsToMap(firebaseApp.getOptions()));

            appMap.put(
                KEY_IS_AUTOMATIC_DATA_COLLECTION_ENABLED,
                firebaseApp.isDataCollectionDefaultEnabled());
            appMap.put(
                KEY_PLUGIN_CONSTANTS,
                Tasks.await(
                    FlutterFirebasePluginRegistry.getPluginConstantsForFirebaseApp(firebaseApp)));

            taskCompletionSource.setResult(appMap);
          } catch (Exception e) {
            taskCompletionSource.setException(e);
          }
        });

    return taskCompletionSource.getTask();
  }

  private Task<List<Map<String, Object>>> initializeCore() {
    TaskCompletionSource<List<Map<String, Object>>> taskCompletionSource =
        new TaskCompletionSource<>();

    cachedThreadPool.execute(
        () -> {
          try {
            if (!coreInitialized) {
              coreInitialized = true;
            } else {
              Tasks.await(FlutterFirebasePluginRegistry.didReinitializeFirebaseCore());
            }

            List<FirebaseApp> firebaseApps = FirebaseApp.getApps(applicationContext);
            List<Map<String, Object>> firebaseAppsList = new ArrayList<>(firebaseApps.size());

            for (FirebaseApp firebaseApp : firebaseApps) {
              firebaseAppsList.add(Tasks.await(firebaseAppToMap(firebaseApp)));
            }

            taskCompletionSource.setResult(firebaseAppsList);
          } catch (Exception e) {
            taskCompletionSource.setException(e);
          }
        });

    return taskCompletionSource.getTask();
  }

  private Task<Map<String, String>> firebaseOptionsFromResource() {
    TaskCompletionSource<Map<String, String>> taskCompletionSource = new TaskCompletionSource<>();

    cachedThreadPool.execute(
        () -> {
          try {
            final FirebaseOptions options = FirebaseOptions.fromResource(applicationContext);
            if (options == null) {
              taskCompletionSource.setResult(null);
              return;
            }
            taskCompletionSource.setResult(firebaseOptionsToMap(options));
          } catch (Exception e) {
            taskCompletionSource.setException(e);
          }
        });

    return taskCompletionSource.getTask();
  }

  private Task<Void> setAutomaticDataCollectionEnabled(Map<String, Object> arguments) {
    TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

    cachedThreadPool.execute(
        () -> {
          try {
            String appName = (String) Objects.requireNonNull(arguments.get(KEY_APP_NAME));
            Boolean enabled = (Boolean) Objects.requireNonNull(arguments.get(KEY_ENABLED));
            FirebaseApp firebaseApp = FirebaseApp.getInstance(appName);
            firebaseApp.setDataCollectionDefaultEnabled(enabled);

            taskCompletionSource.setResult(null);
          } catch (Exception e) {
            taskCompletionSource.setException(e);
          }
        });

    return taskCompletionSource.getTask();
  }

  private Task<Void> setAutomaticResourceManagementEnabled(Map<String, Object> arguments) {
    TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

    cachedThreadPool.execute(
        () -> {
          try {
            String appName = (String) Objects.requireNonNull(arguments.get(KEY_APP_NAME));
            boolean enabled = (boolean) Objects.requireNonNull(arguments.get(KEY_ENABLED));
            FirebaseApp firebaseApp = FirebaseApp.getInstance(appName);
            firebaseApp.setAutomaticResourceManagementEnabled(enabled);

            taskCompletionSource.setResult(null);
          } catch (Exception e) {
            taskCompletionSource.setException(e);
          }
        });

    return taskCompletionSource.getTask();
  }

  private Task<Void> deleteApp(Map<String, Object> arguments) {
    TaskCompletionSource<Void> taskCompletionSource = new TaskCompletionSource<>();

    cachedThreadPool.execute(
        () -> {
          try {
            String appName = (String) Objects.requireNonNull(arguments.get(KEY_APP_NAME));
            FirebaseApp firebaseApp = FirebaseApp.getInstance(appName);
            try {
              firebaseApp.delete();
            } catch (IllegalStateException appNotFoundException) {
              // Ignore app not found exceptions.
            }

            taskCompletionSource.setResult(null);
          } catch (Exception e) {
            taskCompletionSource.setException(e);
          }
        });

    return taskCompletionSource.getTask();
  }

  @Override
  public void onMethodCall(MethodCall call, @NonNull final MethodChannel.Result result) {
    Task<?> methodCallTask;

    switch (call.method) {
      case "Firebase#initializeCore":
        methodCallTask = initializeCore();
        break;
      case "Firebase#optionsFromResource":
        methodCallTask = firebaseOptionsFromResource();
        break;
      case "FirebaseApp#setAutomaticDataCollectionEnabled":
        methodCallTask = setAutomaticDataCollectionEnabled(call.arguments());
        break;
      case "FirebaseApp#setAutomaticResourceManagementEnabled":
        methodCallTask = setAutomaticResourceManagementEnabled(call.arguments());
        break;
      case "FirebaseApp#delete":
        methodCallTask = deleteApp(call.arguments());
        break;
      default:
        result.notImplemented();
        return;
    }

    methodCallTask.addOnCompleteListener(
        task -> {
          if (task.isSuccessful()) {
            result.success(task.getResult());
          } else {
            Exception exception = task.getException();
            result.error("firebase_core", exception != null ? exception.getMessage() : null, null);
          }
        });
  }

  @Override
  public void intializeApp(@Nullable GeneratedAndroidFirebaseCore.PigeonInitializeAppRequest initializeAppRequest, GeneratedAndroidFirebaseCore.Result<Map<String, Object>> result) {
    TaskCompletionSource<Map<String, Object>> taskCompletionSource = new TaskCompletionSource<>();

    cachedThreadPool.execute(
      () -> {
        try {

          FirebaseOptions options =
            new FirebaseOptions.Builder()
              .setApiKey(initializeAppRequest.getApiKey())
              .setApplicationId(initializeAppRequest.getAppId())
              .setDatabaseUrl(initializeAppRequest.getDatabaseURL())
              .setGcmSenderId(initializeAppRequest.getMessagingSenderId())
              .setProjectId(initializeAppRequest.getProjectId())
              .setStorageBucket(initializeAppRequest.getStorageBucket())
              .setGaTrackingId(initializeAppRequest.getTrackingId())
              .build();
          // TODO(Salakar) hacky workaround a bug with FirebaseInAppMessaging causing the error:
          //    Can't create handler inside thread Thread[pool-3-thread-1,5,main] that has not called Looper.prepare()
          //     at com.google.firebase.inappmessaging.internal.ForegroundNotifier.<init>(ForegroundNotifier.java:61)
          try {
            Looper.prepare();
          } catch (Exception e) {
            // do nothing
          }
          FirebaseApp firebaseApp = FirebaseApp.initializeApp(applicationContext, options, initializeAppRequest.getAppName());
          taskCompletionSource.setResult(Tasks.await(firebaseAppToMap(firebaseApp)));
        } catch (Exception e) {
          taskCompletionSource.setException(e);
        }
      });

    taskCompletionSource.getTask().addOnCompleteListener(
      task -> {
        if (task.isSuccessful()) {
          result.success(task.getResult());
        } else {
          Exception exception = task.getException();
          result.error(exception);
        }
      });

  }
}
