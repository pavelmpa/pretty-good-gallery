package com.herokuapp.webgalleryshowcase.json;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class JsonDateSerializer extends JsonSerializer<Date> {

    private SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss mm/dd/yyyy");

    @Override
    public void serialize(Date date, JsonGenerator jsonGenerator, SerializerProvider serializerProvider)
            throws IOException, JsonProcessingException {
        String formattedDate = dateFormat.format(date);
        jsonGenerator.writeString(formattedDate);
    }
}
