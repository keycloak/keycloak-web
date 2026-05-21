import { QuickTheme } from "@keycloak/keycloak-admin-ui";
import { MockAppContexts, mockRealm } from "./mock-providers";
import "./App.css";

function App() {
  return (
    <div className="quick-theme-app">
      <header className="quick-theme-header">
        <a href="https://www.keycloak.org/" className="quick-theme-header__logo">
          Keycloak
        </a>
        <nav className="quick-theme-header__nav">
          <a href="https://www.keycloak.org/guides#ui-customization">
            UI customization guides
          </a>
        </nav>
      </header>

      <div className="quick-theme-banner" role="status">
        <strong>Experimental.</strong> This online demo does not connect to a
        Keycloak server. Download the theme JAR and deploy it to your server as
        described in the{" "}
        <a href="https://www.keycloak.org/ui-customization/quick-theme">
          Quick Theme guide
        </a>
        .
      </div>

      <main className="quick-theme-main">
        <MockAppContexts>
          <QuickTheme realm={mockRealm} />
        </MockAppContexts>
      </main>
    </div>
  );
}

export default App;
