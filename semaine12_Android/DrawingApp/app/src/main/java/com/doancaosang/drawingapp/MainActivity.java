package com.doancaosang.drawingapp;

import android.content.Context;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TabHost;
import android.widget.TextView;
import android.widget.Toast;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    String[] list = {"Black", "Blue", "Cyan", "Gray", "Green", "Magenta", "Red", "Yellow"};
    private ListView listColor;

    private ArrayList<CanvasView> listCanvasView;

    protected int selectedColorPos;

    private CanvasView canvasView;

    private String FILENAME = "DrawingAppFile";

    /* Display display = getWindowManager().getDefaultDisplay();
    final float dispWidth = (float)display.getWidth();
    final float dispHeight = (float)display.getHeight();
*/
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        TabHost tabs = (TabHost) findViewById(R.id.tabHost);
        tabs.setup();
        TabHost.TabSpec spec = tabs.newTabSpec("canvas");
        spec.setContent(R.id.canvas);
        spec.setIndicator("CANVAS");
        tabs.addTab(spec);

        spec = tabs.newTabSpec("palette");
        spec.setContent(R.id.palette);
        spec.setIndicator("PALETTE");
        tabs.addTab(spec);

        listColor = (ListView) findViewById(R.id.listColor);

        selectedColorPos = 0;

        canvasView = (CanvasView) findViewById(R.id.canvasViewBlack);
        canvasView.bringToFront();

        listCanvasView = new ArrayList<>();
        listCanvasView.add(canvasView);

        canvasView = (CanvasView) findViewById(R.id.canvasViewBlue);
        canvasView.setColor(Color.parseColor(list[1]));
        listCanvasView.add(canvasView);

        canvasView = (CanvasView) findViewById(R.id.canvasViewCyan);
        canvasView.setColor(Color.parseColor(list[2]));
        listCanvasView.add(canvasView);

        canvasView = (CanvasView) findViewById(R.id.canvasViewGray);
        canvasView.setColor(Color.parseColor(list[3]));
        listCanvasView.add(canvasView);

        canvasView = (CanvasView) findViewById(R.id.canvasViewGreen);
        canvasView.setColor(Color.parseColor(list[4]));
        listCanvasView.add(canvasView);

        canvasView = (CanvasView) findViewById(R.id.canvasViewMagenta);
        canvasView.setColor(Color.parseColor(list[5]));
        listCanvasView.add(canvasView);

        canvasView = (CanvasView) findViewById(R.id.canvasViewRed);
        canvasView.setColor(Color.parseColor(list[6]));
        listCanvasView.add(canvasView);

        canvasView = (CanvasView) findViewById(R.id.canvasViewYellow);
        canvasView.setColor(Color.parseColor(list[7]));
        listCanvasView.add(canvasView);

        listColor.setAdapter(new CustomAdapter(this, R.layout.cell_content));
        listColor.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                selectedColorPos = position;
                ((CustomAdapter) listColor.getAdapter()).notifyDataSetChanged();

                canvasView = listCanvasView.get(position);
                canvasView.bringToFront();
                Toast.makeText(MainActivity.this, list[position], Toast.LENGTH_LONG).show();
            }
        });

        if (savedInstanceState != null){
            selectedColorPos = savedInstanceState.getInt("selectedColorPos");

            ((CustomAdapter) listColor.getAdapter()).notifyDataSetChanged();
            canvasView = listCanvasView.get(selectedColorPos);
            canvasView.bringToFront();

            ArrayList<CanvasView> listCanvasViewTmp = (ArrayList<CanvasView>) restore(FILENAME + ".ListCanvasView");
            for (int i = 0; i < listCanvasViewTmp.size(); i++) {
                CanvasView canvasViewTmp = listCanvasViewTmp.get(i);
                listCanvasView.get(i).setPaintAndPath(canvasViewTmp.getPaint(), canvasViewTmp.getPath());
            }
        }
    }

    @Override
    protected void onSaveInstanceState(Bundle savedInstanceState) {
        super.onSaveInstanceState(savedInstanceState);
        savedInstanceState.putInt("selectedColorPos", selectedColorPos);
        save(listCanvasView, FILENAME + ".ListCanvasView");
    }

    @Override
    protected void onRestoreInstanceState(Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);
        selectedColorPos = savedInstanceState.getInt("selectedColorPos");
        listCanvasView = (ArrayList<CanvasView>) restore(FILENAME + ".ListCanvasView");
    }

    private void save(Object in, String fileName) {
        FileOutputStream fos = null;
        try {
            fos = openFileOutput(fileName, Context.MODE_PRIVATE);
            ObjectOutputStream os = new ObjectOutputStream(fos);
            os.writeObject(in);
            os.close();
            fos.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    private Object restore(String fileName){
        FileInputStream fis = null;
        Object out = null;
        try {

            fis = openFileInput(fileName);
            ObjectInputStream is = new ObjectInputStream(fis);
            out = is.readObject();
            is.close();
            fis.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return out;
    }

    class CustomAdapter extends ArrayAdapter{
        private Context context;
        private int resource;

        /**
         * Constructor
         *
         * @param context  The current context.
         * @param resource The resource ID for a layout file containing a TextView to use when
         */
        public CustomAdapter(Context context, int resource) {
            super(context, resource);
            this.context = context;
            this.resource = resource;
        }

        @Override
        public int getCount() {
            return list.length;
        }

        @Override
        public Object getItem(int position) {
            return list[position];
        }

        @Override
        public long getItemId(int position) {
            return 0;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            TextView textView = (TextView) convertView;

            if (textView == null)
                textView = new TextView(context);

            textView.setText(list[position]);
            textView.setTextColor(Color.parseColor(list[position]));
            textView.setTextSize(40);
            textView.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);

            if (position == selectedColorPos){
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    textView.setTextAppearance(R.style.selectedText);
                }else{
                    textView.setTextAppearance(getApplicationContext(), R.style.selectedText);
                }
                textView.setAlpha((float) 1);
            }else{
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    textView.setTextAppearance(R.style.normalText);
                }else{
                    textView.setTextAppearance(getApplicationContext(), R.style.normalText);
                }
                textView.setAlpha((float) 0.05);
            }

            return textView;
        }


    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            for(int i = 0; i < listCanvasView.size(); i++){
                listCanvasView.get(i).reset();
                listCanvasView.get(i).setColor(Color.parseColor(list[i]));
            }
            return true;
        }

        return super.onOptionsItemSelected(item);
    }


}
