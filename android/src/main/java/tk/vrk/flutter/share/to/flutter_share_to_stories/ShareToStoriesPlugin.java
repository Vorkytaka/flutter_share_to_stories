package tk.vrk.flutter.share.to.flutter_share_to_stories;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class ShareToStoriesPlugin implements FlutterPlugin {

    private static final String CHANNEL = "vrk.tk/share_to_stories";

    private MethodChannel methodChannel;
    private MethodCallHandler handler;
    private ShareToInstagramStories shareToInstagramStories;

    @SuppressWarnings("deprecation")
    public static void registerWith(io.flutter.plugin.common.PluginRegistry.Registrar registrar) {
        ShareToStoriesPlugin plugin = new ShareToStoriesPlugin();
        plugin.attach(registrar.context(), registrar.activity(), registrar.messenger());
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        attach(binding.getApplicationContext(), null, binding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
        shareToInstagramStories = null;
    }

    private void attach(Context context, Activity activity, BinaryMessenger messenger) {
        methodChannel = new MethodChannel(messenger, CHANNEL);
        shareToInstagramStories = new ShareToInstagramStories(context);
        shareToInstagramStories.setActivity(activity);
        handler = new MethodCallHandler(shareToInstagramStories);
        methodChannel.setMethodCallHandler(handler);
    }

    private void detach() {
        shareToInstagramStories.setActivity(null);
        methodChannel.setMethodCallHandler(null);
    }
}
