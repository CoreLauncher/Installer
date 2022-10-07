print("Hello World!")

_G.CoreLauncher = {}
CoreLauncher.Http = Import("ga.CoreLauncher.Bootstrap.Libraries.Http")

if CoreLauncher.Http.HasAccess() then
    TypeWriter.Logger.Info("Checking for updates")
    Import("ga.CoreLauncher.Bootstrap.Check")
else
    TypeWriter.Logger.Warn("Skipping update check: No internet")
end

require("coro-spawn")(
    TypeWriter.This,
    {
        args = {
            "execute", "--input=" .. TypeWriter.ApplicationData .. "/CoreLauncher/CoreLauncher.twr"
        },
        stdio = {
            process.stdin.handle,
            process.stdout.handle,
            process.stderr.handle
        }
    }
).waitExit()