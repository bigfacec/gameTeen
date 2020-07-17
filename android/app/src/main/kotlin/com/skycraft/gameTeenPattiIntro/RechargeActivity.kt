package com.skycraft.gameTeenPattiIntro

import android.os.Bundle
import android.widget.FrameLayout
import android.widget.LinearLayout
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar
import com.just.agentweb.AgentWeb
import com.skycraft.gameTeenPattiIntro.R

class RechargeActivity : AppCompatActivity() {

    var mUrl: String? = null
    var mAgentWeb: AgentWeb? = null
    private var mFl: FrameLayout? = null
    private var mToolbar: Toolbar? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_recharge)
        mFl = findViewById(R.id.fl_web)
        mToolbar = findViewById(R.id.too_bar)
        mToolbar?.setNavigationOnClickListener { finish() }
        mUrl = intent.getStringExtra(EXTRA_KEY_RECHARGE_URL)

        mFl?.let {
            mAgentWeb = AgentWeb.with(this)
                    .setAgentWebParent(it, LinearLayout.LayoutParams(-1, -1))
                    .useDefaultIndicator()
                    .createAgentWeb()
                    .ready()
                    .go(mUrl)
        }
    }

    override fun onResume() {
        super.onResume()
        mAgentWeb?.webLifeCycle?.onResume()
    }

    override fun onPause() {
        super.onPause()
        mAgentWeb?.webLifeCycle?.onPause()
    }

    override fun onDestroy() {
        super.onDestroy()
        mAgentWeb?.webLifeCycle?.onDestroy()
    }
}