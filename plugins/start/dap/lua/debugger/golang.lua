return function(dap)
    dap.adapters.go = {
        type = "server",
        port = "${port}",
        executable = {
            command = "dlv",
            args = { "dap", "-l", "127.0.0.1:${port}" },
        }
    }

    dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
            command = "dlv",
            args = { "test", "-l", "127.0.0.1:${port}" }
        }
    }

    dap.configurations.go = {
        {
            type = "go",
            name = "Debug",
            request = "launch",
            program = "${file}",
        },
        {
            type = "delve",
            name = "Debug test",
            request = "launch",
            detached = false,
            mode = "test",
            program = "./${relativeFileDirname}"
        }
    }

    vim.notify("Delve is ready to dance 🔍🐛", vim.log.levels.INFO)
end
