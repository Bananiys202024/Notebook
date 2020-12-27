package com.example.notebook.util;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class Generator {

    public static final String DATE_FORMAT = "dd-MMM-yyyy";

    public String generate_time()
    {
        String time = getCurrentTime();
        String result_time = time.replaceAll("-"," ").replaceAll("[.]"," ");

        String number_of_date = result_time.substring(0,2);
        String month_of_date = result_time.substring(2,6);
        String year_of_date =  result_time.substring(6);


        return number_of_date+" "+month_of_date+"  "+ year_of_date;
    }

    public static String getCurrentTime() {
        SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_FORMAT);
        dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
        Date today = Calendar.getInstance().getTime();
        return dateFormat.format(today);
    }
}
