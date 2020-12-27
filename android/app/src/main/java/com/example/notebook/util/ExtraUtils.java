package com.example.notebook.util;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.nio.file.Files;
import java.nio.file.*;
import android.content.Context;


import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;

import java.io.InputStreamReader;
import java.io.*;


public class ExtraUtils
{

    public void replace_file(String source_path)
    {
        try {
            String destination_path = "/data/user/0/com.example.notebook/databases/notebook.db";
            //replace database....
            File file_source_path = new File(source_path);
            File file_destination_path = new File(destination_path);

            file_source_path.renameTo(file_destination_path);
            //...
        }
        catch(Exception e)
        {
            System.out.println("Error from extra utils method replace File_____"+e);
        }

    }



    public void save_email(String data,Context context) {
        try {
            OutputStreamWriter outputStreamWriter = new OutputStreamWriter(context.openFileOutput("config.txt", Context.MODE_PRIVATE));
            outputStreamWriter.write(data);
            outputStreamWriter.close();
        }
        catch (IOException e) {
            System.out.println("Error---"+e);
        }
    }

    public String readEmail(Context context) {

        String ret = "";

        try {
            InputStream inputStream = context.openFileInput("config.txt");

            if ( inputStream != null ) {
                InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
                BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
                String receiveString = "";
                StringBuilder stringBuilder = new StringBuilder();

                while ( (receiveString = bufferedReader.readLine()) != null ) {
                    stringBuilder.append("").append(receiveString);
                }

                inputStream.close();
                ret = stringBuilder.toString();
            }
        }
        catch (FileNotFoundException e) {
            System.out.println("Error---"+e);
        } catch (IOException e) {
            System.out.println("Error---"+e);
        }

        return ret;
    }

}


