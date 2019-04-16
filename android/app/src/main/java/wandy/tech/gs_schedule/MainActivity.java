package wandy.tech.gs_schedule;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.Log;
import android.widget.Toast;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "tech.wandy.gs_schedule/instagram-bot";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
        StrictMode.setThreadPolicy(policy);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler((methodCall, result) -> {
            final Map<String, Object> arguments = methodCall.arguments();

            if (methodCall.method.equals("post-photo")) {
                InstagramBot ig = new InstagramBot();
                String path = (String) arguments.get("path");
                String caption = (String) arguments.get("caption");
                String username = (String) arguments.get("username");
                String password = (String) arguments.get("password");

                try {
                    ig.loginIG("wandxinc", "wandx54");
                    ig.postPhoto(path, caption);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            if (methodCall.method.equals("post-video")) {
                InstagramBot ig = new InstagramBot();
                String path = (String) arguments.get("path");
                String caption = (String) arguments.get("caption");

                try {
                    ig.loginIG("wandxinc", "wandx54");
                    ig.postVideo(path, caption);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            if (methodCall.method.equals("make-schedule")) {
                int requestCode = (int) arguments.get("requestCode");
                String accountList = (String) arguments.get("accountList");
                String mediaList = (String) arguments.get("mediaList");
                HashMap<String, Object> dateObj = new HashMap<>();
                dateObj.put("year", arguments.get("year"));
                dateObj.put("month", arguments.get("month"));
                dateObj.put("date", arguments.get("date"));
                dateObj.put("hour", arguments.get("hour"));
                dateObj.put("min", arguments.get("min"));

                makeSchedule(requestCode, dateObj, accountList, mediaList);
            }

            if (methodCall.method.equals("check-login")) {
                String username = (String) arguments.get("username");
                String password = (String) arguments.get("password");

                InstagramBot ig = new InstagramBot();
                result.success(ig.checkLogin(username, password));
            }
        });
    }

    public void makeSchedule(int requestCode, Map<String, Object> dateObj, String accountList, String mediaList) {
        Intent intent = new Intent(this, ScheduleReceiver.class);
        intent.putExtra("requestCode", requestCode);
        intent.putExtra("accountList", accountList);
        intent.putExtra("mediaList", mediaList);

        PendingIntent pendingIntent = PendingIntent.getBroadcast(this.getApplicationContext(), requestCode, intent, PendingIntent.FLAG_UPDATE_CURRENT);

        AlarmManager alarmManager = (AlarmManager) getSystemService(ALARM_SERVICE);
        alarmManager.set(AlarmManager.RTC_WAKEUP, millis(dateObj), pendingIntent);
        Toast.makeText(this, "Schedule Created.", Toast.LENGTH_LONG).show();
    }

    private long millis(Map<String, Object> dateObj) {
        int year = (int) dateObj.get("year");
        int month = (int) dateObj.get("month");
        int date = (int) dateObj.get("date");
        int hour = (int) dateObj.get("hour");
        int min = (int) dateObj.get("min");

        Calendar cal = Calendar.getInstance();
        cal.set(year, month - 1, date, hour, min, 0);

        try {
            Log.d("MainActivity", cal.toString());
            System.out.println(System.currentTimeMillis());
            System.out.println(cal.getTimeInMillis());
            return cal.getTimeInMillis();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
