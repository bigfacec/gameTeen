package com.skycraft.gameTeenPattiIntro

import android.app.AlertDialog
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.os.Process
import android.util.Log
import android.view.KeyEvent
import android.view.WindowManager
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import kotlin.system.exitProcess


class GameActivity : AppCompatActivity() {

    private var mWebView: WebView? = null
    private var mUrl: String? = null
    private var mDialog: AlertDialog.Builder? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_game)
        PokerGamePlugin.getInstance().setFinish()
        val lp = window.attributes
        lp.flags = WindowManager.LayoutParams.FLAG_FULLSCREEN
        window.attributes = lp
        window.clearFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)

        mWebView = findViewById(R.id.web_view)
        mUrl = intent.getStringExtra(EXTRA_KEY_GAME_URL)
        mWebView?.apply {
            webViewClient = mWebViewClient
            loadUrl(mUrl)
        }
        mWebView?.settings?.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            loadWithOverviewMode = true
        }

    }

    private val mWebViewClient = object : WebViewClient() {
        @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
        override fun shouldOverrideUrlLoading(view: WebView?, request: WebResourceRequest?): Boolean {
            request?.apply {
                if (url.toString().indexOf(mUrl.toString()) == -1) {
                    val intent = Intent(applicationContext, RechargeActivity::class.java)
                    intent.putExtra(EXTRA_KEY_RECHARGE_URL, url.toString())
                    startActivity(intent)
                    return true
                }
            }
            return super.shouldOverrideUrlLoading(view, request)
        }

        override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean {
            url?.apply {
                if (url.indexOf(mUrl.toString()) == -1) {
                    val intent = Intent(applicationContext, RechargeActivity::class.java)
                    intent.putExtra(EXTRA_KEY_RECHARGE_URL, url)
                    startActivity(intent)
                    return true
                }
            }
            return super.shouldOverrideUrlLoading(view, url)
        }
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            showDialog()
            return false;
        }
        return super.onKeyDown(keyCode, event)
    }

    private fun showDialog() {
        if (mDialog == null) {
            mDialog = AlertDialog.Builder(this)
            mDialog?.setTitle(getString(R.string.dialog_title))
            mDialog?.setMessage(getString(R.string.dialog_content))
            mDialog?.setPositiveButton(getString(R.string.dialog_confirm)) { _, _ ->
                Process.killProcess(Process.myPid())
                exitProcess(0)
            }
            mDialog?.setNegativeButton(getString(R.string.dialog_cancel)) { dialog, _ -> dialog?.dismiss() }
        }
        mDialog?.show()
    }
}