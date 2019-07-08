package wandy.tech.gs_schedule;

import android.util.Log;

import java.io.File;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import dev.niekirk.com.instagram4android.Instagram4Android;
import dev.niekirk.com.instagram4android.requests.InstagramUploadPhotoRequest;
import dev.niekirk.com.instagram4android.requests.InstagramUploadVideoRequest;

public class InstagramBot {
    private Instagram4Android ig;
    private static final String TAG = "instagramBot";
    private final static ExecutorService ex = Executors.newSingleThreadExecutor();

    public void loginIG(String username, String password) throws Exception {
        this.ig = Instagram4Android.builder().username(username).password(password).build();
        this.ig.setup();
        this.ig.login();
        Log.d(TAG, "Login IG as " + this.ig.getUsername());
    }

    public boolean checkLogin(String username, String password){
        try{
            loginIG(username, password);
            return this.ig.isLoggedIn();
        }catch (Exception e){
            return false;
        }
    }

    public void postPhoto(String path, String caption) {
        Log.d(TAG, "Post Photo");
        File file = new File(path);

        Instagram4Android ig = this.ig;

        ex.submit(() -> {
            try {
                ig.sendRequest(new InstagramUploadPhotoRequest(file, caption));
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
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
