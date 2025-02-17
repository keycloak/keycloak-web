package org.keycloak.webbuilder.builders;

import org.keycloak.webbuilder.Context;

public abstract class AbstractBuilder {

    protected Context context;
    private boolean lastPrintln = false;

    public void init(Context context) throws Exception {
        this.context = context;
    }

    public void execute() throws Exception {
        System.out.println(getTitle());
        System.out.println("  ");

        build();

        if (lastPrintln) {
            System.out.println("  ");
        }
    }

    protected void printStep(String type, String detail) {
        printBuilderStep(type, detail);
        lastPrintln = true;
    }

    public static void printBuilderStep(String type, String detail) {
        System.out.println("  - [" + type + "] " + detail);
    }
    protected abstract void build() throws Exception;

    protected abstract String getTitle();

    public void close() {
    }

}
