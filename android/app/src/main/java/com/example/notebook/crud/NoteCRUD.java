package com.example.notebook.crud;


import android.content.Context;

import com.example.notebook.entity.Note;
import com.example.notebook.orm_lite.DBHelper;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import com.example.notebook.util.Generator;

public class NoteCRUD
{
    Context context;
    DBHelper dbHelper;


    public NoteCRUD(Context context)
    {
        this.context = context;
        this.dbHelper = new DBHelper(this.context);

    }

    public void create(Note note) {

        Generator gen = new Generator();
        String time = gen.generate_time();

        note.setUser("Banan");
        note.setDate_of_add(time);
        try {
            dbHelper.createOrUpdate(note);
        } catch (SQLException e) {
            System.out.println("Error---"+e);
        }
    }

    public List read() {

        List mStudentList = new ArrayList<>();
        try {
            mStudentList.addAll(dbHelper.getAll(Note.class));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return mStudentList;
    }

    public void update(Note note) {

        try {
            dbHelper.createOrUpdate(note);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {

        try {
            dbHelper.deleteById(Note.class, id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
