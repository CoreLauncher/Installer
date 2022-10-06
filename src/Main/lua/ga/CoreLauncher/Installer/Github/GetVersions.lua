return function (Author, Package)
    local Response, Body = CoreLauncher.Http.JsonRequest(
        "GET",
        string.format(
            "https://api.github.com/repos/%s/%s/releases",
            Author,
            Package
        )
    )
    return Body
end