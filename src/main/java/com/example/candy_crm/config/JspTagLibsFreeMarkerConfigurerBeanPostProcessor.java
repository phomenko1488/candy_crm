package com.example.candy_crm.config;

import freemarker.ext.jsp.TaglibFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import java.util.Arrays;
import java.util.regex.Pattern;

/**
 * A {@link BeanPostProcessor} that enhances {@link FreeMarkerConfigurer} bean, adding
 * {@link TaglibFactory.ClasspathMetaInfTldSource} to {@code metaInfTldSources}
 * of {@link TaglibFactory}, containing in corresponding {@link FreeMarkerConfigurer} bean.
 *
 * <p>
 * This allows JSP Taglibs ({@code *.tld} files) to be found in classpath ({@code /META-INF/*.tld}) in opposition
 * to default FreeMarker behaviour, where it searches them only in ServletContext, which doesn't work
 * when we run in embedded servlet container like {@code tomcat-embed}.
 *
 * @author Ruslan Stelmachenko
 * @since 20.02.2019
 */
@Component
public class JspTagLibsFreeMarkerConfigurerBeanPostProcessor implements BeanPostProcessor {

    @Override
    public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
        if (bean instanceof FreeMarkerConfigurer) {
            FreeMarkerConfigurer freeMarkerConfigurer = (FreeMarkerConfigurer) bean;
            freemarker.ext.jakarta.jsp.TaglibFactory taglibFactory = freeMarkerConfigurer.getTaglibFactory();

            TaglibFactory.ClasspathMetaInfTldSource classpathMetaInfTldSource =
                    new TaglibFactory.ClasspathMetaInfTldSource(Pattern.compile(".*"));

            taglibFactory.setMetaInfTldSources(Arrays.asList(classpathMetaInfTldSource));
//            taglibFactory.setClasspathTlds(Arrays.asList("/META-INF/tld/common.tld"));
        }
        return bean;
    }
}