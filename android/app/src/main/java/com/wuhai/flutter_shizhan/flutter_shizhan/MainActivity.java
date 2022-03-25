package com.wuhai.flutter_shizhan.flutter_shizhan;

import android.os.Bundle;

import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import org.devio.flutter.splashscreen.SplashScreen;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //开屏页展示
        SplashScreen.show(this, true);
    }
}
