load("dirs.Rda")

dirs <- dirs[!grepl("Rproj", dirs)]
dirs <- dirs[!grepl("git", dirs)]

for(i in 1:length(dirs)){
  dir.create(dirs[i])
}
