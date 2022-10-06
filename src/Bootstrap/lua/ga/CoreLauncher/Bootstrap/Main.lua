print("Hello World!")

_G.CoreLauncher = {}
CoreLauncher.Http = Import("ga.CoreLauncher.Installer.Libraries.Http")

TypeWriter.Logger.Info("Starting installation process")
Import("ga.CoreLauncher.Installer.Install")