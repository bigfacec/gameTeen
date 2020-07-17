package com.skycraft.gameTeenPattiIntro;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;


import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class PokerGamePlugin implements MethodChannel.MethodCallHandler,EventChannel.StreamHandler {

    private static PokerGamePlugin mInstance;
    private Context mContext;
    private static final String TAG = "PokerGameUtils";

    public static PokerGamePlugin getInstance() {
        if (mInstance == null) {
            synchronized (PokerGamePlugin.class) {
                if (mInstance == null) {
                    mInstance = new PokerGamePlugin();
                }
            }
        }
        return mInstance;
    }

    public void register(BinaryMessenger binaryMessenger, Activity activity) {
        mContext = activity;
        MethodChannel methodChannel = new MethodChannel(binaryMessenger, ConstantKt.POKER_GAME_PLUGIN_CHANNEL);
        EventChannel eventChannel = new EventChannel(binaryMessenger, ConstantKt.POKER_GAME_PLUGIN_EVENT);
        eventChannel.setStreamHandler(this);
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "game":
                String url = call.argument("url");
                Intent intent = new Intent(mContext, GameActivity.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.putExtra(ConstantKt.EXTRA_KEY_GAME_URL, url);
                mContext.startActivity(intent);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    EventChannel.EventSink mEvents;
    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        mEvents = events;
    }

    @Override
    public void onCancel(Object arguments) {

    }

    public void setFinish() {
        if (mEvents != null) {
            mEvents.success("finish");
        }
    }
}
