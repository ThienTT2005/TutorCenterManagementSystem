package com.tcms.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Paths;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Thư mục uploads/ ở gốc project — nơi lưu ảnh mới upload
        String uploadPath = Paths.get(System.getProperty("user.dir"), "uploads")
                .toAbsolutePath()
                .toString()
                .replace("\\", "/");

        registry.addResourceHandler("/uploads/**")
                // Phục vụ ảnh mới upload (ngoài classpath)
                .addResourceLocations("file:" + uploadPath + "/",
                        // Fallback: ảnh cũ nằm trong classpath (static/uploads)
                        "classpath:/static/uploads/");
    }
}
