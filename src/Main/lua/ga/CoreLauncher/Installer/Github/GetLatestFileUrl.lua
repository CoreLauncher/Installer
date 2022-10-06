return function (Author, Package, File)
    return string.format(
        "https://github.com/%s/%s/releases/latest/download/%s",
        Author,
        Package, 
        File
    )
end