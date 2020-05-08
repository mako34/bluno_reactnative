package com.blunobridge;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class DeviceModule extends ReactContextBaseJavaModule {
    private static ReactApplicationContext reactContext;

    Conspi conspi;

    //constructor
    public DeviceModule(ReactApplicationContext reactContext) {
        super(reactContext);
        reactContext = reactContext;
    }
    //Mandatory function getName that specifies the module name
    @Override
    public String getName() {
        return "BLuno";
    }

        //USEFUL for passing constants to JS
//    @Override
//    public Map<String, Object> getConstants() {
//        final Map<String, Object> constants = new HashMap<>();
//        constants.put(DURATION_SHORT_KEY, Toast.LENGTH_SHORT);
//        constants.put(DURATION_LONG_KEY, Toast.LENGTH_LONG);
//        return constants;
//    }
//
    //Custom function that we are going to export to JS
//    @ReactMethod
//    public void getDeviceName(Callback cb) {
//        try{
//            Conspi conspi = new Conspi();
//
//
//            cb.invoke(null, conspi.chamad());
//
//        }catch (Exception e){
//            cb.invoke(e.toString(), null);
//        }
//    }

    @ReactMethod
    public void show(String message, int duration) {
        Toast.makeText(getReactApplicationContext(), message, duration).show();
    }

    @ReactMethod
    public void initEvent(String params) {
        conspi = new Conspi();

//        conspi.onCreate();

        conspi.initEvent_(params);
    }

    @ReactMethod
    public void searchDeviceEvent(String params) {
        conspi.searchDeviceEvent_(params);
    }

//    @ReactMethod
//    public void searchDeviceEvent(Callback cb) {
//        try{
//            cb.invoke(null, conspi.searchDeviceEvent_());
//
//        }catch (Exception e){
//            cb.invoke(e.toString(), null);
//        }
//    }

    @ReactMethod
    void launchDroidBT(){
        Activity activity = getCurrentActivity();
        if (activity != null) {
            Intent intent = new Intent(activity, BlunoActivity.class);
            activity.startActivity(intent);
        }
        Log.d("mk", "okas");
    }

}
