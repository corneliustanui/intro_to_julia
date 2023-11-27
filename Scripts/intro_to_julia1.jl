
# DIRECTORY SET UP AND PROJECT MANAGEMENT
# To set up a directory where the project will be self-contained
# go to the terminal (REPL) and type ']', this will open the 'Pkg'
# mode. In this mode, type 'activate' and paste the project's 
# root directory, in double quotes, e.g.
# activate "C:\Users\CORNELIUS\OneDrive\Folders\Personal Projects\Julia\Project 1"
# and hit enter, this will initialise the directory where packages will be stored
# Install the packages while still in this 'Pkg' mode. To exit the mode, click 
# 'backspace' on your keyboard. 

# It is important to save the root directoy in an object, which you can re-use
root = dirname(@__FILE__)

# to concat current root dir with a file
joinpath(root, "project1.jl")

# install packages
using Pkg # package management package, or package for installing other packages
Pkg.add("CSV")  # install CSV package, for reading CSV files
Pkg.add("DataFrames") # for processing of tabular data
Pkg.add("Plots") # for vislualisation
Pkg.add("Makie") # for vislualisation
Pkg.add("Dates") # for date handling

# load packages
using CSV # load CSV package,  
using DataFrames  
using Plots 
using Makie 
using Dates 

# all palckages can be loaded in one line axis
# using CSV, DataFrames, Plots

# generating vectors
# x-axis
x = 1:10
collect(x) # gather the vector
 
# y-axis
y = 11:20
collect(y) # 

for i in x
    for j in y
        xy = i * j
    end   
end

plot(x, y)


 
# simple plotting
# plot(x, y)