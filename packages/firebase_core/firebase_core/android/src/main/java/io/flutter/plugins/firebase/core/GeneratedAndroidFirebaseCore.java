// Autogenerated from Pigeon (v3.1.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package io.flutter.plugins.firebase.core;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class GeneratedAndroidFirebaseCore {

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class PigeonFirebaseOptions {
    private @NonNull String apiKey;

    public @NonNull String getApiKey() {
      return apiKey;
    }

    public void setApiKey(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"apiKey\" is null.");
      }
      this.apiKey = setterArg;
    }

    private @NonNull String appId;

    public @NonNull String getAppId() {
      return appId;
    }

    public void setAppId(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"appId\" is null.");
      }
      this.appId = setterArg;
    }

    private @NonNull String messagingSenderId;

    public @NonNull String getMessagingSenderId() {
      return messagingSenderId;
    }

    public void setMessagingSenderId(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"messagingSenderId\" is null.");
      }
      this.messagingSenderId = setterArg;
    }

    private @NonNull String projectId;

    public @NonNull String getProjectId() {
      return projectId;
    }

    public void setProjectId(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"projectId\" is null.");
      }
      this.projectId = setterArg;
    }

    private @Nullable String authDomain;

    public @Nullable String getAuthDomain() {
      return authDomain;
    }

    public void setAuthDomain(@Nullable String setterArg) {
      this.authDomain = setterArg;
    }

    private @Nullable String databaseURL;

    public @Nullable String getDatabaseURL() {
      return databaseURL;
    }

    public void setDatabaseURL(@Nullable String setterArg) {
      this.databaseURL = setterArg;
    }

    private @Nullable String storageBucket;

    public @Nullable String getStorageBucket() {
      return storageBucket;
    }

    public void setStorageBucket(@Nullable String setterArg) {
      this.storageBucket = setterArg;
    }

    private @Nullable String measurementId;

    public @Nullable String getMeasurementId() {
      return measurementId;
    }

    public void setMeasurementId(@Nullable String setterArg) {
      this.measurementId = setterArg;
    }

    private @Nullable String trackingId;

    public @Nullable String getTrackingId() {
      return trackingId;
    }

    public void setTrackingId(@Nullable String setterArg) {
      this.trackingId = setterArg;
    }

    private @Nullable String deepLinkURLScheme;

    public @Nullable String getDeepLinkURLScheme() {
      return deepLinkURLScheme;
    }

    public void setDeepLinkURLScheme(@Nullable String setterArg) {
      this.deepLinkURLScheme = setterArg;
    }

    private @Nullable String androidClientId;

    public @Nullable String getAndroidClientId() {
      return androidClientId;
    }

    public void setAndroidClientId(@Nullable String setterArg) {
      this.androidClientId = setterArg;
    }

    private @Nullable String iosClientId;

    public @Nullable String getIosClientId() {
      return iosClientId;
    }

    public void setIosClientId(@Nullable String setterArg) {
      this.iosClientId = setterArg;
    }

    private @Nullable String iosBundleId;

    public @Nullable String getIosBundleId() {
      return iosBundleId;
    }

    public void setIosBundleId(@Nullable String setterArg) {
      this.iosBundleId = setterArg;
    }

    private @Nullable String appGroupId;

    public @Nullable String getAppGroupId() {
      return appGroupId;
    }

    public void setAppGroupId(@Nullable String setterArg) {
      this.appGroupId = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private PigeonFirebaseOptions() {}

    public static final class Builder {
      private @Nullable String apiKey;

      public @NonNull Builder setApiKey(@NonNull String setterArg) {
        this.apiKey = setterArg;
        return this;
      }

      private @Nullable String appId;

      public @NonNull Builder setAppId(@NonNull String setterArg) {
        this.appId = setterArg;
        return this;
      }

      private @Nullable String messagingSenderId;

      public @NonNull Builder setMessagingSenderId(@NonNull String setterArg) {
        this.messagingSenderId = setterArg;
        return this;
      }

      private @Nullable String projectId;

      public @NonNull Builder setProjectId(@NonNull String setterArg) {
        this.projectId = setterArg;
        return this;
      }

      private @Nullable String authDomain;

      public @NonNull Builder setAuthDomain(@Nullable String setterArg) {
        this.authDomain = setterArg;
        return this;
      }

      private @Nullable String databaseURL;

      public @NonNull Builder setDatabaseURL(@Nullable String setterArg) {
        this.databaseURL = setterArg;
        return this;
      }

      private @Nullable String storageBucket;

      public @NonNull Builder setStorageBucket(@Nullable String setterArg) {
        this.storageBucket = setterArg;
        return this;
      }

      private @Nullable String measurementId;

      public @NonNull Builder setMeasurementId(@Nullable String setterArg) {
        this.measurementId = setterArg;
        return this;
      }

      private @Nullable String trackingId;

      public @NonNull Builder setTrackingId(@Nullable String setterArg) {
        this.trackingId = setterArg;
        return this;
      }

      private @Nullable String deepLinkURLScheme;

      public @NonNull Builder setDeepLinkURLScheme(@Nullable String setterArg) {
        this.deepLinkURLScheme = setterArg;
        return this;
      }

      private @Nullable String androidClientId;

      public @NonNull Builder setAndroidClientId(@Nullable String setterArg) {
        this.androidClientId = setterArg;
        return this;
      }

      private @Nullable String iosClientId;

      public @NonNull Builder setIosClientId(@Nullable String setterArg) {
        this.iosClientId = setterArg;
        return this;
      }

      private @Nullable String iosBundleId;

      public @NonNull Builder setIosBundleId(@Nullable String setterArg) {
        this.iosBundleId = setterArg;
        return this;
      }

      private @Nullable String appGroupId;

      public @NonNull Builder setAppGroupId(@Nullable String setterArg) {
        this.appGroupId = setterArg;
        return this;
      }

      public @NonNull PigeonFirebaseOptions build() {
        PigeonFirebaseOptions pigeonReturn = new PigeonFirebaseOptions();
        pigeonReturn.setApiKey(apiKey);
        pigeonReturn.setAppId(appId);
        pigeonReturn.setMessagingSenderId(messagingSenderId);
        pigeonReturn.setProjectId(projectId);
        pigeonReturn.setAuthDomain(authDomain);
        pigeonReturn.setDatabaseURL(databaseURL);
        pigeonReturn.setStorageBucket(storageBucket);
        pigeonReturn.setMeasurementId(measurementId);
        pigeonReturn.setTrackingId(trackingId);
        pigeonReturn.setDeepLinkURLScheme(deepLinkURLScheme);
        pigeonReturn.setAndroidClientId(androidClientId);
        pigeonReturn.setIosClientId(iosClientId);
        pigeonReturn.setIosBundleId(iosBundleId);
        pigeonReturn.setAppGroupId(appGroupId);
        return pigeonReturn;
      }
    }

    @NonNull
    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("apiKey", apiKey);
      toMapResult.put("appId", appId);
      toMapResult.put("messagingSenderId", messagingSenderId);
      toMapResult.put("projectId", projectId);
      toMapResult.put("authDomain", authDomain);
      toMapResult.put("databaseURL", databaseURL);
      toMapResult.put("storageBucket", storageBucket);
      toMapResult.put("measurementId", measurementId);
      toMapResult.put("trackingId", trackingId);
      toMapResult.put("deepLinkURLScheme", deepLinkURLScheme);
      toMapResult.put("androidClientId", androidClientId);
      toMapResult.put("iosClientId", iosClientId);
      toMapResult.put("iosBundleId", iosBundleId);
      toMapResult.put("appGroupId", appGroupId);
      return toMapResult;
    }

    static @NonNull PigeonFirebaseOptions fromMap(@NonNull Map<String, Object> map) {
      PigeonFirebaseOptions pigeonResult = new PigeonFirebaseOptions();
      Object apiKey = map.get("apiKey");
      pigeonResult.setApiKey((String) apiKey);
      Object appId = map.get("appId");
      pigeonResult.setAppId((String) appId);
      Object messagingSenderId = map.get("messagingSenderId");
      pigeonResult.setMessagingSenderId((String) messagingSenderId);
      Object projectId = map.get("projectId");
      pigeonResult.setProjectId((String) projectId);
      Object authDomain = map.get("authDomain");
      pigeonResult.setAuthDomain((String) authDomain);
      Object databaseURL = map.get("databaseURL");
      pigeonResult.setDatabaseURL((String) databaseURL);
      Object storageBucket = map.get("storageBucket");
      pigeonResult.setStorageBucket((String) storageBucket);
      Object measurementId = map.get("measurementId");
      pigeonResult.setMeasurementId((String) measurementId);
      Object trackingId = map.get("trackingId");
      pigeonResult.setTrackingId((String) trackingId);
      Object deepLinkURLScheme = map.get("deepLinkURLScheme");
      pigeonResult.setDeepLinkURLScheme((String) deepLinkURLScheme);
      Object androidClientId = map.get("androidClientId");
      pigeonResult.setAndroidClientId((String) androidClientId);
      Object iosClientId = map.get("iosClientId");
      pigeonResult.setIosClientId((String) iosClientId);
      Object iosBundleId = map.get("iosBundleId");
      pigeonResult.setIosBundleId((String) iosBundleId);
      Object appGroupId = map.get("appGroupId");
      pigeonResult.setAppGroupId((String) appGroupId);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class PigeonInitializeResponse {
    private @NonNull String name;

    public @NonNull String getName() {
      return name;
    }

    public void setName(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"name\" is null.");
      }
      this.name = setterArg;
    }

    private @NonNull PigeonFirebaseOptions options;

    public @NonNull PigeonFirebaseOptions getOptions() {
      return options;
    }

    public void setOptions(@NonNull PigeonFirebaseOptions setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"options\" is null.");
      }
      this.options = setterArg;
    }

    private @Nullable Boolean isAutomaticDataCollectionEnabled;

    public @Nullable Boolean getIsAutomaticDataCollectionEnabled() {
      return isAutomaticDataCollectionEnabled;
    }

    public void setIsAutomaticDataCollectionEnabled(@Nullable Boolean setterArg) {
      this.isAutomaticDataCollectionEnabled = setterArg;
    }

    private @NonNull Map<String, Object> pluginConstants;

    public @NonNull Map<String, Object> getPluginConstants() {
      return pluginConstants;
    }

    public void setPluginConstants(@NonNull Map<String, Object> setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"pluginConstants\" is null.");
      }
      this.pluginConstants = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private PigeonInitializeResponse() {}

    public static final class Builder {
      private @Nullable String name;

      public @NonNull Builder setName(@NonNull String setterArg) {
        this.name = setterArg;
        return this;
      }

      private @Nullable PigeonFirebaseOptions options;

      public @NonNull Builder setOptions(@NonNull PigeonFirebaseOptions setterArg) {
        this.options = setterArg;
        return this;
      }

      private @Nullable Boolean isAutomaticDataCollectionEnabled;

      public @NonNull Builder setIsAutomaticDataCollectionEnabled(@Nullable Boolean setterArg) {
        this.isAutomaticDataCollectionEnabled = setterArg;
        return this;
      }

      private @Nullable Map<String, Object> pluginConstants;

      public @NonNull Builder setPluginConstants(@NonNull Map<String, Object> setterArg) {
        this.pluginConstants = setterArg;
        return this;
      }

      public @NonNull PigeonInitializeResponse build() {
        PigeonInitializeResponse pigeonReturn = new PigeonInitializeResponse();
        pigeonReturn.setName(name);
        pigeonReturn.setOptions(options);
        pigeonReturn.setIsAutomaticDataCollectionEnabled(isAutomaticDataCollectionEnabled);
        pigeonReturn.setPluginConstants(pluginConstants);
        return pigeonReturn;
      }
    }

    @NonNull
    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("name", name);
      toMapResult.put("options", (options == null) ? null : options.toMap());
      toMapResult.put("isAutomaticDataCollectionEnabled", isAutomaticDataCollectionEnabled);
      toMapResult.put("pluginConstants", pluginConstants);
      return toMapResult;
    }

    static @NonNull PigeonInitializeResponse fromMap(@NonNull Map<String, Object> map) {
      PigeonInitializeResponse pigeonResult = new PigeonInitializeResponse();
      Object name = map.get("name");
      pigeonResult.setName((String) name);
      Object options = map.get("options");
      pigeonResult.setOptions(
          (options == null) ? null : PigeonFirebaseOptions.fromMap((Map) options));
      Object isAutomaticDataCollectionEnabled = map.get("isAutomaticDataCollectionEnabled");
      pigeonResult.setIsAutomaticDataCollectionEnabled((Boolean) isAutomaticDataCollectionEnabled);
      Object pluginConstants = map.get("pluginConstants");
      pigeonResult.setPluginConstants((Map<String, Object>) pluginConstants);
      return pigeonResult;
    }
  }

  public interface Result<T> {
    void success(T result);

    void error(Throwable error);
  }

  private static class FirebaseCoreHostApiCodec extends StandardMessageCodec {
    public static final FirebaseCoreHostApiCodec INSTANCE = new FirebaseCoreHostApiCodec();

    private FirebaseCoreHostApiCodec() {}

    @Override
    protected Object readValueOfType(byte type, ByteBuffer buffer) {
      switch (type) {
        case (byte) 128:
          return PigeonFirebaseOptions.fromMap((Map<String, Object>) readValue(buffer));

        case (byte) 129:
          return PigeonInitializeResponse.fromMap((Map<String, Object>) readValue(buffer));

        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(ByteArrayOutputStream stream, Object value) {
      if (value instanceof PigeonFirebaseOptions) {
        stream.write(128);
        writeValue(stream, ((PigeonFirebaseOptions) value).toMap());
      } else if (value instanceof PigeonInitializeResponse) {
        stream.write(129);
        writeValue(stream, ((PigeonInitializeResponse) value).toMap());
      } else {
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface FirebaseCoreHostApi {
    void initializeApp(
        @NonNull String appName,
        @NonNull PigeonFirebaseOptions initializeAppRequest,
        Result<PigeonInitializeResponse> result);

    void initializeCore(Result<List<PigeonInitializeResponse>> result);

    void optionsFromResource(Result<PigeonFirebaseOptions> result);

    /** The codec used by FirebaseCoreHostApi. */
    static MessageCodec<Object> getCodec() {
      return FirebaseCoreHostApiCodec.INSTANCE;
    }

    /**
     * Sets up an instance of `FirebaseCoreHostApi` to handle messages through the
     * `binaryMessenger`.
     */
    static void setup(BinaryMessenger binaryMessenger, FirebaseCoreHostApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.FirebaseCoreHostApi.initializeApp",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                Map<String, Object> wrapped = new HashMap<>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  String appNameArg = (String) args.get(0);
                  if (appNameArg == null) {
                    throw new NullPointerException("appNameArg unexpectedly null.");
                  }
                  PigeonFirebaseOptions initializeAppRequestArg =
                      (PigeonFirebaseOptions) args.get(1);
                  if (initializeAppRequestArg == null) {
                    throw new NullPointerException("initializeAppRequestArg unexpectedly null.");
                  }
                  Result<PigeonInitializeResponse> resultCallback =
                      new Result<PigeonInitializeResponse>() {
                        public void success(PigeonInitializeResponse result) {
                          wrapped.put("result", result);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          wrapped.put("error", wrapError(error));
                          reply.reply(wrapped);
                        }
                      };

                  api.initializeApp(appNameArg, initializeAppRequestArg, resultCallback);
                } catch (Error | RuntimeException exception) {
                  wrapped.put("error", wrapError(exception));
                  reply.reply(wrapped);
                }
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.FirebaseCoreHostApi.initializeCore",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                Map<String, Object> wrapped = new HashMap<>();
                try {
                  Result<List<PigeonInitializeResponse>> resultCallback =
                      new Result<List<PigeonInitializeResponse>>() {
                        public void success(List<PigeonInitializeResponse> result) {
                          wrapped.put("result", result);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          wrapped.put("error", wrapError(error));
                          reply.reply(wrapped);
                        }
                      };

                  api.initializeCore(resultCallback);
                } catch (Error | RuntimeException exception) {
                  wrapped.put("error", wrapError(exception));
                  reply.reply(wrapped);
                }
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.FirebaseCoreHostApi.optionsFromResource",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                Map<String, Object> wrapped = new HashMap<>();
                try {
                  Result<PigeonFirebaseOptions> resultCallback =
                      new Result<PigeonFirebaseOptions>() {
                        public void success(PigeonFirebaseOptions result) {
                          wrapped.put("result", result);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          wrapped.put("error", wrapError(error));
                          reply.reply(wrapped);
                        }
                      };

                  api.optionsFromResource(resultCallback);
                } catch (Error | RuntimeException exception) {
                  wrapped.put("error", wrapError(exception));
                  reply.reply(wrapped);
                }
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }

  private static class FirebaseAppHostApiCodec extends StandardMessageCodec {
    public static final FirebaseAppHostApiCodec INSTANCE = new FirebaseAppHostApiCodec();

    private FirebaseAppHostApiCodec() {}
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface FirebaseAppHostApi {
    void setAutomaticDataCollectionEnabled(
        @NonNull String appName, @NonNull Boolean enabled, Result<Void> result);

    void setAutomaticResourceManagementEnabled(
        @NonNull String appName, @NonNull Boolean enabled, Result<Void> result);

    void delete(@NonNull String appName, Result<Void> result);

    /** The codec used by FirebaseAppHostApi. */
    static MessageCodec<Object> getCodec() {
      return FirebaseAppHostApiCodec.INSTANCE;
    }

    /**
     * Sets up an instance of `FirebaseAppHostApi` to handle messages through the `binaryMessenger`.
     */
    static void setup(BinaryMessenger binaryMessenger, FirebaseAppHostApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.FirebaseAppHostApi.setAutomaticDataCollectionEnabled",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                Map<String, Object> wrapped = new HashMap<>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  String appNameArg = (String) args.get(0);
                  if (appNameArg == null) {
                    throw new NullPointerException("appNameArg unexpectedly null.");
                  }
                  Boolean enabledArg = (Boolean) args.get(1);
                  if (enabledArg == null) {
                    throw new NullPointerException("enabledArg unexpectedly null.");
                  }
                  Result<Void> resultCallback =
                      new Result<Void>() {
                        public void success(Void result) {
                          wrapped.put("result", null);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          wrapped.put("error", wrapError(error));
                          reply.reply(wrapped);
                        }
                      };

                  api.setAutomaticDataCollectionEnabled(appNameArg, enabledArg, resultCallback);
                } catch (Error | RuntimeException exception) {
                  wrapped.put("error", wrapError(exception));
                  reply.reply(wrapped);
                }
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.FirebaseAppHostApi.setAutomaticResourceManagementEnabled",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                Map<String, Object> wrapped = new HashMap<>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  String appNameArg = (String) args.get(0);
                  if (appNameArg == null) {
                    throw new NullPointerException("appNameArg unexpectedly null.");
                  }
                  Boolean enabledArg = (Boolean) args.get(1);
                  if (enabledArg == null) {
                    throw new NullPointerException("enabledArg unexpectedly null.");
                  }
                  Result<Void> resultCallback =
                      new Result<Void>() {
                        public void success(Void result) {
                          wrapped.put("result", null);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          wrapped.put("error", wrapError(error));
                          reply.reply(wrapped);
                        }
                      };

                  api.setAutomaticResourceManagementEnabled(appNameArg, enabledArg, resultCallback);
                } catch (Error | RuntimeException exception) {
                  wrapped.put("error", wrapError(exception));
                  reply.reply(wrapped);
                }
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.FirebaseAppHostApi.delete", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                Map<String, Object> wrapped = new HashMap<>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  String appNameArg = (String) args.get(0);
                  if (appNameArg == null) {
                    throw new NullPointerException("appNameArg unexpectedly null.");
                  }
                  Result<Void> resultCallback =
                      new Result<Void>() {
                        public void success(Void result) {
                          wrapped.put("result", null);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          wrapped.put("error", wrapError(error));
                          reply.reply(wrapped);
                        }
                      };

                  api.delete(appNameArg, resultCallback);
                } catch (Error | RuntimeException exception) {
                  wrapped.put("error", wrapError(exception));
                  reply.reply(wrapped);
                }
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }

  private static Map<String, Object> wrapError(Throwable exception) {
    Map<String, Object> errorMap = new HashMap<>();
    errorMap.put("message", exception.toString());
    errorMap.put("code", exception.getClass().getSimpleName());
    errorMap.put(
        "details",
        "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    return errorMap;
  }
}
