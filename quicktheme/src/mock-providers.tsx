import type { PropsWithChildren } from "react";
import type RealmRepresentation from "@keycloak/keycloak-admin-client/lib/defs/realmRepresentation";
import {
  KeycloakProvider,
  AccessContext,
  WhoAmIContext,
  RealmContext,
} from "@keycloak/keycloak-admin-ui";

// Mock Keycloak instance that doesn't require authentication
// eslint-disable-next-line @typescript-eslint/no-explicit-any
const createMockKeycloak = (): any => ({
  authenticated: true,
  token: "mock-token",
  tokenParsed: { sub: "mock-user-id" },
  subject: "mock-user-id",
  responseMode: "query",
  responseType: "code",
  flow: "standard",
  timeSkew: 0,
  idToken: "mock-id-token",
  idTokenParsed: { sub: "mock-user-id" },
  init: () => Promise.resolve(true),
  login: () => Promise.resolve(),
  logout: () => Promise.resolve(),
  register: () => Promise.resolve(),
  accountManagement: () => Promise.resolve(),
  createLoginUrl: () => "",
  createLogoutUrl: () => "",
  createRegisterUrl: () => "",
  createAccountUrl: () => "",
  isTokenExpired: () => false,
  updateToken: () => Promise.resolve(true),
  clearToken: () => {},
  hasRealmRole: () => true,
  hasResourceRole: () => true,
  loadUserProfile: () => Promise.resolve({}),
  loadUserInfo: () => Promise.resolve({}),
});

// Base URL for static theme assets (e.g. /quick-theme on keycloak.org)
const resourceBase = import.meta.env.BASE_URL.replace(/\/$/, "");

// Mock environment configuration
const mockEnvironment = {
  adminBaseUrl: "",
  resourceUrl: resourceBase,
  // Resolve /resources/<version>/login/... to /quick-theme/login/... when hosted under /quick-theme/
  resourceVersion: "../quick-theme",
  logo: "",
  logoUrl: "",
  serverBaseUrl: "",
  realm: "master",
  clientId: "quicktheme",
};

// Mock realm data for standalone mode
export const mockRealm: RealmRepresentation = {
  realm: "master",
  displayName: "Master Realm",
  loginTheme: "keycloak",
  accountTheme: "keycloak",
  adminTheme: "keycloak.v2",
  emailTheme: "keycloak",
  internationalizationEnabled: false,
  supportedLocales: ["en"],
  defaultLocale: "en",
};

// Mock WhoAmI data
// eslint-disable-next-line @typescript-eslint/no-explicit-any
const mockWhoAmI: any = {
  realm: "master",
  userId: "mock-user-id",
  displayName: "Mock User",
  locale: "en",
  createRealm: true,
  realm_access: {
    master: ["manage-realm", "view-realm", "manage-users", "view-users"],
  },
  temporary: false,
};

// Provides all required contexts with mock data
export const MockAppContexts = ({ children }: PropsWithChildren) => {
  return (
    <RealmContext.Provider
      value={{
        realm: "master",
        realmRepresentation: mockRealm,
        refresh: () => {},
      }}
    >
      <WhoAmIContext.Provider
        value={{
          whoAmI: mockWhoAmI,
          refresh: () => {},
        }}
      >
        <AccessContext.Provider
          value={{
            hasAccess: () => true,
            hasSomeAccess: () => true,
          }}
        >
          {children}
        </AccessContext.Provider>
      </WhoAmIContext.Provider>
    </RealmContext.Provider>
  );
};

// Top-level provider (wraps KeycloakProvider with mock keycloak)
export const MockProvider = ({ children }: PropsWithChildren) => {
  return (
    <KeycloakProvider
      environment={mockEnvironment}
      keycloak={createMockKeycloak()}
    >
      {children}
    </KeycloakProvider>
  );
};
