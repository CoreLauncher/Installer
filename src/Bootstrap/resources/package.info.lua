-- See https://github.com/Dot-lua/TypeWriter/wiki/package.info.lua-format for more info

return { InfoVersion = 1, -- Dont touch this

    ID = "CoreLauncher-Bootstrap", -- A unique id 
    Name = "CoreLauncher Bootstrap",
    Description = "CoreLauncher-Bootstrap",
    Version = "1.0.0",

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
            "luvit/json"
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
        Main = "ga.CoreLauncher.Bootstrap.Main"
    }

}
