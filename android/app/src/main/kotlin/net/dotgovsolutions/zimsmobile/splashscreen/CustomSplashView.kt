package net.dotgovsolutions.zimsmobile.splashscreen

import android.content.Context
import android.widget.RelativeLayout
import android.widget.TextView
import net.dotgovsolutions.zimsmobile.BuildConfig
import net.dotgovsolutions.zimsmobile.R

class CustomSplashView(context: Context) : RelativeLayout(context) {
    private var version: TextView

    init {
        inflate(context, R.layout.splash_screen, this)
        version = findViewById(R.id.version)
        version.text = BuildConfig.VERSION_NAME
    }
}