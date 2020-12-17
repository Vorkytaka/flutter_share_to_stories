package tk.vrk.flutter.share.to.flutter_share_to_stories;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.webkit.MimeTypeMap;

import androidx.core.content.FileProvider;

import java.io.File;

public class ShareToInstagramStories {
    private Context context;
    private Activity activity;

    ShareToInstagramStories(Context context) {
        this.context = context;
    }

    void setActivity(Activity activity) {
        this.activity = activity;
    }

    void shareToStories(Uri backgroundAssetUri, Uri stickerAssetUri, String topColor, String bottomColor) {
        if (backgroundAssetUri == null && stickerAssetUri == null) {
            throw new IllegalArgumentException("Background Asset Uri or Sticker Asset Uri must not be null");
        }

        Intent intent = new Intent("com.instagram.share.ADD_TO_STORY");

        intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        intent.putExtra("source_application", context.getPackageName());

        if (backgroundAssetUri != null) {
            File file = new File(backgroundAssetUri.getPath());
            Uri uri = FileProvider.getUriForFile(context, context.getPackageName() + ".flutter.share_to_stories", file);

            String ext = MimeTypeMap.getFileExtensionFromUrl(uri.getPath());
            String mimeType = MimeTypeMap.getSingleton().getMimeTypeFromExtension(ext);

            intent.setDataAndType(uri, mimeType != null ? mimeType : "image/jpeg");
        }

        if (stickerAssetUri != null) {
            File file = new File(stickerAssetUri.getPath());
            Uri uri = FileProvider.getUriForFile(context, context.getPackageName() + ".flutter.share_to_stories", file);

            intent.putExtra("interactive_asset_uri", uri);
        }

        if (topColor != null) {
            intent.putExtra("top_background_color", topColor);
        }

        if (bottomColor != null) {
            intent.putExtra("bottom_background_color", bottomColor);
        }

        if (activity.getPackageManager().resolveActivity(intent, 0) != null) {
            activity.startActivityForResult(intent, 0);
        }
    }
}
