package org.keycloak.webbuilder;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.*;

public class Translations {

    List<Language> languages = new ArrayList<>();
    List<Component> components = new ArrayList<>();
    Map<TranslationTuple, Translation> translations = new HashMap<>();

    List<String> componentOrder = List.of("theme-baselogin", "theme-baseemail", "account-ui", "theme-baseaccount", "admin-ui", "theme-baseadmin");

    private ObjectMapper objectMapper = new ObjectMapper();

    public List<Language> getLanguages() {
        return languages;
    }

    public List<Component> getComponents() {
        return components;
    }

    public Translation getTranslation(Component component, Language language) {
        return translations.get(new TranslationTuple(component, language));
    }

    public Translations() {
        try {
            HttpClient httpClient = HttpClient.newHttpClient();
            loadComponents(httpClient);
            loadLanguages(httpClient);
            loadTranslations(httpClient);
        } catch (URISyntaxException | IOException | InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    private void loadLanguages(HttpClient httpClient) throws URISyntaxException, IOException, InterruptedException {
        HttpRequest get = withAuthorization(HttpRequest
                .newBuilder(new URI("https://hosted.weblate.org/api/projects/keycloak/languages/"))
                .headers("Accept", "application/json")
                .GET()).build();
        HttpResponse<InputStream> send = httpClient.send(get, HttpResponse.BodyHandlers.ofInputStream());
        if (send.statusCode() == 429) {
            // throttled
            return;
        }
        Map<String, Object>[] wl = objectMapper.readValue(send.body(), Map[].class);
        for (Map<String, Object> language : wl) {
            Language l = new Language(
                    language.get("code").toString(),
                    language.get("name").toString(),
                    (int) language.get("total"),
                    (int) language.get("translated"),
                    (int) language.get("approved"),
                    (int) language.get("readonly")
            );
            if (!Objects.equals(l.code, "en")) {
                this.languages.add(l);
            }
        }
        languages.sort(Comparator.comparing(o -> o.name));
    }

    private void loadTranslations(HttpClient httpClient) throws URISyntaxException, IOException, InterruptedException {
        for (Component component : components) {
            HttpRequest get = withAuthorization(HttpRequest
                    .newBuilder(new URI("https://hosted.weblate.org/api/components/keycloak/" + component.slug + "/translations/"))
                    .GET()
                    .header("Accept", "application/json"))
                    .build();
            HttpResponse<InputStream> send = httpClient.send(get, HttpResponse.BodyHandlers.ofInputStream());
            if (send.statusCode() == 429) {
                // throttled
                // avoid iterating over languages later that have incomplete data
                languages.clear();
                return;
            }
            Map<String, Object> wlTranslations = objectMapper.readValue(send.body(), Map.class);
            for (Map<String, Object> translation : (ArrayList<Map<String, Object>>) wlTranslations.get("results")) {
                Map<String, Object> language = (Map<String, Object>) translation.get("language");
                Language l = getLanguage(language.get("code").toString());
                if (l == null) {
                    continue;
                }
                Translation t = new Translation((Integer) translation.get("total"), (Integer) translation.get("translated"));
                translations.put(new TranslationTuple(component, l), t);
            }
        }
    }

    private HttpRequest.Builder withAuthorization(HttpRequest.Builder builder) {
        String tokenEnvVar = System.getenv("WEBLATE_TOKEN");
        if (tokenEnvVar != null) {
            builder.header("Authorization", "Token " + tokenEnvVar);
        }
        return builder;
    }

    private Language getLanguage(String code) {
        return languages.stream().filter(language -> language.code.equals(code)).findFirst().orElse(null);
    }

    private void loadComponents(HttpClient httpClient) throws URISyntaxException, IOException, InterruptedException {
        HttpRequest get = withAuthorization(HttpRequest
                .newBuilder(new URI("https://hosted.weblate.org/api/projects/keycloak/components/"))
                .headers("Accept", "application/json")
                .GET()).build();
        HttpResponse<InputStream> send = httpClient.send(get, HttpResponse.BodyHandlers.ofInputStream());
        if (send.statusCode() == 429) {
            // throttled
            return;
        }
        Map<String, Object> wlComponents = objectMapper.readValue(send.body(), Map.class);
        for (Map<String, Object> component : (ArrayList<Map<String, Object>>) wlComponents.get("results")) {
            if ((boolean) component.get("is_glossary") == true) {
                continue;
            }
            this.components.add(new Component(
                    component.get("slug").toString(),
                    component.get("name").toString()
            ));
        }
        components.sort(Comparator.comparing(o -> componentOrder.indexOf(o.slug)));
    }

    public record Language(String code, String name, int total, int translated, int approved, int readonly) {
        public int getUnapproved() {
            return translated - approved - readonly;
        }
    }

    public record Component(String slug, String name) {
    }

    public record Translation(int total, int translated) {
        public String completionRate() {
            if (total == 0) {
                return "-";
            } else {
                return translated * 100 / total + "\u2009%";
            }
        }
    }

    public static void main(String[] args) {
        new Translations();
    }

    private record TranslationTuple(Component component, Language l) {
    }
}
