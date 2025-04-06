return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "(*.schema.json" },
          url = "https://json-schema.org/draft/2019-09/schema",
        },
        {
          fileMatch = { ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          fileMatch = { "turbo.json" },
          url = "https://turbo.build/schema.json",
        },
        {
          fileMatch = { "composer.json" },
          url = "https://raw.githubusercontent.com/composer/composer/master/res/composer-schema.json",
        },
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = { "compile_commands.json" },
          url = "https://json.schemastore.org/compile-commands.json",
        },
        {
          fileMatch = { ".prettierrc" },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        {
          fileMatch = { "deno.json", "deno.jsonc" },
          url = "https://deno.land/x/deno/cli/schemas/config-file.v1.json",
        },
      },
    },
  },
}
