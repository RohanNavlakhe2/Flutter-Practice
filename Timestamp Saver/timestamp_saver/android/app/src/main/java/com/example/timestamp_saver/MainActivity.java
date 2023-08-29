package com.example.timestamp_saver;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.os.Parcelable;
import android.os.PersistableBundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.lifecycle.Observer;

import java.io.Serializable;
import java.nio.ByteBuffer;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private Intent forService;
    static EventChannel.EventSink events;
    /*@Override
    public void onCreate(@Nullable Bundle savedInstanceState, @Nullable PersistableBundle persistentState) {
        super.onCreate(savedInstanceState, persistentState);


        forService = new Intent(MainActivity.this,MyService.class);

        BinaryMessenger binaryMessenger = new BinaryMessenger() {
            @Override
            public void send(@NonNull String channel, @Nullable ByteBuffer message) {

            }

            @Override
            public void send(@NonNull String channel, @Nullable ByteBuffer message, @Nullable BinaryReply callback) {

            }

            @Override
            public void setMessageHandler(@NonNull String channel, @Nullable BinaryMessageHandler handler) {

            }
        };

        new MethodChannel(binaryMessenger,"com.example.timestamp_saver")
                .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        if(methodCall.method.equals("startService")){
                            startService();
                            result.success("Service Started");
                        }
                    }
                });

    }*/

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        forService = new Intent(MainActivity.this,MyService.class);

        /*new MethodChannel(flutterEngine.getDartExecutor(),"com.example.timestamp_saver")
                .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        if(methodCall.method.equals("startService")){
                            startService();
                            MyService.stringMutableLiveData.observe(MainActivity.this, new Observer<String>() {
                                @Override
                                public void onChanged(String s) {
                                    System.out.println("On Changed");
                                    result.success("Service Started...");
                                }
                            });
                            //result.success("Service Started");
                        }
                    }
                });*/

        new EventChannel(flutterEngine.getDartExecutor(),"com.example.timestamp_saver").setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                MainActivity.events = events;
                System.out.println("On Listen in Activity called");
                     if(arguments.equals("startService"))
                     {
                         System.out.println("if");
                         startService();
                        /* MyService.stringMutableLiveData.observe(MainActivity.this, new Observer<String>() {
                             @Override
                             public void onChanged(String s) {
                                 System.out.println("On Changed");
                                 events.success("New Data...");
                             }
                         });*/
                     }else if(arguments.equals("Just Listen")){
                         System.out.println("Just Listen");
                     }
            }

            @Override
            public void onCancel(Object arguments) {

            }
        });

    }

    private void startService(){
        /*EventSinkWrapper eventSinkWrapper = new EventSinkWrapper(events);
        Bundle bundle = new Bundle();
        bundle.putParcelable("EventWrapper",eventSinkWrapper);
        forService.putExtras(bundle);*/

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            startForegroundService(forService);
        } else {
            startService(forService);
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }
}


