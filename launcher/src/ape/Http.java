package ape;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

public class Http {
    public static void copyURLToFile(final URL url, String token, final File destination) throws IOException {
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        if (token != null)
            connection.setRequestProperty("Authorization", "token " + token);

        FileUtils.copyInputStreamToFile(connection.getInputStream(), destination);
    }
}
