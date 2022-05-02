using Colab
using Test
using HTTP

@testset "Colab.jl" begin
    @test HTTP.get("https://raw.githubusercontent.com/Chandu-4444/Colab.jl/main/src/assets/Config_Notebook.json").status == 200
end
