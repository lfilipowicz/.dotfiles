local util = require("lspconfig.util")
return {
  cmd = { "graphql-lsp", "server", "-m", "stream" },
  filetypes = { "graphql", "gql" },
  root_dir = util.root_pattern(".git", ".graphqlrc*", ".graphql.config.*", "graphql.config.*"),
}
