import "@patternfly/patternfly/patternfly.css";
import "@patternfly/patternfly/patternfly-addons.css";

import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import { initReactI18next } from "react-i18next";
import i18n from "i18next";

import App from "./App.tsx";
import { MockProvider } from "./mock-providers.tsx";

// Initialize i18n
i18n.use(initReactI18next).init({
  lng: "en",
  fallbackLng: "en",
  interpolation: {
    escapeValue: false,
  },
  defaultNS: "master",
  ns: ["master"],
  resources: {
    en: {
      master: {
        adminConsolePreview: "Admin console preview",
        continue: "Continue",
        cancel: "Cancel",
        themeColorInfo:
          'Here you can set the patternfly color variables and create a "theme jar" file that you can download and put in your providers folder to apply the theme to your realm.',
        themes: "Themes",
        themeName: "Theme name",
        fileName: "File name",
        quickTheme: "Quick Theme",
        themeMode: "Theme mode",
        lightMode: "Light mode",
        darkMode: "Dark mode",
        favicon: "Favicon",
        logo: "Logo",
        backgroundImage: "Background image",
        downloadThemeJar: "Download theme jar",
        font: "Font",
        fileNameDialogTitle: "Save as",
        errorColor: "Error color",
        successColor: "Success color",
        activeColor: "Active color",
        primaryColor: "Primary color",
        primaryColorHover: "Primary color hover",
        secondaryColor: "Secondary color",
        linkColor: "Link color",
        linkColorHover: "Link color hover",
        loginPagePreview: "Login page preview",
        logoWidth: "Logo width",
        logoHeight: "Logo height",
        backgroundColor: "Background color",
        backgroundColorAccent: "Background color accent",
        backgroundColorNav: "Background color nav",
        backgroundColorHeader: "Background color header",
        iconColor: "Icon color",
        textColor: "Text color",
        themeDescription: "Theme description",
        themeDescriptionDefault:
          "Custom theme created by the Quick theme tool.",
        lightTextColor: "Light text color",
        inputBackgroundColor: "Input background color",
        inputTextColor: "Input text color",
        signOut: "Sign out",
        navigation: "Navigation",
        documentation: "Documentation",
        helpToggleInfo: "Help toggle info",
        enableHelpMode: "Enable help mode",
        enableHelp: "Enable help",
        revert: "Revert",
        uploadGeneratedThemeJar: "Upload generated theme jar",
        save: "Save",
        realmSettings: "Realm settings",
        loginTheme: "Login theme",
        accountTheme: "Account theme",
        adminConsoleTheme: "Admin console theme",
        emailTheme: "Email theme",
        internationalization: "Internationalization",
        internationalizationHelp:
          "Enable/disable internationalization for your realm",
        supportedLocales: "Supported locales",
        supportedLocalesHelp: "Locales that are supported in this realm",
        defaultLocale: "Default locale",
        defaultLocaleHelp: "The default locale for this realm",
        spinnerLoading: "Loading...",
        unknownUser: "Anonymous",
        themePreviewInfo:
          "In order to preview the theme colors, the current theme needs to be set to the one you want to preview, so we have automatically switched you to the one you want to preview.",
      },
    },
  },
  saveMissing: true,
  missingKeyHandler: function (lngs, ns, key) {
    console.log("Missing translation:", lngs, ns, key);
  },
});

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <BrowserRouter>
      <MockProvider>
        <App />
      </MockProvider>
    </BrowserRouter>
  </StrictMode>,
);
