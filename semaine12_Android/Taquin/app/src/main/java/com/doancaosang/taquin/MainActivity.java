package com.doancaosang.taquin;

import android.graphics.Color;
import android.support.v4.app.FragmentActivity;
import android.os.Bundle;
import android.support.v4.app.FragmentManager;
import android.view.GestureDetector;
import android.view.MotionEvent;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Random;

public class MainActivity extends FragmentActivity {

    protected ArrayList<String> list;
    protected ArrayList<ArrayList<String>> table;
    protected Button buttonRaz;

    FragmentManager fragmentManager;

    private GestureDetector gestureDetector;
    View.OnTouchListener gestureListener;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        fragmentManager = getSupportFragmentManager();

        gestureDetector = new GestureDetector(this, new MyGestureDetector());
        gestureListener = new View.OnTouchListener() {
            public boolean onTouch(View v, MotionEvent event) {
                return gestureDetector.onTouchEvent(event);
            }
        };

        initTable();
        refreshList();

        buttonRaz = (Button) findViewById(R.id.buttonRaz);
        buttonRaz.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                initTable();
                refreshList();
            }
        });
    }

    protected void initTable(){
        list = new ArrayList<>();

        int i = 0;
        while(i < 9) {
            Random random = new Random();
            int n = random.nextInt(9);

            while (true){
                int j;
                for (j = 0; j < i; j++) {
                    if (Integer.valueOf(list.get(j)) == n){
                        random = new Random();
                        n = random.nextInt(9);
                        break;
                    }
                }
                if (i == j){
                    list.add(i, String.valueOf(n));
                    break;
                }
            }
            i++;
        }

        table = new ArrayList<>();
        ArrayList<String> tmp = new ArrayList<>();
        tmp.add(0, list.get(0));
        tmp.add(1, list.get(1));
        tmp.add(2, list.get(2));

        table.add(0, tmp);

        tmp = new ArrayList<>();
        tmp.add(0, list.get(3));
        tmp.add(1, list.get(4));
        tmp.add(2, list.get(5));

        table.add(1, tmp);

        tmp = new ArrayList<>();
        tmp.add(0, list.get(6));
        tmp.add(1, list.get(7));
        tmp.add(2, list.get(8));

        table.add(2, tmp);
    }

    protected void refreshList(){
        int i;
        for (i = 0; i < 9; i++){
            MyFragment f_tmp = (MyFragment) fragmentManager.findFragmentByTag(String.valueOf(i));
            TextView t = (TextView) f_tmp.getView().findViewById(R.id.textView);
            t.setText(list.get(i));

            t.setOnTouchListener(gestureListener);

            if (Integer.valueOf(list.get(i)) == 0) {
                t.setVisibility(View.INVISIBLE);
                t.setBackgroundColor(Color.WHITE);
            }else {
                t.setVisibility(View.VISIBLE);
                t.setBackgroundColor(Color.CYAN);
            }
        }
    }

    protected void checkTable(){
        int ok = -1;
        for (int i = 0; i < 9; i++){
            if (ok == -1 && Integer.valueOf(list.get(i)) == 1){
                ok = 1;
            }
            if ((ok != -1) && (ok + 1 == Integer.valueOf(list.get(i)))){
                ok++;
            }
        }

        if (ok == 8){
            Toast.makeText(MainActivity.this, "You win", Toast.LENGTH_LONG).show();
        }
    }

    private static final int SWIPE_MIN_DISTANCE = 100;
    private static final int SWIPE_THRESHOLD_VELOCITY = 100;

    class MyGestureDetector extends GestureDetector.SimpleOnGestureListener {
        @Override
        public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
            try {
                float diffY = e2.getY() - e1.getY();
                float diffX = e2.getX() - e1.getX();
                if (Math.abs(diffX) > Math.abs(diffY)) {
                    if (Math.abs(diffX) > SWIPE_MIN_DISTANCE
                            && Math.abs(velocityX) > SWIPE_THRESHOLD_VELOCITY) {
                        if (diffX > 0) {
                            onSwipeRight();
                        } else {
                            onSwipeLeft();
                        }
                    }
                } else {
                    if (Math.abs(diffY) > SWIPE_MIN_DISTANCE
                            && Math.abs(velocityY) > SWIPE_THRESHOLD_VELOCITY) {
                        if (diffY > 0) {
                            onSwipeDown();
                        } else {
                            onSwipeUp();
                            //    Toast.makeText(MainActivity.this, "Up Swipe", Toast.LENGTH_SHORT).show();
                        }
                    }
                }
            } catch (Exception exception) {
                exception.printStackTrace();
            }
            return false;
        }

        @Override
        public boolean onDown(MotionEvent e) {
            return true;
        }
    }

    public void onSwipeRight() {
        int row0 = -1;
        int col0 = -1;
        int position0 = 0;

        int row = -1;
        int col = -1;
        int position = 0;

        int i;
        for (i = 0; i < 3; i++){
            ArrayList<String> tmp = table.get(i);
            for (int j = 0; j < 3; j++){
                if (Integer.valueOf(tmp.get(j)) == 0){
                    row0 = i;
                    col0 = j;
                    break;
                }
            }
            if (col0 != -1)
                break;
        }

        if (col0 != 0 && col0 != -1){
            row = row0;
            col = col0 - 1;
        }

        int row_tmp0 = row0;
        int col_tmp0 = col0;

        row0 = row;
        col0 = col;

        row = row_tmp0;
        col = col_tmp0;

        position0 = row0*3 + col0;
        position = row*3 + col;

        String s = list.get(position0);
        list.set(position0, list.get(position));
        list.set(position, s);

        table.get(row0).set(col0, list.get(position0));
        table.get(row).set(col, list.get(position));

        checkTable();
        refreshList();
    }

    public void onSwipeLeft() {
        int row0 = -1;
        int col0 = -1;
        int position0 = 0;

        int row = -1;
        int col = -1;
        int position = 0;

        int i;
        for (i = 0; i < 3; i++){
            ArrayList<String> tmp = table.get(i);
            for (int j = 0; j < 3; j++){
                if (Integer.valueOf(tmp.get(j)) == 0){
                    row0 = i;
                    col0 = j;
                    break;
                }
            }
            if (col0 != -1)
                break;
        }

        if (col0 != 2 && col0 != -1){
            row = row0;
            col = col0 + 1;
        }

        int row_tmp0 = row0;
        int col_tmp0 = col0;

        row0 = row;
        col0 = col;

        row = row_tmp0;
        col = col_tmp0;

        position0 = row0*3 + col0;
        position = row*3 + col;

        String s = list.get(position0);
        list.set(position0, list.get(position));
        list.set(position, s);

        table.get(row0).set(col0, list.get(position0));
        table.get(row).set(col, list.get(position));

        checkTable();
        refreshList();
    }

    public void onSwipeUp() {
        int row0 = -1;
        int col0 = -1;
        int position0 = 0;

        int row = -1;
        int col = -1;
        int position = 0;

        int i;
        for (i = 0; i < 3; i++){
            ArrayList<String> tmp = table.get(i);
            for (int j = 0; j < 3; j++){
                if (Integer.valueOf(tmp.get(j)) == 0){
                    row0 = i;
                    col0 = j;
                    break;
                }
            }
            if (row0 != -1)
                break;
        }

        if (row0 != 2 && row0 != -1){
            row = row0 + 1;
            col = col0;
        }

        int row_tmp0 = row0;
        int col_tmp0 = col0;

        row0 = row;
        col0 = col;

        row = row_tmp0;
        col = col_tmp0;

        position0 = row0*3 + col0;
        position = row*3 + col;

        String s = list.get(position0);
        list.set(position0, list.get(position));
        list.set(position, s);

        table.get(row0).set(col0, list.get(position0));
        table.get(row).set(col, list.get(position));

        checkTable();
        refreshList();
    }

    public void onSwipeDown() {
        int row0 = -1;
        int col0 = -1;
        int position0 = 0;

        int row = -1;
        int col = -1;
        int position = 0;

        int i;
        for (i = 0; i < 3; i++){
            ArrayList<String> tmp = table.get(i);
            for (int j = 0; j < 3; j++){
                if (Integer.valueOf(tmp.get(j)) == 0){
                    row0 = i;
                    col0 = j;
                    break;
                }
            }
            if (row0 != -1)
                break;
        }

        if (row0 != 0 && row0 != -1){
            row = row0 - 1;
            col = col0;
        }

        int row_tmp0 = row0;
        int col_tmp0 = col0;

        row0 = row;
        col0 = col;

        row = row_tmp0;
        col = col_tmp0;

        position0 = row0*3 + col0;
        position = row*3 + col;

        String s = list.get(position0);
        list.set(position0, list.get(position));
        list.set(position, s);

        table.get(row0).set(col0, list.get(position0));
        table.get(row).set(col, list.get(position));

        checkTable();
        refreshList();
    }
}



