// Autogenerated from Pigeon (v3.2.9), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package io.flutter.plugins.firebase.auth;

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
public class GeneratedAndroidFirebaseAuth {

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class PigeonMultiFactorSession {
    private @NonNull String id;

    public @NonNull String getId() {
      return id;
    }

    public void setId(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"id\" is null.");
      }
      this.id = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private PigeonMultiFactorSession() {}

    public static final class Builder {
      private @Nullable String id;

      public @NonNull Builder setId(@NonNull String setterArg) {
        this.id = setterArg;
        return this;
      }

      public @NonNull PigeonMultiFactorSession build() {
        PigeonMultiFactorSession pigeonReturn = new PigeonMultiFactorSession();
        pigeonReturn.setId(id);
        return pigeonReturn;
      }
    }

    @NonNull
    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("id", id);
      return toMapResult;
    }

    static @NonNull PigeonMultiFactorSession fromMap(@NonNull Map<String, Object> map) {
      PigeonMultiFactorSession pigeonResult = new PigeonMultiFactorSession();
      Object id = map.get("id");
      pigeonResult.setId((String) id);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class PigeonPhoneMultiFactorAssertion {
    private @NonNull String verificationId;

    public @NonNull String getVerificationId() {
      return verificationId;
    }

    public void setVerificationId(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"verificationId\" is null.");
      }
      this.verificationId = setterArg;
    }

    private @NonNull String verificationCode;

    public @NonNull String getVerificationCode() {
      return verificationCode;
    }

    public void setVerificationCode(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"verificationCode\" is null.");
      }
      this.verificationCode = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private PigeonPhoneMultiFactorAssertion() {}

    public static final class Builder {
      private @Nullable String verificationId;

      public @NonNull Builder setVerificationId(@NonNull String setterArg) {
        this.verificationId = setterArg;
        return this;
      }

      private @Nullable String verificationCode;

      public @NonNull Builder setVerificationCode(@NonNull String setterArg) {
        this.verificationCode = setterArg;
        return this;
      }

      public @NonNull PigeonPhoneMultiFactorAssertion build() {
        PigeonPhoneMultiFactorAssertion pigeonReturn = new PigeonPhoneMultiFactorAssertion();
        pigeonReturn.setVerificationId(verificationId);
        pigeonReturn.setVerificationCode(verificationCode);
        return pigeonReturn;
      }
    }

    @NonNull
    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("verificationId", verificationId);
      toMapResult.put("verificationCode", verificationCode);
      return toMapResult;
    }

    static @NonNull PigeonPhoneMultiFactorAssertion fromMap(@NonNull Map<String, Object> map) {
      PigeonPhoneMultiFactorAssertion pigeonResult = new PigeonPhoneMultiFactorAssertion();
      Object verificationId = map.get("verificationId");
      pigeonResult.setVerificationId((String) verificationId);
      Object verificationCode = map.get("verificationCode");
      pigeonResult.setVerificationCode((String) verificationCode);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class PigeonMultiFactorInfo {
    private @Nullable String displayName;

    public @Nullable String getDisplayName() {
      return displayName;
    }

    public void setDisplayName(@Nullable String setterArg) {
      this.displayName = setterArg;
    }

    private @NonNull Double enrollmentTimestamp;

    public @NonNull Double getEnrollmentTimestamp() {
      return enrollmentTimestamp;
    }

    public void setEnrollmentTimestamp(@NonNull Double setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"enrollmentTimestamp\" is null.");
      }
      this.enrollmentTimestamp = setterArg;
    }

    private @Nullable String factorId;

    public @Nullable String getFactorId() {
      return factorId;
    }

    public void setFactorId(@Nullable String setterArg) {
      this.factorId = setterArg;
    }

    private @NonNull String uid;

    public @NonNull String getUid() {
      return uid;
    }

    public void setUid(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"uid\" is null.");
      }
      this.uid = setterArg;
    }

    private @Nullable String phoneNumber;

    public @Nullable String getPhoneNumber() {
      return phoneNumber;
    }

    public void setPhoneNumber(@Nullable String setterArg) {
      this.phoneNumber = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private PigeonMultiFactorInfo() {}

    public static final class Builder {
      private @Nullable String displayName;

      public @NonNull Builder setDisplayName(@Nullable String setterArg) {
        this.displayName = setterArg;
        return this;
      }

      private @Nullable Double enrollmentTimestamp;

      public @NonNull Builder setEnrollmentTimestamp(@NonNull Double setterArg) {
        this.enrollmentTimestamp = setterArg;
        return this;
      }

      private @Nullable String factorId;

      public @NonNull Builder setFactorId(@Nullable String setterArg) {
        this.factorId = setterArg;
        return this;
      }

      private @Nullable String uid;

      public @NonNull Builder setUid(@NonNull String setterArg) {
        this.uid = setterArg;
        return this;
      }

      private @Nullable String phoneNumber;

      public @NonNull Builder setPhoneNumber(@Nullable String setterArg) {
        this.phoneNumber = setterArg;
        return this;
      }

      public @NonNull PigeonMultiFactorInfo build() {
        PigeonMultiFactorInfo pigeonReturn = new PigeonMultiFactorInfo();
        pigeonReturn.setDisplayName(displayName);
        pigeonReturn.setEnrollmentTimestamp(enrollmentTimestamp);
        pigeonReturn.setFactorId(factorId);
        pigeonReturn.setUid(uid);
        pigeonReturn.setPhoneNumber(phoneNumber);
        return pigeonReturn;
      }
    }

    @NonNull
    Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("displayName", displayName);
      toMapResult.put("enrollmentTimestamp", enrollmentTimestamp);
      toMapResult.put("factorId", factorId);
      toMapResult.put("uid", uid);
      toMapResult.put("phoneNumber", phoneNumber);
      return toMapResult;
    }

    static @NonNull PigeonMultiFactorInfo fromMap(@NonNull Map<String, Object> map) {
      PigeonMultiFactorInfo pigeonResult = new PigeonMultiFactorInfo();
      Object displayName = map.get("displayName");
      pigeonResult.setDisplayName((String) displayName);
      Object enrollmentTimestamp = map.get("enrollmentTimestamp");
      pigeonResult.setEnrollmentTimestamp((Double) enrollmentTimestamp);
      Object factorId = map.get("factorId");
      pigeonResult.setFactorId((String) factorId);
      Object uid = map.get("uid");
      pigeonResult.setUid((String) uid);
      Object phoneNumber = map.get("phoneNumber");
      pigeonResult.setPhoneNumber((String) phoneNumber);
      return pigeonResult;
    }
  }

  public interface Result<T> {
    void success(T result);

    void error(Throwable error);
  }

  private static class FirebaseAuthHostApiCodec extends StandardMessageCodec {
    public static final FirebaseAuthHostApiCodec INSTANCE = new FirebaseAuthHostApiCodec();

    private FirebaseAuthHostApiCodec() {}
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface FirebaseAuthHostApi {
    void registerIdTokenListener(@NonNull String appName, Result<String> result);

    void registerAuthStateListener(@NonNull String appName, Result<String> result);

    /** The codec used by FirebaseAuthHostApi. */
    static MessageCodec<Object> getCodec() {
      return FirebaseAuthHostApiCodec.INSTANCE;
    }

    /**
     * Sets up an instance of `FirebaseAuthHostApi` to handle messages through the
     * `binaryMessenger`.
     */
    static void setup(BinaryMessenger binaryMessenger, FirebaseAuthHostApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.FirebaseAuthHostApi.registerIdTokenListener",
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
                  Result<String> resultCallback =
                      new Result<String>() {
                        public void success(String result) {
                          wrapped.put("result", result);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          wrapped.put("error", wrapError(error));
                          reply.reply(wrapped);
                        }
                      };

                  api.registerIdTokenListener(appNameArg, resultCallback);
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
                "dev.flutter.pigeon.FirebaseAuthHostApi.registerAuthStateListener",
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
                  Result<String> resultCallback =
                      new Result<String>() {
                        public void success(String result) {
                          wrapped.put("result", result);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          wrapped.put("error", wrapError(error));
                          reply.reply(wrapped);
                        }
                      };

                  api.registerAuthStateListener(appNameArg, resultCallback);
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

  private static class MultiFactorUserHostApiCodec extends StandardMessageCodec {
    public static final MultiFactorUserHostApiCodec INSTANCE = new MultiFactorUserHostApiCodec();

    private MultiFactorUserHostApiCodec() {}

    @Override
    protected Object readValueOfType(byte type, ByteBuffer buffer) {
      switch (type) {
        case (byte) 128:
          return PigeonMultiFactorInfo.fromMap((Map<String, Object>) readValue(buffer));

        case (byte) 129:
          return PigeonMultiFactorSession.fromMap((Map<String, Object>) readValue(buffer));

        case (byte) 130:
          return PigeonPhoneMultiFactorAssertion.fromMap((Map<String, Object>) readValue(buffer));

        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(ByteArrayOutputStream stream, Object value) {
      if (value instanceof PigeonMultiFactorInfo) {
        stream.write(128);
        writeValue(stream, ((PigeonMultiFactorInfo) value).toMap());
      } else if (value instanceof PigeonMultiFactorSession) {
        stream.write(129);
        writeValue(stream, ((PigeonMultiFactorSession) value).toMap());
      } else if (value instanceof PigeonPhoneMultiFactorAssertion) {
        stream.write(130);
        writeValue(stream, ((PigeonPhoneMultiFactorAssertion) value).toMap());
      } else {
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface MultiFactorUserHostApi {
    void enrollPhone(
        @NonNull String appName,
        @NonNull PigeonPhoneMultiFactorAssertion assertion,
        @Nullable String displayName,
        Result<Void> result);

    void getSession(@NonNull String appName, Result<PigeonMultiFactorSession> result);

    void unenroll(@NonNull String appName, @Nullable String factorUid, Result<Void> result);

    void getEnrolledFactors(@NonNull String appName, Result<List<PigeonMultiFactorInfo>> result);

    /** The codec used by MultiFactorUserHostApi. */
    static MessageCodec<Object> getCodec() {
      return MultiFactorUserHostApiCodec.INSTANCE;
    }

    /**
     * Sets up an instance of `MultiFactorUserHostApi` to handle messages through the
     * `binaryMessenger`.
     */
    static void setup(BinaryMessenger binaryMessenger, MultiFactorUserHostApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.MultiFactorUserHostApi.enrollPhone",
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
                  PigeonPhoneMultiFactorAssertion assertionArg =
                      (PigeonPhoneMultiFactorAssertion) args.get(1);
                  if (assertionArg == null) {
                    throw new NullPointerException("assertionArg unexpectedly null.");
                  }
                  String displayNameArg = (String) args.get(2);
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

                  api.enrollPhone(appNameArg, assertionArg, displayNameArg, resultCallback);
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
                "dev.flutter.pigeon.MultiFactorUserHostApi.getSession",
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
                  Result<PigeonMultiFactorSession> resultCallback =
                      new Result<PigeonMultiFactorSession>() {
                        public void success(PigeonMultiFactorSession result) {
                          wrapped.put("result", result);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          wrapped.put("error", wrapError(error));
                          reply.reply(wrapped);
                        }
                      };

                  api.getSession(appNameArg, resultCallback);
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
                binaryMessenger, "dev.flutter.pigeon.MultiFactorUserHostApi.unenroll", getCodec());
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
                  String factorUidArg = (String) args.get(1);
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

                  api.unenroll(appNameArg, factorUidArg, resultCallback);
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
                "dev.flutter.pigeon.MultiFactorUserHostApi.getEnrolledFactors",
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
                  Result<List<PigeonMultiFactorInfo>> resultCallback =
                      new Result<List<PigeonMultiFactorInfo>>() {
                        public void success(List<PigeonMultiFactorInfo> result) {
                          wrapped.put("result", result);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          wrapped.put("error", wrapError(error));
                          reply.reply(wrapped);
                        }
                      };

                  api.getEnrolledFactors(appNameArg, resultCallback);
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

  private static class MultiFactoResolverHostApiCodec extends StandardMessageCodec {
    public static final MultiFactoResolverHostApiCodec INSTANCE =
        new MultiFactoResolverHostApiCodec();

    private MultiFactoResolverHostApiCodec() {}

    @Override
    protected Object readValueOfType(byte type, ByteBuffer buffer) {
      switch (type) {
        case (byte) 128:
          return PigeonMultiFactorInfo.fromMap((Map<String, Object>) readValue(buffer));

        case (byte) 129:
          return PigeonMultiFactorSession.fromMap((Map<String, Object>) readValue(buffer));

        case (byte) 130:
          return PigeonPhoneMultiFactorAssertion.fromMap((Map<String, Object>) readValue(buffer));

        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(ByteArrayOutputStream stream, Object value) {
      if (value instanceof PigeonMultiFactorInfo) {
        stream.write(128);
        writeValue(stream, ((PigeonMultiFactorInfo) value).toMap());
      } else if (value instanceof PigeonMultiFactorSession) {
        stream.write(129);
        writeValue(stream, ((PigeonMultiFactorSession) value).toMap());
      } else if (value instanceof PigeonPhoneMultiFactorAssertion) {
        stream.write(130);
        writeValue(stream, ((PigeonPhoneMultiFactorAssertion) value).toMap());
      } else {
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface MultiFactoResolverHostApi {
    void resolveSignIn(
        @NonNull String resolverId,
        @NonNull PigeonPhoneMultiFactorAssertion assertion,
        Result<Map<String, Object>> result);

    /** The codec used by MultiFactoResolverHostApi. */
    static MessageCodec<Object> getCodec() {
      return MultiFactoResolverHostApiCodec.INSTANCE;
    }

    /**
     * Sets up an instance of `MultiFactoResolverHostApi` to handle messages through the
     * `binaryMessenger`.
     */
    static void setup(BinaryMessenger binaryMessenger, MultiFactoResolverHostApi api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.MultiFactoResolverHostApi.resolveSignIn",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                Map<String, Object> wrapped = new HashMap<>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  String resolverIdArg = (String) args.get(0);
                  if (resolverIdArg == null) {
                    throw new NullPointerException("resolverIdArg unexpectedly null.");
                  }
                  PigeonPhoneMultiFactorAssertion assertionArg =
                      (PigeonPhoneMultiFactorAssertion) args.get(1);
                  if (assertionArg == null) {
                    throw new NullPointerException("assertionArg unexpectedly null.");
                  }
                  Result<Map<String, Object>> resultCallback =
                      new Result<Map<String, Object>>() {
                        public void success(Map<String, Object> result) {
                          wrapped.put("result", result);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          wrapped.put("error", wrapError(error));
                          reply.reply(wrapped);
                        }
                      };

                  api.resolveSignIn(resolverIdArg, assertionArg, resultCallback);
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

  private static class GenerateInterfacesCodec extends StandardMessageCodec {
    public static final GenerateInterfacesCodec INSTANCE = new GenerateInterfacesCodec();

    private GenerateInterfacesCodec() {}

    @Override
    protected Object readValueOfType(byte type, ByteBuffer buffer) {
      switch (type) {
        case (byte) 128:
          return PigeonMultiFactorInfo.fromMap((Map<String, Object>) readValue(buffer));

        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(ByteArrayOutputStream stream, Object value) {
      if (value instanceof PigeonMultiFactorInfo) {
        stream.write(128);
        writeValue(stream, ((PigeonMultiFactorInfo) value).toMap());
      } else {
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface GenerateInterfaces {
    void generateInterfaces(@NonNull PigeonMultiFactorInfo info);

    /** The codec used by GenerateInterfaces. */
    static MessageCodec<Object> getCodec() {
      return GenerateInterfacesCodec.INSTANCE;
    }

    /**
     * Sets up an instance of `GenerateInterfaces` to handle messages through the `binaryMessenger`.
     */
    static void setup(BinaryMessenger binaryMessenger, GenerateInterfaces api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger,
                "dev.flutter.pigeon.GenerateInterfaces.generateInterfaces",
                getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                Map<String, Object> wrapped = new HashMap<>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  PigeonMultiFactorInfo infoArg = (PigeonMultiFactorInfo) args.get(0);
                  if (infoArg == null) {
                    throw new NullPointerException("infoArg unexpectedly null.");
                  }
                  api.generateInterfaces(infoArg);
                  wrapped.put("result", null);
                } catch (Error | RuntimeException exception) {
                  wrapped.put("error", wrapError(exception));
                }
                reply.reply(wrapped);
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
