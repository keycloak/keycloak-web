# Sources for keycloak.org

Can be built locally from IDE by running AutoBuilder main method or with Maven by running:

    mvn clean install
    
After the build is compeleted open `target/web/index.html` in your favourite web browser.
    
To include server guides from `https://github.com/keycloak/keycloak/tree/main/docs/guides` first you need to build those guides an install to your local maven repository, then you can build the website with:

    mvn clean install -Pserver-guides
    
There's also an auto-builder utility that watches the filesystem and continiously rebuilds the website. This can be very useful when working on the website, especially making stylesheet changes, etc. This can be ran from your IDE by running `AutoBuilder`, or from the command-line with:

    mvn -Pauto-run exec:java
    
Finally, when building the website to be published you need to include `-Dpublish`. This should usually not be done manually though as there is a GitHub Action that takes care of building and publishing to `https://github.com/keycloak/keycloak.github.io`.
