package tk.vrk.flutter.share.to.flutter_share_to_stories;

import android.content.Intent;
import android.net.Uri;

public class ShareToInstagramStories {
    void shareToStories(Uri backgroundAssetUri, Uri stickerAssetUri, String topColor, String bottomColor) {
        if (backgroundAssetUri == null && stickerAssetUri == null) {
            throw new IllegalArgumentException("Background Asset Uri or Sticker Asset Uri must not be null");
        }

        Intent intent = new Intent("com.instagram.share.ADD_TO_STORY");

        if (backgroundAssetUri != null) {
            // TODO: get mime type
            intent.setDataAndType(backgroundAssetUri, "image/jpeg");
            intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        }

        if (stickerAssetUri != null) {
            intent.putExtra("interactive_asset_uri", stickerAssetUri);
        }

        if (topColor != null) {
            intent.putExtra("top_background_color", topColor);
        }

        if (bottomColor != null) {
            intent.putExtra("bottom_background_color", bottomColor);
        }

        // TODO: Start activity
    }
}
