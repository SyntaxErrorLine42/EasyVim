-- Provides the SchemaStore catalog (package.json, tsconfig.json, .eslintrc, docker-compose.yml, etc.)
-- This is just data, jsonls and yamlls in lsp-configuration.lua read the schemas from it
return {
  "b0o/schemastore.nvim",
  lazy = false, -- Needs to be loaded before LSP
}
