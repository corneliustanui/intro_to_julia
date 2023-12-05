
# install packages
Pkg.add("CairoMakie")

# load packages
using CSV   
using DataFrames  
using Makie 
using CairoMakie
using Dates 
using StatsPlots  
using StatsBase
using Pipe

# IMPORT CSV DATA 
STIData1 = CSV.read("./Data/Clean_STIData.csv", DataFrame)

# VISUALISATION - Using Makie module

scatterlines1 = scatterlines(STIData1.weight, STIData1.height)

scatter1 = Plots.scatter(
    STIData1.weight, 
    STIData1.height,
    color = STIData1.sex,
    colormap = :plasma,
    markersize = STIData1.age /7,
    title = "Scatter Plot Weight vs Height, by Age and Sex", 
    xlabel = "Height(cm)",
    ylabel = "Weight(Kg)",
        label = false
    )

savefig(scatter1,"./Graphs/Scatter_1.png")