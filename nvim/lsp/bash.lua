return {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh", "conf" },
    root_makers = { ".git" },
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)"
        },
    },
}
