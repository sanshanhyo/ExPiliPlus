/**
 * This file is a part of media_kit.
 *
 * Copyright © 2021 & onwards, Hitesh Kumar Saini.
 * Use of this source code is governed by the MIT license in LICENSE.
 */
package com.alexmercerind.mediakitandroidhelper;

import android.content.Context;
import android.net.Uri;

import androidx.annotation.Keep;

@Keep
public class MediaKitAndroidHelper {
    static {
        System.loadLibrary("mediakitandroidhelper");
    }

    private static Context applicationContext;

    public static native long newGlobalObjectRef(Object object);

    public static native void deleteGlobalObjectRef(long reference);

    public static native String copyAssetToFilesDir(String assetName);

    private static native void setApplicationContextNative(Context context);

    public static void setApplicationContextJava(Context context) {
        applicationContext = context;
        setApplicationContextNative(context);
    }

    public static native int openFileDescriptorNative(String uri);

    public static int openFileDescriptorJava(String uri) {
        try {
            Uri object = Uri.parse(uri);
            return applicationContext.getContentResolver()
                    .openFileDescriptor(object, "r")
                    .detachFd();
        } catch (Throwable error) {
            error.printStackTrace();
            return -1;
        }
    }
}
