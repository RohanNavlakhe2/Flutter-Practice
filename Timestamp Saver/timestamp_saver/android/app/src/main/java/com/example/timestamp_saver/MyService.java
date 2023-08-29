package com.example.timestamp_saver;

import android.app.NotificationManager;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.os.IBinder;
import android.os.PowerManager;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import androidx.lifecycle.LifecycleService;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.Observer;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import io.flutter.plugin.common.EventChannel;

public class MyService extends LifecycleService {

    MutableLiveData<String> stringMutableLiveData = new MutableLiveData<>();
    int timerCount = 0;
    private PowerManager.WakeLock wl;
    private DBManager dbManager;
    @Override
    public void onCreate() {
        super.onCreate();
        dbManager = new DBManager(this);
        dbManager.open();
        //Creating a partial wake lock,Because if we don't create wake lock then CPU Will stop working when
        //screen will be locked,which will cause timer to work inconsistently.

        //This solution can be modified more.For example Acquire the Wake Lock when user locks the screen and release
        //it when phone gets unlock.This can be achieved using Brodcast Receiver.
        //Because Wake Lock consumes much power,so use it properly.
        PowerManager pm = (PowerManager)  getSystemService(Context.POWER_SERVICE);
        wl =  pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK,"a:waketag");
        wl.acquire();
        //stringMutableLiveData = new MutableLiveData<>();
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            NotificationCompat.Builder builder = new NotificationCompat.Builder(this,"messages")
                    .setContentText("This is running in Background")
                    .setContentTitle("Flutter Background")
                    .setSmallIcon(R.drawable.launch_background);

            startForeground(101,builder.build());
        }

        timerLogic();

    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        return super.onStartCommand(intent, flags, startId);
    }

    void timerLogic()
    {
        stringMutableLiveData.observe(this, new Observer<String>() {
            @Override
            public void onChanged(String s) {
                System.out.println("On Changed");
                if(MainActivity.events != null) {
                    dbManager.insert(s);
                    MainActivity.events.success(s);
                }
                else
                    System.out.println("Event is null");
            }
        });
        System.out.println("On Start Command");

        Timer timer = new Timer();
        timer.scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                timerCount++;
                DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                Calendar cal = Calendar.getInstance();
                String timerString = dateFormat.format(cal.getTime());
                System.out.println(timerString+": "+timerCount);
                stringMutableLiveData.postValue(timerString);

            }
        },1000,5000);
    }

    @Override
    public void onDestroy() {
        //Remember to relese wake lock
        wl.release();
        super.onDestroy();

    }
}
