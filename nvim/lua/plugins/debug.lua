return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      require("dapui").setup()
      require("dap-go").setup()
      -- dap.configurations.go = {
      --   {
      --     type = "go",
      --     name = "Debug o2nitro",
      --     request = "launch",
      --     program = "${workspaceFolder}/cmd/o2nitro/main.go",
      --     dlvToolPath = vim.fn.exepath("dlv"), -- Ensure Delve (dlv) is in your PATH
      --     env = {
      --       STATIC_ENV = "dev",
      --       API_GATEWAY_SSR = "http://data-api.wp.pl/graphql",
      --       STREAM_API_HOST = "http://o2nitro-backend-streamapi-ext.nginx.wp.dc-1.lb.dcwp.pl",
      --     },
      --   },
      -- }
      -- Handled by nvim-dap-go
      dap.adapters.go = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>dt", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<leader>dc", dap.continue)
      vim.keymap.set("n", "<leader>dtt", dap.terminate)
      vim.keymap.set("n", "<leader>dr", function()
        ui.open({ reset = "true" })
      end, { noremap = true })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
