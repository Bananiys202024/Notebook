package com.example.notebook.entity;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

import java.io.Serializable;

@DatabaseTable(tableName = "notes")
public class Note implements Serializable
{

    @DatabaseField(columnName = "id",generatedId = true)
    int id;

    @DatabaseField(columnName = "title")
    String title;

    @DatabaseField(columnName = "note")
    String note;

    @DatabaseField(columnName = "date_of_add")
    String date_of_add;

    @DatabaseField(columnName = "user")
    String user;

    public Note() {}

    public Note(int id, String title, String note, String date_of_add, String user) {
        this.id = id;
        this.title = title;
        this.note = note;
        this.date_of_add = date_of_add;
        this.user = user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getDate_of_add() {
        return date_of_add;
    }

    public void setDate_of_add(String date_of_add) {
        this.date_of_add = date_of_add;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }
}