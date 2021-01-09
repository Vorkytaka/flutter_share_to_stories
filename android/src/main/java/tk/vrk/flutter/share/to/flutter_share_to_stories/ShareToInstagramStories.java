package tk.vrk.flutter.share.to.flutter_share_to_stories;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.webkit.MimeTypeMap;

import androidx.annotation.NonNull;
import androidx.core.content.FileProvider;

import java.io.File;
import java.io.IOException;

public class ShareToInstagramStories {
    private final Context context;
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

            intent.setType("image/jpeg");
            intent.putExtra("interactive_asset_uri", uri);
            activity.grantUriPermission(
                    "com.instagram.android",
                    uri,
                    Intent.FLAG_GRANT_READ_URI_PERMISSION
            );
        }

        if (topColor != null) {
            intent.putExtra("top_background_color", topColor);
        }

        if (bottomColor != null) {
            intent.putExtra("bottom_background_color", bottomColor);
        }

        startActivity(intent);
    }

    private void startActivity(Intent intent) {
        if (context.getPackageManager().resolveActivity(intent, 0) != null) {
            if (activity != null) {
                activity.startActivityForResult(intent, 0);
            } else if (context != null) {
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                context.startActivity(intent);
            }
        }
    }

    private Uri getFile(String path) {
        File file = new File(path);
        if (!fileIsOnExternal(file)) {
            // todo: copy file to local
        }
        final Context context = getContext();
        return FileProvider.getUriForFile(
                context,
                context.getPackageName() + ".flutter.share_to_stories",
                file
        );
    }

    private boolean fileIsOnExternal(File file) {
        try {
            String filePath = file.getCanonicalPath();
            File externalDir = context.getExternalFilesDir(null);
            return externalDir != null && filePath.startsWith(externalDir.getCanonicalPath());
        } catch (IOException e) {
            return false;
        }
    }

    @NonNull
    private File getExternalFolder() {
        return new File(getContext().getExternalCacheDir(), "share_to_stories");
    }

    @NonNull
    private Context getContext() {
        if (activity != null) {
            return activity;
        }

        if (context != null) {
            return context;
        }

        throw new IllegalStateException("Both context and activity are null");
    }
}
