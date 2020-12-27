package com.example.notebook.orm_lite;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.os.Build;

import androidx.annotation.RequiresApi;

import com.example.notebook.entity.Note;
import com.example.notebook.gmail.GmailSender;
import com.j256.ormlite.android.apptools.OrmLiteSqliteOpenHelper;
import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.support.ConnectionSource;
import com.j256.ormlite.table.TableUtils;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class DBHelper extends OrmLiteSqliteOpenHelper
{
    // Fields
    public static final String DB_NAME = "notebook.db";
    private static final int DB_VERSION = 1;
    String path;
    Context context;

    public DBHelper(Context context) {
        super(context, DB_NAME, null, DB_VERSION);
        this.context = context;
        this.path = getReadableDatabase().getPath();
        System.out.println("PATH-----"+path);
    }



    @Override
    public void onCreate(SQLiteDatabase database, ConnectionSource cs)
    {
        try {
            TableUtils.createTable(cs, Note.class);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void onUpgrade(SQLiteDatabase database, ConnectionSource connectionSource, int oldVersion, int newVersion)
    {

    }


    public Dao.CreateOrUpdateStatus import_database(Note obj) throws SQLException {
        Dao<Note, ?> dao = (Dao<Note, ?>) getDao(obj.getClass());
        return dao.createOrUpdate(obj);
    }


    public List getAll(Class clazz) throws SQLException {
        Dao<Note, ?> dao = getDao(clazz);
        return dao.queryForAll();
    }

    public  Note getById(Class clazz, Object aId) throws SQLException {
        Dao<Note, Object> dao = getDao(clazz);
        return dao.queryForId(aId);
    }

    public Dao.CreateOrUpdateStatus createOrUpdate(Note obj) throws SQLException {
        Dao<Note, ?> dao = (Dao<Note, ?>) getDao(obj.getClass());
        return dao.createOrUpdate(obj);
    }

    public  int deleteById(Class clazz, int aId) throws SQLException {
        Dao<Note, Object> dao = getDao(clazz);
        return dao.deleteById(aId);
    }


}