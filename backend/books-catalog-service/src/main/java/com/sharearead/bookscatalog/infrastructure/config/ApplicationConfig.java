package com.sharearead.bookscatalog.infrastructure.config;

import org.springframework.boot.persistence.autoconfigure.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@Configuration
@EntityScan(basePackages = "com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.entity")
@ComponentScans(@ComponentScan(basePackages = "com.sharearead.bookscatalog.*"))
@EnableJpaRepositories(basePackages = "com.sharearead.bookscatalog.infrastructure.adapters.out.persistence.repository")
public class ApplicationConfig {

}
