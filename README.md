# Sources for keycloak.org

Build the website locally with Maven:

    ./mvnw clean install
    
After the build is completed open `target/web/index.html` in your favourite web browser.
    
An auto-builder watches the filesystem and continuously rebuilds the website:

    ./mvnw -Pauto-run exec:java

To serve the website locally with a web browser, specify the base URL with `KC_URL` and start up a Node-based web server:

    export KC_URL=http://localhost:5000
    ./mvnw clean install -Dpublish
    npm run serve
    
Finally, when building the website to be published you need to include `-Dpublish`. This should usually not be done manually though as there is a GitHub Action that takes care of building and publishing to `https://github.com/keycloak/keycloak.github.io`.

## Server and Operator guides

Server and Operator guide sources are located at `https://github.com/keycloak/keycloak/tree/main/docs/guides` and are retrieved as a Maven dependency. By default the latest released version is used, but if you want to build the website with the latest guides from `main` first build the guides:

    git clone https://github.com/keycloak/keycloak
    cd keycloak
    ./mvnw -pl docs clean install

Then simply build the website locally with `./mvnw clean install`, and the locally built guides will be available in `target/web/nightly/guides.html`.

### Archived Server and Operator guides

The current guide version is explicitly configured by `version.keycloak` in `pom.xml`.
Archived guides are optional and are only built when their exact patch versions are passed to Maven:

```shell
./mvnw clean install -Dversion.keycloak-previous-1=26.7.5 -Dversion.keycloak-previous-2=26.6.4
```
