package com.example.notebook.model;

import java.io.Serializable;

public class NoteModel implements Serializable {

    String id;
    String title;
    String note;
    String date_of_add;
    String user;

    public NoteModel() {}

    public NoteModel(String id, String title, String note, String date_of_add, String user) {
        this.id = id;
        this.title = title;
        this.note = note;
        this.date_of_add = date_of_add;
        this.user = user;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
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

    @Override
    public String toString() {
        return "Note{" +
                "id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", note='" + note + '\'' +
                ", date_of_add='" + date_of_add + '\'' +
                ", user='" + user + '\'' +
                '}';
    }
}
