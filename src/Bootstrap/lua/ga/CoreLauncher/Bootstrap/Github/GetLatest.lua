return function (Author, Package)
    local Versions = Import("ga.CoreLauncher.Bootstrap.Github.GetVersions")(Author, Package)
    return Versions[1]
end