import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class ShareToStories {
  static const String CHANNEL_NAME = "vrk.tk/share_to_stories";
  static const MethodChannel CHANNEL = MethodChannel(CHANNEL_NAME);

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
