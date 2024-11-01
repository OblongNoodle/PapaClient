import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.Writer;
import java.lang.management.ManagementFactory;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class Launch {
    public static void main(String[] args) {
        try {
            Path launcherLocation;

            {
                try {
                    Path path = realPath();
                    launcherLocation = path.getParent();
                } catch (URISyntaxException e) {
                    throw new RuntimeException(e);
                }
            }

            List<String> jvmopt = new ArrayList<>();
            jvmopt.add(findjvm().toFile().toString());
            jvmopt.add("--add-exports=java.desktop/sun.awt=ALL-UNNAMED");

            jvmopt.add("-jar");
            jvmopt.add("build/hafen.jar");

            Path workspace = pj(launcherLocation).toAbsolutePath();
            Files.createDirectories(workspace);
            ProcessBuilder spec = new ProcessBuilder(jvmopt);
            spec.directory(workspace.toFile());
            spec.start();
        } catch (Exception e) {
            e.printStackTrace(pr);
        }
    }

    public static Path realPath() throws URISyntaxException, IOException {
        URI uri = Launch.class.getProtectionDomain().getCodeSource().getLocation().toURI();
        Path path = Paths.get(uri);
        Path dir = path.getParent();
        Path info = dir.resolve("." + path.getFileName() + ".info");
        if (!Files.exists(info))
            return (dir);
        try (InputStream src = Files.newInputStream(info)) {
            Files.readAllLines(info, StandardCharsets.UTF_8);
            Properties props = new Properties();
            props.load(src);
            return (Paths.get(URI.create(props.getProperty("source"))));
        }
    }

    public static Path findjvm() throws IOException {
        String[] libArgs = ManagementFactory.getRuntimeMXBean().getLibraryPath().split(File.pathSeparator);
        String javaPath = libArgs[0];

        Path javadir = Paths.get(javaPath);

        int os = getOsType();
        Path jvm;
        if (os == 1 && Files.exists(jvm = pj(javadir, "java")))
            return (jvm);
        if (os == 2 && Files.exists(jvm = pj(javadir, "javaw.exe")))
            return (jvm);
        if (os == 2 && Files.exists(jvm = pj(javadir, "java.exe")))
            return (jvm);
        throw (new IOException("could not find a Java executable"));
    }

    public static int getOsType() {
        String osName = System.getProperty("os.name").toLowerCase();

        if (osName.contains("linux")) {
            return 1;
        } else if (osName.contains("windows")) {
            return 2;
        } else {
            return 0;
        }
    }

    public static Path pj(Path base, String... els) {
        for (String el : els)
            base = base.resolve(el);
        return (base);
    }

    public static Path path(String path) {
        if (path == null)
            return (null);
        return (FileSystems.getDefault().getPath(path));
    }

    private static final PrintWriter pr = new PrintWriter(new Writer() {
        final StringBuilder buf = new StringBuilder();
        final Path fileLog = Paths.get("log.txt");

        public void write(char[] src, int off, int len) throws IOException {
            List<String> lines = new ArrayList<>();
            synchronized (this) {
                buf.append(src, off, len);
                int p;
                while ((p = buf.indexOf("\n")) >= 0) {
                    String ln = buf.substring(0, p).replace("\t", "        ");
                    lines.add(ln);
                    buf.delete(0, p + 1);
                }
            }
            for (String ln : lines) {
//                log(ln);
                Files.write(fileLog, ln.getBytes(StandardCharsets.UTF_8), StandardOpenOption.CREATE, StandardOpenOption.APPEND);
            }
        }

        public void close() {}

        public void flush() {}
    });
}
