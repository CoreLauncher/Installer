local FS = require("fs")

local AppData = TypeWriter.ApplicationData .. "/CoreLauncher/"
local TempDir = AppData .. "/Temp/"
FS.mkdirSync(TempDir)

local ThisVersion = FS.readFileSync(AppData .. "/Version.txt")
local ThatVersion = Import("ga.CoreLauncher.Bootstrap.Github.GetLatest")("CoreLauncher", "CoreLauncher").tag_name

p(ThisVersion, ThatVersion)
if ThisVersion == ThatVersion then
    TypeWriter.Logger.Info("You are running the latest version of CoreLauncher (%s)", ThisVersion)
    return
end

TypeWriter.Logger.Info("You are not running the latest version of CoreLauncher (Local: %s Remote: %s)", ThisVersion, ThatVersion)
TypeWriter.Logger.Info("Downloading installer")

local DownloadUrl
local NeedsExtract = false
local FileName
local GetLatestUrl = Import("ga.CoreLauncher.Bootstrap.Github.GetLatestFileUrl")
if TypeWriter.Os == "win32" then
    DownloadUrl = GetLatestUrl("CoreLauncher", "Installer", "CoreLauncher-Installer.exe")
    FileName = "CoreLauncher-Installer.exe"
else
    DownloadUrl = GetLatestUrl("CoreLauncher", "Installer", "CoreLauncher-Installer.tar")
    NeedsExtract = true
    FileName = "CoreLauncher-Installer.tar"
end

TypeWriter.Logger.Info("Downloading %s to %s", DownloadUrl, FileName)
local _, FileData = CoreLauncher.Http.Request(
    "GET",
    DownloadUrl
)
local function GetFile()
    return TempDir .. "/" .. FileName
end
FS.writeFileSync(
    GetFile(),
    FileData
)
TypeWriter.Logger.Info("Download complete")

if NeedsExtract then
    TypeWriter.Logger.Info("Extracting installer...")
end

local Result, Error = require("coro-spawn")(
    GetFile(),
    {
        args = {
            "--nowait=true"
        },
        stdio = {
            process.stdin.handle,
            process.stdout.handle,
            process.stderr.handle
        }
    }
)
Result.waitExit()