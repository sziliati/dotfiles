return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" }, opts = {} },
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
  },
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Feltétel: ")) end, desc = "Feltételes breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Indítás / folytatás" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "REPL" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Leállítás" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI" },
    { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Kiértékelés" },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    -- PHP / Xdebug (php-debug-adapter a Masonból). Xdebug: xdebug.mode=debug, start_with_request=yes, port 9003
    dap.adapters.php = { type = "executable", command = "php-debug-adapter" }
    dap.configurations.php = {
      { type = "php", request = "launch", name = "Xdebug figyelése (9003)", port = 9003 },
      { type = "php", request = "launch", name = "Aktuális szkript futtatása", port = 9003,
        program = "${file}", cwd = "${fileDirname}", runtimeExecutable = "php" },
    }

    dap.listeners.after.event_initialized.dapui = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui = function() dapui.close() end
    dap.listeners.before.event_exited.dapui = function() dapui.close() end

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual" })
  end,
}
