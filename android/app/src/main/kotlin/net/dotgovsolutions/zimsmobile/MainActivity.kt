package net.dotgovsolutions.zimsmobile

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen
import net.dotgovsolutions.zimsmobile.splashscreen.CustomSplashScreen

class MainActivity : FlutterActivity() {
    override fun provideSplashScreen(): SplashScreen {
        return CustomSplashScreen()
    }
}
