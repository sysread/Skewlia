using Documenter
using Skewlia

makedocs(
    sitename = "Skewlia",
    format = Documenter.HTML(),
    modules = [Skewlia]
)

deploydocs(
    repo = "github.com/sysread/Skewlia.git",
)
