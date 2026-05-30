import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

public class ExtractControllers {
    public static void main(String[] args) throws IOException {
        String basePath = "src/main/java";
        String outPath = "frontend_mapping_summary.md";
        StringBuilder md = new StringBuilder();
        md.append("# Bảng tra cứu Controller và Frontend JSPs\n\n");
        md.append("Dưới đây là danh sách tất cả các Controller, đường dẫn (Route) và file giao diện `.jsp` tương ứng mà hệ thống yêu cầu.\n\n");

        Pattern classMapPattern = Pattern.compile("@RequestMapping\\(\"([^\"]+)\"\\)");
        Pattern methodMapPattern = Pattern.compile("@(Get|Post|Put|Delete|Patch)Mapping(?:\\s*\\(\\s*\"?([^\"]*)\"?\\s*\\))?");
        Pattern returnPattern = Pattern.compile("return\\s+\"([^\"]+)\"");

        Files.walk(Paths.get(basePath))
             .filter(Files::isRegularFile)
             .filter(p -> p.toString().endsWith("Controller.java"))
             .forEach(p -> {
                 try {
                     List<String> lines = Files.readAllLines(p);
                     String baseRoute = "";
                     List<Map<String, String>> mappings = new ArrayList<>();
                     
                     for (String line : lines) {
                         Matcher cm = classMapPattern.matcher(line);
                         if (cm.find()) {
                             baseRoute = cm.group(1);
                         }
                         
                         Matcher mm = methodMapPattern.matcher(line);
                         if (mm.find()) {
                             Map<String, String> map = new HashMap<>();
                             map.put("method", mm.group(1).toUpperCase());
                             String sub = mm.group(2) != null ? mm.group(2) : "";
                             map.put("path", sub);
                             map.put("view", "");
                             mappings.add(map);
                         }
                         
                         Matcher rm = returnPattern.matcher(line);
                         if (rm.find()) {
                             String view = rm.group(1);
                             if (!view.startsWith("redirect:")) {
                                 if (!mappings.isEmpty() && mappings.get(mappings.size()-1).get("view").isEmpty()) {
                                     mappings.get(mappings.size()-1).put("view", view);
                                 }
                             }
                         }
                     }
                     
                     if (!mappings.isEmpty()) {
                         md.append("## ").append(p.getFileName().toString()).append("\n");
                         md.append("**Base Route:** `").append(baseRoute).append("` \n\n");
                         md.append("| HTTP Method | Route | Tên file JSP trả về (thư mục: WEB-INF/views/) |\n");
                         md.append("| :--- | :--- | :--- |\n");
                         
                         for (Map<String, String> m : mappings) {
                             String fullPath = baseRoute + m.get("path");
                             if (m.get("path").equals("/") || m.get("path").isEmpty()) {
                                 fullPath = baseRoute;
                             }
                             String view = m.get("view");
                             if (view.isEmpty()) {
                                 view = "*(Xử lý Logic/Redirect)*";
                             } else {
                                 view = "`" + view + ".jsp`";
                             }
                             md.append("| ").append(m.get("method")).append(" | `").append(fullPath).append("` | ").append(view).append(" |\n");
                         }
                         md.append("\n");
                     }
                 } catch(Exception e) { e.printStackTrace(); }
             });

        Files.writeString(Paths.get(outPath), md.toString());
        System.out.println("Done!");
    }
}
