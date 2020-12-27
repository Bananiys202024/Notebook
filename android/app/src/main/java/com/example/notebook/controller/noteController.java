package com.example.notebook.controller;

import android.content.Context;

import com.example.notebook.MainActivity;
import com.example.notebook.crud.NoteCRUD;
import com.example.notebook.entity.Note;
import com.example.notebook.model.NoteModel;
import com.example.notebook.orm_lite.DBHelper;
import com.example.notebook.socket.ImportDatabase;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

public class noteController
{

    public void create_note(String json, Context context)
    {
        Gson gson = new Gson();
        Note note = gson.fromJson(json, Note.class);

        NoteCRUD note_crud = new NoteCRUD(context);
        note_crud.create(note);
    }

    public List<String> read_all_notes(Context context)
    {
        List<String> list_of_objects = new ArrayList();
        NoteCRUD note_crud = new NoteCRUD(context);
        List<Note> read = note_crud.read();

        if(read != null) {
            int max = read.size()-1;
            for (int i = max; i >= 0; i--) {
                Note note = read.get(i);
                ObjectMapper mapper = new ObjectMapper();
                String jsonString = null;

                try {
                    jsonString = mapper.writeValueAsString(note);
                } catch (JsonProcessingException e) {
                    System.out.println("Error----" + e);
                }
                list_of_objects.add(jsonString);
            }
        }

        return list_of_objects;

    }

    public void import_database(Context context) {


        ImportDatabase import_database = new ImportDatabase();

        try {

            List<NoteModel> list_model = import_database.execute().get();

            DBHelper db_helper = new DBHelper(context);

            System.out.println("List---"+list_model);
            if(list_model != null)
                for(NoteModel model : list_model)
                {
                    Note entity = new Note();
                    entity.setId(Integer.parseInt(model.getId()));
                    entity.setDate_of_add(model.getDate_of_add());
                    entity.setUser(model.getUser());
                    entity.setTitle(model.getTitle());
                    entity.setNote(model.getNote());

                    db_helper.import_database(entity);
                }


        } catch (ExecutionException e) {
            System.out.println("Error---"+e);
        } catch (InterruptedException e) {
            System.out.println("Error---"+e);
        } catch (SQLException e) {
            System.out.println("Error---"+e);
        }


    }
}
