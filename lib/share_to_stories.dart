import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

/// Plugin for share your content to the Instagram Stories
class ShareToStories {
  static const String CHANNEL_NAME = "vrk.tk/share_to_stories";

  /// [MethodChannel] used to communicate with the platform side.
  static const MethodChannel CHANNEL = MethodChannel(CHANNEL_NAME);

  /// Open Instagram Story screen with given content
  ///
  /// On Android it's uses Implicit Intents.
  ///
  /// Not supported on iOS.
  ///
  /// [backgroundAssetUri] presents Background asset.
  /// Uri to an image asset (JPG, PNG) or video asset (H.264, H.265, WebM).
  /// Minimum dimensions 720x1280. Recommended image ratios 9:16 or 9:18.
  /// Videos can be 1080p and up to 20 seconds in duration.
  /// The Uri needs to be a content Uri to a local file on the device.
  ///
  /// [stickerAssetUri] presents Sticker asset.
  /// Uri to an image asset (JPG, PNG). Recommended dimensions: 640x480.
  /// This image will be placed as a sticker over the background.
  /// The Uri needs to be a content Uri to a local file on the device.
  ///
  /// [topColor] presents Background layer top color.
  /// A hex string color value used in conjunction with the background layer
  /// bottom color value. If both values are the same, the background layer
  /// will be a solid color. If they differ, they will be used to generate
  /// a gradient instead. Note that if you are passing a background asset,
  /// the asset will be used and these values will be ignored.
  ///
  /// [bottomColor] presents Background layer bottom color.
  /// A hex string color value used in conjunction with the background layer
  /// top color value. If both values are the same, the background layer
  /// will be a solid color. If they differ, they will be used to generate
  /// a gradient instead. Note that if you are passing a background asset,
  /// the asset will be used and these values will be ignored.
  ///
  /// For more info see
  /// https://developers.facebook.com/docs/instagram/sharing-to-stories/
  static Future<void> shareToInstagram({
    Uri backgroundAssetUri,
    Uri stickerAssetUri,
    Color topColor,
    Color bottomColor,
  }) async {
    assert(backgroundAssetUri != null || stickerAssetUri != null);

    final Map<String, String> params = Map();
    if (backgroundAssetUri != null) {
      params["backgroundAssetUri"] = backgroundAssetUri.toString();
    }
    if (stickerAssetUri != null) {
      params["stickerAssetUri"] = stickerAssetUri.toString();
    }
    if (topColor != null) {
      params["topColor"] = "#${topColor.value.toRadixString(16)}";
    }
    if (bottomColor != null) {
      params["bottomColor"] = "#${bottomColor.value.toRadixString(16)}";
    }

    return CHANNEL.invokeMethod<void>("share_to_stories/instagram", params);
  }
}
