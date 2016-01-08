package com.doancaosang.drawingapp;

import android.content.Context;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Canvas;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;

import java.io.Serializable;

/**
 * Created by dcs on 05/01/16.
 */
public class CanvasView extends View{
    private Paint paint;
    private Path path;
    private int currentColor;

    /**
     * Simple constructor to use when creating a view from code.
     *
     * @param context The Context the view is running in, through which it can
     *                access the current theme, resources, etc.
     */
    public CanvasView(Context context) {
        super(context);
        reset();
    }

    public CanvasView(Context context, AttributeSet atttrs){
        super(context, atttrs);
        reset();
    }

    public void reset() {
        paint = new Paint();
        path = new Path();

        paint.setAntiAlias(true);
        paint.setStrokeWidth(6f);
        paint.setColor(Color.BLACK);
        currentColor = Color.BLACK;
        paint.setStyle(Paint.Style.STROKE);
        paint.setStrokeJoin(Paint.Join.ROUND);
        invalidate();
    }

    public void setColor(int color){
        currentColor = color;
        paint = new Paint();
        paint.setAntiAlias(true);
        paint.setStrokeWidth(6f);
        paint.setStyle(Paint.Style.STROKE);
        paint.setStrokeJoin(Paint.Join.ROUND);
        paint.setColor(color);
        invalidate();
    }

    @Override
    protected void onDraw(Canvas canvas){
        canvas.drawPath(path, paint);
    }

    public Paint getPaint(){
        return this.paint;
    }

    public Path getPath(){
        return this.path;
    }

    public void setPaintAndPath(Paint paint, Path path){
        this.paint = paint;
        this.path = path;
        invalidate();
    }

    @Override
    public boolean onTouchEvent(MotionEvent event){
        float eventX = event.getX();
        float eventY = event.getY();
        switch (event.getAction()){
            case MotionEvent.ACTION_DOWN:
                path.moveTo(eventX, eventY);
                break;
            case MotionEvent.ACTION_MOVE:
                path.lineTo(eventX, eventY);
                break;
            case MotionEvent.ACTION_UP:
                break;
            default:
                return false;
        }
        invalidate();
        return true;
    }

}
