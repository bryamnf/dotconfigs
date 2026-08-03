return {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml'},
    root_makers = { ".git" },
    single_file_support = true,
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = { format = { enable = true } },
    },
}
