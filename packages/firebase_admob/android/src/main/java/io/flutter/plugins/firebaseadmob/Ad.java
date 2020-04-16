package io.flutter.plugins.firebaseadmob;

import android.app.Activity;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import androidx.annotation.NonNull;
import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdLoader;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.formats.UnifiedNativeAd;
import com.google.android.gms.ads.formats.UnifiedNativeAdView;
import com.google.android.gms.ads.rewarded.RewardItem;
import com.google.android.gms.ads.rewarded.RewardedAdCallback;
import com.google.android.gms.ads.rewarded.RewardedAdLoadCallback;
import io.flutter.plugin.platform.PlatformView;
import java.util.Map;

abstract class Ad {
  final com.google.android.gms.ads.AdRequest request;
  final Activity activity;

  interface AdListenerCallbackHandler {
    void onAdLoaded(Ad ad);
  }

  abstract static class PlatformViewAd extends Ad implements PlatformView {
    private final int viewId;

    PlatformViewAd(final AdRequest request, final Activity activity) {
      super(request, activity);
      this.viewId = hashCode();
    }

    void show(double anchorOffset, double horizontalCenterOffset, final AnchorType anchorType) {
      dispose();

      final LinearLayout adViewParent = new LinearLayout(activity);
      adViewParent.setId(viewId);
      adViewParent.setOrientation(LinearLayout.VERTICAL);
      adViewParent.addView(getView());
      final float scale = activity.getResources().getDisplayMetrics().density;

      int left = horizontalCenterOffset > 0 ? (int) (horizontalCenterOffset * scale) : 0;
      int right = horizontalCenterOffset < 0 ? (int) (Math.abs(horizontalCenterOffset) * scale) : 0;
      if (anchorType == AnchorType.BOTTOM) {
        adViewParent.setPadding(left, 0, right, (int) (anchorOffset * scale));
        adViewParent.setGravity(Gravity.BOTTOM);
      } else {
        adViewParent.setPadding(left, (int) (anchorOffset * scale), right, 0);
        adViewParent.setGravity(Gravity.TOP);
      }

      activity.addContentView(
          adViewParent,
          new ViewGroup.LayoutParams(
              ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
    }

    @Override
    public void dispose() {
      final LinearLayout adViewParent = activity.findViewById(viewId);
      if (adViewParent == null) return;

      final ViewGroup rootView = (ViewGroup) adViewParent.getParent();
      rootView.removeView(adViewParent);
      adViewParent.removeView(getView());
    }
  }

  abstract static class FullScreenAd extends Ad {
    FullScreenAd(final AdRequest request, final Activity activity) {
      super(request, activity);
    }

    abstract void show();
  }

  static class BannerAd extends PlatformViewAd {
    private final AdView bannerView;
    private final com.google.android.gms.ads.AdRequest request;
    private final Activity activity;

    BannerAd(
        final String adUnitId,
        final AdRequest request,
        final AdSize adSize,
        final Activity activity,
        final AdListenerCallbackHandler callbackHandler) {
      super(request, activity);
      bannerView = new AdView(activity);
      bannerView.setAdUnitId(adUnitId);
      bannerView.setAdSize(adSize.adSize);
      bannerView.setAdListener(createAdListener(callbackHandler, this));
      this.request = request.request;
      this.activity = activity;
    }

    @Override
    void load() {
      bannerView.loadAd(request);
    }

    @Override
    public View getView() {
      return bannerView;
    }
  }

  static class InterstitialAd extends FullScreenAd {
    private final com.google.android.gms.ads.InterstitialAd interstitialAd;

    InterstitialAd(
        final String adUnitId,
        final AdRequest request,
        final Activity activity,
        final AdListenerCallbackHandler callbackHandler) {
      super(request, activity);
      interstitialAd = new com.google.android.gms.ads.InterstitialAd(activity);
      interstitialAd.setAdUnitId(adUnitId);
      interstitialAd.setAdListener(createAdListener(callbackHandler, this));
    }

    @Override
    void load() {
      interstitialAd.loadAd(request);
    }

    @Override
    void show() {
      interstitialAd.show();
    }
  }

  static class NativeAd extends PlatformViewAd
      implements UnifiedNativeAd.OnUnifiedNativeAdLoadedListener {
    private final AdLoader adLoader;
    private final FirebaseAdMobPlugin.NativeAdFactory nativeAdFactory;
    private final Map<String, Object> customOptions;
    private UnifiedNativeAdView adView;

    NativeAd(
        final String adUnitId,
        final AdRequest request,
        final Activity activity,
        final FirebaseAdMobPlugin.NativeAdFactory nativeAdFactory,
        final Map<String, Object> customOptions,
        final AdListenerCallbackHandler callbackHandler) {
      super(request, activity);
      adLoader =
          new AdLoader.Builder(activity, adUnitId)
              .forUnifiedNativeAd(this)
              .withAdListener(Ad.createAdListener(callbackHandler, this))
              .build();
      this.nativeAdFactory = nativeAdFactory;
      this.customOptions = customOptions;
    }

    @Override
    void load() {
      adLoader.loadAd(request);
    }

    @Override
    public View getView() {
      return adView;
    }

    @Override
    public void onUnifiedNativeAdLoaded(final UnifiedNativeAd unifiedNativeAd) {
      adView = nativeAdFactory.createNativeAd(unifiedNativeAd, customOptions);
    }
  }

  static class RewardedAd extends FullScreenAd {
    private final com.google.android.gms.ads.rewarded.RewardedAd rewardedAd;
    private final AdListenerCallbackHandler callbackHandler;

    RewardedAd(
        final String adUnitId,
        final AdRequest request,
        final Activity activity,
        final AdListenerCallbackHandler callbackHandler) {
      super(request, activity);
      rewardedAd = new com.google.android.gms.ads.rewarded.RewardedAd(activity, adUnitId);
      this.callbackHandler = callbackHandler;
    }

    @Override
    void load() {
      rewardedAd.loadAd(
          request,
          new RewardedAdLoadCallback() {
            public void onRewardedAdLoaded() {
              callbackHandler.onAdLoaded(RewardedAd.this);
            }

            public void onRewardedAdFailedToLoad(int errorCode) {}
          });
    }

    @Override
    void show() {
      rewardedAd.show(
          activity,
          new RewardedAdCallback() {
            @Override
            public void onRewardedAdOpened() {
              // Ad opened.
            }

            @Override
            public void onRewardedAdClosed() {
              // Ad closed.
            }

            @Override
            public void onUserEarnedReward(@NonNull RewardItem reward) {
              // User earned reward.
            }

            @Override
            public void onRewardedAdFailedToShow(int errorCode) {
              // Ad failed to display.
            }
          });
    }
  }

  private static AdListener createAdListener(
      final AdListenerCallbackHandler callbackHandler, final Ad ad) {
    return new AdListener() {
      @Override
      public void onAdLoaded() {
        callbackHandler.onAdLoaded(ad);
      }
    };
  }

  Ad(final AdRequest request, final Activity activity) {
    this.request = request.request;
    this.activity = activity;
  }

  abstract void load();
}
