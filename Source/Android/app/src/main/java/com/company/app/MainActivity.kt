package com.company.app

import android.annotation.SuppressLint
import android.annotation.TargetApi
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.Manifest
import android.content.pm.PackageManager
import android.view.WindowManager
import android.webkit.*
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

class MainActivity : AppCompatActivity() {
    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON) // Не выключать экран
        supportActionBar?.hide() // Спрятать sidebar

        val webView = findViewById<WebView>(R.id.webView)
        webView.getSettings().setJavaScriptEnabled(true)
        webView.getSettings().domStorageEnabled = true // Включение localStorage
        webView.getSettings().mediaPlaybackRequiresUserGesture = false
        webView.loadUrl("file:///android_asset/index.html")

        val webViewClient: WebViewClient = object : WebViewClient() {
            @Deprecated("Deprecated in Java")
            override fun shouldOverrideUrlLoading(view: WebView, url: String): Boolean {
                view.loadUrl(url)
                return true
            }

            @TargetApi(Build.VERSION_CODES.N)
            override fun shouldOverrideUrlLoading(
                view: WebView,
                request: WebResourceRequest
            ): Boolean {
                //view.loadUrl(request.url.toString())
                //return true

                // Открытие во внешнем браузере
                val url = request.url.toString()
                return if (url != null && (url.startsWith("http://") || url.startsWith("https://"))) {
                    view.context.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
                    true
                } else {
                    false
                }
            }
        }

        webView.setWebViewClient(webViewClient)

        webView.webChromeClient = object : WebChromeClient() {
            override fun onGeolocationPermissionsShowPrompt(origin: String?, callback: GeolocationPermissions.Callback) {
                // Разрешить геолокацию без запроса
                callback.invoke(origin, true, false)
            }
        }

        if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION)
            != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                1
            )
        }
    }
}