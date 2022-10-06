local Author = "CoreLauncher"
local Package = Author

local FS = require("fs")
local AppData = TypeWriter.ApplicationData .. "/CoreLauncher/"
FS.mkdirSync(AppData)
local TempDir = AppData .. "/Temp/"
FS.mkdirSync(TempDir)

FS.writeFileSync(
    AppData .. "/favicon.ico",
    TypeWriter.LoadedPackages["CoreLauncher-Installer"].Resources["/favicon.ico"]
)

local Version = Import("ga.CoreLauncher.Installer.Github.GetLatest")(Author, Package)
TypeWriter.Logger.Info("Downloading CoreLauncher %s", Version.tag_name)
local DownloadURL = Import("ga.CoreLauncher.Installer.Github.GetLatestFileUrl")(Author, Package, "CoreLauncher.twr")
TypeWriter.Logger.Info("Downloading %s", DownloadURL)

local _, FileData = CoreLauncher.Http.Request(
    "GET",
    DownloadURL
)
FS.writeFileSync(
    AppData .. "CoreLauncher.twr",
    FileData
)

TypeWriter.Logger.Info("Download successful")
TypeWriter.Logger.Info("Extracting bootstrap")
FS.writeFileSync(
    AppData .. "CoreLauncher-Bootstrap.twr",
    TypeWriter.LoadedPackages["CoreLauncher-Installer"].Resources["/CoreLauncher-Bootstrap.twr"]
)
TypeWriter.Logger.Info("Extract successful")

local Finish = {
    [true] = function () -- Windows
        FS.writeFileSync(
            TempDir .. "/CreateShortCut.ps1",
            TypeWriter.LoadedPackages["CoreLauncher-Installer"].Resources["/CreateShortcut.ps1"]
        )
        local function CreateShortCut(Arg)
            local Result = require("coro-spawn")(
                "powershell.exe",
                {
                    args = {
                        "-NoProfile", "-ExecutionPolicy", "unrestricted",
                        TempDir .. "/CreateShortCut.ps1",
                        require("base64").encode(
                            require("json").encode(
                                Arg
                            )
                        )
                        
                    },
                    stdio = {
                        process.stdin.handle,
                        process.stdout.handle,
                        process.stderr.handle
                    }
                }
            )
            Result.waitExit()
        end
        local DesktopShortcut = process.env.HOMEDRIVE .. process.env.HOMEPATH .. "/Desktop/CoreLauncher.lnk"
        local MenuShortcut = process.env.APPDATA .. "/Microsoft/Windows/Start Menu/Programs/CoreLauncher.lnk"
        CreateShortCut(
            {
                From = MenuShortcut,
                To = TypeWriter.This,
                Icon = AppData .. "/favicon.ico",
                CWD = AppData,
                Arguments = "execute --input=" .. AppData .. "CoreLauncher.twr"
            }
        )
        FS.writeFileSync(
            DesktopShortcut,
            FS.readFileSync(
                MenuShortcut
            )
        )
    end,
    [false] = function () -- Not windows !?!?
        
    end
}

Finish[TypeWriter.Os == "win32"]()

require("coro-spawn")(
    TypeWriter.This,
    {
        args = {
            "execute", "--input=" .. AppData .. "CoreLauncher.twr"
        },
        detached = true
    }
)