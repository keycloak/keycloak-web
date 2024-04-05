<script type="module">
  import { OramaClient } from "https://esm.sh/@oramacloud/client@1.0.14"
  import { RegisterSearchBox, RegisterSearchButton, RegisterSearchAllResults } from "https://esm.sh/@orama/searchbox@1.0.0-rc13"

  const oramaInstance = new OramaClient({ 
    endpoint: "https://cloud.orama.run/v1/indexes/keycloak-dev-oazad8", 
    api_key: "EJjodP21HqLhibVQlTXD1VH0QOsc3D2F" 
  })

  const colorScheme = "light"

  const baseParams = {
    oramaInstance,
    colorScheme,
    summaryGeneration: "x05yz1ws-MDusHY99mcUEIIby3Qxb+_4",
  }

  RegisterSearchBox({
    ...baseParams,
    showShowMoreLink: true,
    facetProperty: "category",
    resultsMap: {
      description: "content"
    }
  })

  RegisterSearchButton({
    colorScheme
  })

  RegisterSearchAllResults({
    ...baseParams,
    renderItem: (document) => {
      const section = document["path"].split("/").slice(0, -1).join(" > ")
      return section
    }
  })
</script>