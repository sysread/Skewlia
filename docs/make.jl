using Documenter
using Skewlia

makedocs(
    sitename = "Skewlia",
    format = Documenter.HTML(),
    modules = [Skewlia]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
