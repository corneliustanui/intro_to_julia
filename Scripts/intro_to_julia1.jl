
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
joinpath(root, "intro_to_julia1.jl")

# install packages
using Pkg # package management package, or package for installing other packages
Pkg.add("CSV")  # install CSV package, for reading CSV files
Pkg.add("DataFrames") # for processing of tabular data
Pkg.add("Plots") # for vislualisation
Pkg.add("Makie") # for vislualisation
Pkg.add("Dates") # for date handling
Pkg.add("Random") # Random number generation
Pkg.add("Markdown") # Report generation
Pkg.add("StatsPlots") # For representing various plots
Pkg.add("Distributions") # For random variable creation 
Pkg.add("StatsBase") # For basic statistical operations 
Pkg.add("GLM") # For linear models
Pkg.add("StatsBase") # for statistical functions

# load packages
using CSV # load CSV package,  
using DataFrames  
using Plots 
using Makie 
using Dates 
using Random: seed!
using Markdown
using StatsPlots  
using Distributions  
using StatsBase
using GLM
using StatsBase

# all palckages can be loaded in one line 
# using CSV, DataFrames, Plots

# generating vectors
# x-axis
x = 1:10
collect(x) # gather the vector
 
# y-axis
y = 11:20
collect(y) 

# DataFrames
my_seed = seed!(123)
my_seed
DataF1 = DataFrame(
    Name = ["Cory", "Ann", "Jane", "Moses", "Rama"],
    Age = rand(30:1:60, 5),
    Sex = ["Male", "Female", "Female", "Male", "Female"]
    )

# View the first 2 records
first(DataF1, 2)

# View the last 2 records
last(DataF1, 2)

# IMPORT CSV DATA 
STIData1 = CSV.read("./Data/STIData.csv", DataFrame)

# view the first 2 records
first(STIData1, 5)

# slicing a data frame
STIData1[1, 5]  # extract element at row 1 column 5
STIData1[1:3, 1:5]  # extract the first 3 rows and first 5 columns
STIData1[begin, end] # extract element in first rwow, last column
STIData1[begin + 3, end - 4]
STIData1[begin + 2, begin + 2]

# CONDUCT DATA CLEANING
# check for and remove duplicates
# 1) unique rows by all columns
unique(STIData1)

# 2) unique rows by ID column
unique(STIData1.IdNumber)

# 3) unique rows by ID column and another column
unique([STIData1.IdNumber, STIData1.Sex])

# 4) unique rows by ID column and another column, but retaining the rest of the columns

# 5) Identify duplicates




# deselect a few columns, 
STIData2 = select(
    STIData1,
    Not(:IdNumber, :CaseStatus, :Date, :A1Age)
)

# rename columns (similar to 'select' syntax)
STIData2 = rename(
    STIData1,
    :IdNumber => :id_number, 
    :CaseStatus => :case_status, 
)

# select a few columns, while renaming at the same time
STIData2 = select(
    STIData1, 
        :IdNumber => :id_number, :CaseStatus => :case_status, 
        :Date => :date, :A1Age => :age, :Sex => :sex, 
        :AgeFirstSex => :age_first_sex, :A2Occupation => :occupation, 
        :A3Church => :church, :A4LevelOfEducation => :level_education, 
        :A5MaritalStatus => :marital_status, :Weight => :weight, 
        :Height => :height, :DurationOfillness => :duration_illness, 
        :N11Usedcondom => :used_condom, :N13TakenAlcohol => :taken_alcohol, 
        :Typeofsti => :type_sti, :N2SexDebut => :sex_debut
)

# clean string variables
first(STIData2, 6)

# function to remove numbers and space, and convert to upper case
remove_nums_and_space = function (x)
    x1 = replace(x, r"[\d|\s]" => "") |>
    uppercase
    return x1
end

STIData2.occupation = remove_nums_and_space.(STIData2.occupation)
STIData2.church = remove_nums_and_space.(STIData2.church)
STIData2.level_education = remove_nums_and_space.(STIData2.level_education)
STIData2.marital_status = remove_nums_and_space.(STIData2.marital_status)
STIData2.used_condom = remove_nums_and_space.(STIData2.used_condom)
STIData2.taken_alcohol = remove_nums_and_space.(STIData2.taken_alcohol)
# STIData2.type_sti = replace(STIData2.type_sti, r"\s" => "")

# clean categorical variables 

# SUMMARY STATISTCS
names(STIData2)  # pring col names
size(STIData2) # check dimesnions of the dataframe
size(STIData2, 1)
size(STIData2, 2)
describe(STIData2)
describe(STIData2)

# different ways of accessing a variable
describe(STIData2.age)
describe(STIData2."age")

describe(STIData2[:, :age])
describe(STIData2[:, "age"])

describe(STIData2[!, :age])
describe(STIData2[!, "age"])

# the ':all' option prints all summary stats
describe(STIData2, :all, cols = :age)
describe(STIData2, :all, cols = :sex)

# 1) Measures of Central Tendecy 
mean(STIData2.age)
var(STIData2.age)
std(STIData2.age)
minimum(STIData2.age)
maximum(STIData2.age)
kurtosis(STIData2.age)
skewness(STIData2.age)
sem(STIData2.age) # standard error of the mean
mode(STIData2.age)

median(STIData2.age)
percentile(STIData2.age, 50)
percentile(STIData2.age, 90)
iqr(STIData2.age)
nquantile(STIData2.age, 5)
quantile(STIData2.age)
span(STIData2.age) # same as max - min

# 2) Measures of Central Tendecy by Groups



# 3) Tables

# 4) Two-way tables

# 5) Two-way tables, with hypothesis testing 

# INFERENTIAL ANALYSIS
# 1) Linear regression
fm = @formula(weight ~ age + height + sex)
lr_m1 = lm(fm, STIData2)

# 2) Negative Binominal
nbr_m1 = glm(
    @formula(duration_illness ~ age + weight + height + sex), 
    STIData2, 
    NegativeBinomial(), 
    LogLink()
)

# 3) Poisson regression
po_m1 = glm(
    @formula(duration_illness ~ age + weight + height + sex), 
    STIData2, 
    Poisson()
)

# VISUALISATION
# check outliers
boxplot1 = Plots.boxplot(
    STIData2.age, 
    title = "Box Plot - Age", 
    ylabel = "Age (years)", 
    legend = false
)

savefig(boxplot1,"./Graphs/Boxplot1.png")

# scatter plot 
scatter1 = Plots.scatter(
    STIData2.height,
    STIData2.weight,  
    title = "Scatter Plot Height vs Weight", 
    xlabel = "Height(cm)",
    ylabel = "Weight(Kg)", 
    legend = false
)

savefig(scatter1,"./Graphs/Scatter1.png")

# histogram
histogram1 = Plots.histogram(
    STIData2.weight, 
    title = "Density Plot - Weight", 
    ylabel = "Frequency", 
    xlabel = "Weight(Kgs)", 
    legend = false,
    color = "gold"
)

savefig(histogram1,"./Graphs/Histogram1.png")

# density plot
density1 = Plots.density(
    STIData2.age , 
    title = "Density Plot - Age", 
    ylabel = "Frequency", 
    xlabel = "Age(years)", 
    legend = false,
    color = "green"
)

savefig(density1,"./Graphs/Density1.png")

density2 = Plots.density(
    STIData2.weight , 
    title = "Density Plot - Weight", 
    ylabel = "Frequency", 
    xlabel = "Weight(Kgs)", 
    legend = false,
    color = "#3055"
)

savefig(density2,"./Graphs/Density2.png")

# combining Graphs
boxplot1 = Plots.density!(
    STIData2.age, 
    title = "Box Plot - Age", 
    ylabel = "Age (year)", 
    legend = true
)

boxplot1 = Plots.density!(
    STIData2.weight, 
    title = "Box Plot - Weight", 
    ylabel = "Weight (Kgs)", 
    legend = true
)

# bar graph1
first(STIData2, 6)

bar1 = Plots.bar(
    STIData2.level_education,
    STIData2.duration_illness,
    title = "Box Plot - Weight", 
    ylabel = "Weight (Kgs)", 
    legend = false
)

savefig(bar1,"./Graphs/Bar1.png")

# bar graph2
bar2 = Plots.bar(
    STIData2.sex,
    [STIData2.age, STIData2.height],
    title = "Box Plot - Weight", 
    ylabel = "Weight (Kgs)", 
    legend = true,
    label = ["Age" "Duration of Illness"]
)

savefig(bar2,"./Graphs/Bar2.png")

# bar graph2

# bar graph3