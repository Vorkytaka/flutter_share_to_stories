package tk.vrk.flutter.share.to.flutter_share_to_stories;

import android.net.Uri;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MethodCallHandler implements MethodChannel.MethodCallHandler {
    private final ShareToInstagramStories shareToInstagramStories;

    MethodCallHandler(ShareToInstagramStories instagram) {
        this.shareToInstagramStories = instagram;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "share_to_stories/instagram":
                String backgroundAssetUriString = call.argument("backgroundAssetUri");
                Uri backgroundAssetUri = null;
                if (backgroundAssetUriString != null) {
                    backgroundAssetUri = Uri.parse(backgroundAssetUriString);
                }

                String stickerAssetUriString = call.argument("stickerAssetUri");
                Uri stickerAssetUri = null;
                if (stickerAssetUriString != null) {
                    stickerAssetUri = Uri.parse(stickerAssetUriString);
                }

                String topColor = call.argument("topColor");
                String bottomColor = call.argument("bottomColor");

                shareToInstagramStories.shareToStories(backgroundAssetUri, stickerAssetUri, topColor, bottomColor);
                result.success(null);
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}
