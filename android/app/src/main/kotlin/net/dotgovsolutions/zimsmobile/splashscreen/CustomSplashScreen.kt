package net.dotgovsolutions.zimsmobile.splashscreen

import android.content.Context
import android.os.Bundle
import android.view.View
import io.flutter.embedding.android.SplashScreen

class CustomSplashScreen : SplashScreen {
    override fun createSplashView(context: Context, bundle: Bundle?): View? {
        return CustomSplashView(context)
    }

    override fun transitionToFlutter(onTransitionComplete: Runnable) {
        onTransitionComplete.run()
    }
}