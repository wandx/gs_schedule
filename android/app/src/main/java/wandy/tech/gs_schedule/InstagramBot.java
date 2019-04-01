package wandy.tech.gs_schedule;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import java.io.File;

import dev.niekirk.com.instagram4android.Instagram4Android;
import dev.niekirk.com.instagram4android.requests.InstagramUploadPhotoRequest;
import dev.niekirk.com.instagram4android.requests.InstagramUploadVideoRequest;

import static android.content.Context.ALARM_SERVICE;

public class InstagramBot {
    private Instagram4Android ig;
    private static final String TAG = "instagramBot";

    public void loginIG(String username, String password) throws Exception {
        Log.d(TAG, "Login IG as " + username);
        this.ig = Instagram4Android.builder().username(username).password(password).build();
        this.ig.setup();
        this.ig.login();
    }

    public void postPhoto(String path, String caption) {
        Log.d(TAG, "Post Photo");
        File file = new File(path);

        Instagram4Android ig = this.ig;

        new Thread(() -> {
            try {
                ig.sendRequest(new InstagramUploadPhotoRequest(file, caption));
            } catch (Exception e) {
                e.printStackTrace();
            }

        }).start();

    }

    public void postVideo(String path, String caption) {
        File file = new File(path);

        Instagram4Android ig = this.ig;

        new Thread(() -> {
            try {
                ig.sendRequest(new InstagramUploadVideoRequest(file, caption));
            } catch (Exception e) {
                e.printStackTrace();
            }

        }).start();
    }
}
