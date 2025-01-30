# Sources for keycloak.org

Can be built locally from IDE by running AutoBuilder main method or with Maven by running:

    mvn clean install
    
After the build is completed open `target/web/index.html` in your favourite web browser.
    
There's also an auto-builder utility that watches the filesystem and continuously rebuilds the website. This can be very useful when working on the website, especially making stylesheet changes, etc. This can be run from your IDE by running `AutoBuilder`, or from the command-line with:

    mvn -Pauto-run exec:java

To serve the website locally with a web browser specify the base URL with `KC_URL`:

    export KC_URL=http://localhost:5000
    mvn install
    npm run serve
    
Finally, when building the website to be published you need to include `-Dpublish`. This should usually not be done manually though as there is a GitHub Action that takes care of building and publishing to `https://github.com/keycloak/keycloak.github.io`.

## Server and Operator guides

Server and Operator guide sources are located at `https://github.com/keycloak/keycloak/tree/main/docs/guides` and are retrieved as a Maven dependency. By default the latest released version is used, but if you want to build the website with the latest guides from `main` first build the guides:

    git clone https://github.com/keycloak/keycloak
    cd keycloak
    mvn -pl docs clean install

Then simply build the website locally with `mvn clean install`, and the locally built guides will be available in `target/web/nightly/guides.html`.
