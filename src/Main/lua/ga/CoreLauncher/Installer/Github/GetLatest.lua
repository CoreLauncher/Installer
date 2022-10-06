return function (Author, Package)
    local Versions = Import("ga.CoreLauncher.Installer.Github.GetVersions")(Author, Package)
    return Versions[1]
end