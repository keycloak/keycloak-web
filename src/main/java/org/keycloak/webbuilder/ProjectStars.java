package org.keycloak.webbuilder;

import org.apache.commons.io.FileUtils;
import org.keycloak.webbuilder.utils.GitHubApi;
import org.kohsuke.github.GHRepository;
import org.kohsuke.github.GitHub;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

public class ProjectStars {

    private String aspectRatioLarge;

    private static final String GITHUB_ICON = "PHN2ZyBmaWxsPSIjMTgxNzE3IiByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+R2l0SHViPC90aXRsZT48cGF0aCBkPSJNMTIgLjI5N2MtNi42MyAwLTEyIDUuMzczLTEyIDEyIDAgNS4zMDMgMy40MzggOS44IDguMjA1IDExLjM4NS42LjExMy44Mi0uMjU4LjgyLS41NzcgMC0uMjg1LS4wMS0xLjA0LS4wMTUtMi4wNC0zLjMzOC43MjQtNC4wNDItMS42MS00LjA0Mi0xLjYxQzQuNDIyIDE4LjA3IDMuNjMzIDE3LjcgMy42MzMgMTcuN2MtMS4wODctLjc0NC4wODQtLjcyOS4wODQtLjcyOSAxLjIwNS4wODQgMS44MzggMS4yMzYgMS44MzggMS4yMzYgMS4wNyAxLjgzNSAyLjgwOSAxLjMwNSAzLjQ5NS45OTguMTA4LS43NzYuNDE3LTEuMzA1Ljc2LTEuNjA1LTIuNjY1LS4zLTUuNDY2LTEuMzMyLTUuNDY2LTUuOTMgMC0xLjMxLjQ2NS0yLjM4IDEuMjM1LTMuMjItLjEzNS0uMzAzLS41NC0xLjUyMy4xMDUtMy4xNzYgMCAwIDEuMDA1LS4zMjIgMy4zIDEuMjMuOTYtLjI2NyAxLjk4LS4zOTkgMy0uNDA1IDEuMDIuMDA2IDIuMDQuMTM4IDMgLjQwNSAyLjI4LTEuNTUyIDMuMjg1LTEuMjMgMy4yODUtMS4yMy42NDUgMS42NTMuMjQgMi44NzMuMTIgMy4xNzYuNzY1Ljg0IDEuMjMgMS45MSAxLjIzIDMuMjIgMCA0LjYxLTIuODA1IDUuNjI1LTUuNDc1IDUuOTIuNDIuMzYuODEgMS4wOTYuODEgMi4yMiAwIDEuNjA2LS4wMTUgMi44OTYtLjAxNSAzLjI4NiAwIC4zMTUuMjEuNjkuODI1LjU3QzIwLjU2NSAyMi4wOTIgMjQgMTcuNTkyIDI0IDEyLjI5N2MwLTYuNjI3LTUuMzczLTEyLTEyLTEyIi8+PC9zdmc+";

    public String getAspectRatioLarge() {
        return aspectRatioLarge;
    }

    public ProjectStars() {
    }

    private static String formatStarCount(int stars) {
        if (stars >= 1000) {
            return String.format("%.1fk", stars / 1000.0);
        }
        return String.valueOf(stars);
    }

    private static String generateBadge(String value) {
        int perChar = 63;
        int valueTextLength = value.length() * perChar;
        int rightWidth = valueTextLength / 10 + 8;
        int leftWidth = 90;
        int separatorX = leftWidth + 6;
        int totalWidth = separatorX + rightWidth + 1;
        int labelTextX = 535;
        int valueTextX = (separatorX * 10) + 5 + (rightWidth * 10) / 2;

        return """
                <svg xmlns="http://www.w3.org/2000/svg" width="%d" height="20">\
                <linearGradient id="a" x2="0" y2="100%%">\
                <stop offset="0" stop-color="#fcfcfc" stop-opacity="0"/>\
                <stop offset="1" stop-opacity=".1"/></linearGradient>\
                <g stroke="#d5d5d5">\
                <rect stroke="none" fill="#fcfcfc" x=".5" y=".5" width="%d" height="19" rx="2"/>\
                <rect x="%d.5" y=".5" width="%d" height="19" rx="2" fill="#fafafa"/>\
                <rect x="%d" y="7.5" width=".5" height="5" stroke="#fafafa"/>\
                <path d="M%d.5 6.5 l-3 3v1 l3 3" fill="#fafafa"/>\
                </g>\
                <image x="5" y="3" width="14" height="14" href="data:image/svg+xml;base64,%s"/>\
                <rect stroke="#d5d5d5" fill="url(#a)" x=".5" y=".5" width="%d" height="19" rx="2"/>\
                <g fill="#333" text-anchor="middle" \
                font-family="Helvetica Neue,Helvetica,Arial,sans-serif" text-rendering="geometricPrecision" \
                font-weight="700" font-size="110px" line-height="14px">\
                <text aria-hidden="true" x="%d" y="150" fill="#fff" transform="scale(.1)" textLength="630">GitHub\tStars</text>\
                <text x="%d" y="140" transform="scale(.1)" textLength="630">GitHub\tStars</text>\
                <text aria-hidden="true" x="%d" y="150" fill="#fff" transform="scale(.1)" textLength="%d">%s</text>\
                <text x="%d" y="140" transform="scale(.1)" textLength="%d">%s</text>\
                </g></svg>""".formatted(
                totalWidth,
                leftWidth,
                separatorX, rightWidth,
                separatorX,
                separatorX,
                GITHUB_ICON,
                leftWidth,
                labelTextX, labelTextX,
                valueTextX, valueTextLength, value,
                valueTextX, valueTextLength, value);
    }

    private static String escapeXml(String s) {
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }

    public void init(Context context) {
        try {
            GitHub github = GitHubApi.getInstance().get();
            int stars = 0;
            if (github != null) {
                GHRepository repo = github.getRepository("keycloak/keycloak");
                stars = repo.getStargazersCount();
            }
            String formattedStars = escapeXml(formatStarCount(stars));

            String badge = generateBadge(formattedStars);
            FileUtils.write(new File(context.getTargetDir(), "resources/images/stars-large.svg"), badge, StandardCharsets.UTF_8);
            aspectRatioLarge = totalWidth(badge) + "/20";
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static String totalWidth(String svg) {
        java.util.regex.Matcher m = java.util.regex.Pattern.compile("width=\"([0-9]+)\"").matcher(svg);
        return m.find() ? m.group(1) : "128";
    }
}
