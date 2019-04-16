package wandy.tech.gs_schedule;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.HashMap;

import androidx.core.app.NotificationCompat;

public class ScheduleReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        // post to instagram by schedule will executed here,
        int requestCode = intent.getIntExtra("requestCode", 0);
        String accountList = intent.getStringExtra("accountList");
        String mediaList = intent.getStringExtra("mediaList");
        try{
            uploadInstagram(accountList,mediaList);
        }catch (Exception e){
            Log.d("error_upload",e.getMessage());
        }

        Log.d("sc_result",accountList);
        Log.d("sc_result",mediaList);
        Notification notif = new NotificationCompat
                .Builder(context, "Scheduler")
                .setSmallIcon(R.mipmap.ic_launcher)
                .setContentTitle("Schedule running")
                .setContentText("Request on " + requestCode)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .build();

        NotificationManager am = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);

        int id = (int) System.currentTimeMillis() / 1000;
        am.notify(id, notif);
    }

    private void uploadInstagram(String accounts,String paths) {
        new Thread(() -> {
            String accountList[] = accounts.split("---");
            String pathList[] = paths.split("---");

            for(int i=0;i<accountList.length;i++){
                String singleAccount[] = accountList[i].split(",");
                InstagramBot ig = new InstagramBot();
                try{
                    ig.loginIG(singleAccount[0],singleAccount[1]);

                    for(int j=0;j<pathList.length;j++){
                        String singlePath[] = pathList[j].split("###-###");
                        ig.postPhoto(singlePath[0],singlePath[1]);
                        Thread.sleep(2000);
                    }
                }catch (Exception e){
                    e.printStackTrace();
                }

            }

        }).start();
    }
}
