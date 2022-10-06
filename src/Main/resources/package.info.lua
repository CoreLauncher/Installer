-- See https://github.com/Dot-lua/TypeWriter/wiki/package.info.lua-format for more info

return { InfoVersion = 1, -- Dont touch this

    ID = "CoreLauncher-Installer", -- A unique id 
    Name = "CoreLauncher Installer",
    Description = "CoreLauncher-Installer",
    Version = "1.0.0-alpha.1",

    Author = {
        Developers = {
            "CoreByte"
        },
        Contributors = {}
    },

    Dependencies = {
        Luvit = {
            "creationix/coro-http",
            "creationix/coro-spawn",
            "creationix/coro-fs",
            "creationix/weblit",
            "creationix/base64",
            "creationix/uuid4",
            "creationix/mime",
            "luvit/secure-socket",
            "luvit/json",
            "luvit/url"
        },
        Git = {},
        Dua = {}
    },

    Contact = {
        Website = "https://cubic-inc.ga",
        Source = "https://github.com/Dot-lua/TypeWriter/",
        Socials = {}
    },

    Entrypoints = {
        Main = "ga.CoreLauncher.Installer.Main"
    }

}
