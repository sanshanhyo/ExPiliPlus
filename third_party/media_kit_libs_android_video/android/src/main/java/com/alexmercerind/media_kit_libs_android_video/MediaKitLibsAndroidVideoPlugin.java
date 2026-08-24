/**
 * This file is a part of media_kit.
 *
 * Copyright © 2021 & onwards, Hitesh Kumar Saini.
 * Use of this source code is governed by the MIT license in LICENSE.
 */
package com.alexmercerind.media_kit_libs_android_video;

import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;

import com.alexmercerind.mediakitandroidhelper.MediaKitAndroidHelper;

/** MediaKitLibsAndroidVideoPlugin. */
public class MediaKitLibsAndroidVideoPlugin implements FlutterPlugin {
    static {
        try {
            System.loadLibrary("mpv");
        } catch (Throwable error) {
            error.printStackTrace();
        }
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        Log.i("media_kit", "package:media_kit_libs_android_video attached.");
        try {
            MediaKitAndroidHelper.setApplicationContextJava(
                    binding.getApplicationContext());
        } catch (Throwable error) {
            error.printStackTrace();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        Log.i("media_kit", "package:media_kit_libs_android_video detached.");
    }
}
