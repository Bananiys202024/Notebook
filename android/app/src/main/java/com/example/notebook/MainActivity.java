package com.example.notebook;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build;
import android.os.PowerManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

import com.example.notebook.controller.noteController;
import com.example.notebook.crud.NoteCRUD;
import com.example.notebook.entity.Note;
import com.example.notebook.gmail.GmailSender;
import com.example.notebook.model.NoteModel;
import com.example.notebook.orm_lite.DBHelper;
import com.example.notebook.socket.ImportDatabase;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import org.json.JSONArray;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.nio.file.Files;
import java.nio.file.*;


import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import com.example.notebook.util.ExtraUtils;


public class MainActivity extends FlutterActivity
{
    private static final String CHANNEL = "flutter.call.java";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine)  {

        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {

                            String message = call.method.substring(0, 11);

                            if (message.equals("create_note")) {
                                noteController note_contr = new noteController();
                                note_contr.create_note(call.method.substring(12), this);
                                System.out.println("CREATE NOTE");
                                System.out.println(call.method.substring(12));
                                result.success("successefully_created");
                            }

                            if (message.equals("read_all_no")) {
                                noteController note_contr = new noteController();
                                List<String> list_of_objects = note_contr.read_all_notes(this);
                                result.success(list_of_objects);
                            }

                            if (message.equals("delete_note")) {
                                String id = call.method.substring(12);
                                Context context = (Context) this;

                                NoteCRUD note_crud = new NoteCRUD(context);
                                note_crud.delete(Integer.parseInt(id));
                                result.success("successefully_created");
                            }

                            if (message.equals("edit_note__")) {

                                String json = call.method.substring(12);
                                Gson gson = new Gson();
                                Note note = gson.fromJson(json, Note.class);

                                Context context = (Context) this;

                                NoteCRUD note_crud = new NoteCRUD(context);
                                note_crud.update(note);
                                result.success("successefully_created");
                            }

                            if (message.equals("export_data")) {

                                ExtraUtils extra_utils = new ExtraUtils();
                                String created_email = extra_utils.readEmail(this);
                                GmailSender g = new GmailSender();
                                g.execute(new String[] {created_email});

                                result.success("successefully_created");
                            }

                            if (message.equals("import_data")) {
                                   noteController note_contr = new noteController();
                                   ExtraUtils extra_utils = new ExtraUtils();
                                   extra_utils.replace_file(call.method.substring(11) );
                                   result.success("successefully_created");
                            }
                            //create email
                            if (message.equals("create_new_")) {

                                System.out.println("CREATE NOTE");
                                System.out.println(call.method.substring(0, 11));
                                ExtraUtils extra_utils = new ExtraUtils();
                                extra_utils.save_email(call.method.substring(11), this);

                                //testing
                                String created_email = extra_utils.readEmail(this);
                                System.out.println("Created email---"+created_email);
                                //...

                                result.success("successefully_created");

                            }
                  }
                );
    }}
