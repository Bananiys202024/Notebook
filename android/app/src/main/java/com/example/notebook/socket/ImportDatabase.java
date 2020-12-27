package com.example.notebook.socket;

import android.os.AsyncTask;

import com.example.notebook.model.Constants;
import com.example.notebook.model.NoteModel;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.List;

//this class request database from server
public class ImportDatabase extends AsyncTask<Void, Void, List<NoteModel>> {

    @Override
    protected List<NoteModel> doInBackground(Void... voids) {

        try {
            Socket socket = new Socket(Constants.getIp_host(), Constants.getPORT());

            OutputStream outputStream = socket.getOutputStream();
            ObjectOutputStream object_output_stream = new ObjectOutputStream(outputStream);
            object_output_stream.writeObject("import_database");

            InputStream inputStream = socket.getInputStream();
            ObjectInputStream object_input_stream = new ObjectInputStream(inputStream);

            List<NoteModel> result = (List<NoteModel>) object_input_stream.readObject();

            return result;
        } catch (IOException e) {
            System.out.println("Error----"+e);
        } catch (ClassNotFoundException e) {
            System.out.println("Error----"+e);
        }


        return null;
    }


}
