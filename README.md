BabyGrowth
==========

An R function to plot weight gain of babies in context of the WHO percentiles

___version: 1.2 Last modified: 2014.05.07 Daniel Suveges___
* Now supports both boy and girl weight gain charts
* Girl chart is pink, boy is blue. Later I'll make it optional

___version: 1.2 Last modified: 2014.05.07___
* Now support both boy and girl weight gain chart
* Girl chart is pink, boy's is blue. Later I'll make it optional
* Even more customizable plot details
* Legend added, with the last day of measurement

___version: 1.0 Last modified: 2014.05.05___
* Supports custom date format
* Axis labels can be changed
* Filename can be specified
* Multiple weight units are supported: g, kg, lb

___ToDo list for further versions:___
* Support all available measures: weight, length, head circumference
* Plot becomes optional, just a calculator to get baby percentile
* More rubust error handling
* Customizable units on the chart (e.g. lb-s instead of kg)

___Usage, parameters:___
```
BabyGrowth(x,y,name="Baby",sex="boy",unit="kg",
    dateformat="%B-%d",xtitle="Month",ytitle="Weight(kg)",
    filename="Growchart.png", main="'s growchart",
    legend=c("50% percentile","Baby growth","Last measaured:"))
```
* Parameters:

   __x__ - Dates when the baby was measured, assuming that the first date is the date of birth

   __y__ - Measured value
   
   ___name___ - Name of the baby, used for the plot
   
   ___unit___ - Unit of the measured value. Supported units: g, kg, lb
   
   ___dateformat___ - Based on the standard (strftime)[https://stat.ethz.ch/R-manual/R-devel/library/base/html/strptime.html] formats.
   
   ___xtitle___ - Title of the x axis

  ___ytitle___ - Title of the y axis
  
  ___filename___ - Output filename
  
  ___sex___ - Gender of the baby
  
  ___main___ - The title of the chart, the text following the baby's name
  
  ___legend___ - Customizable legend
  
### Example:

```R
# Reading function:
source("BabyGrowth.R")

# Reading sample data from a tsv file:
df = read.table("sample_input.tsv", sep="\t", header=T)

# Adjusting measured weight:
df$Gramms = as.numeric(df$Gramms)

# Look at the header:
df[1:12,]

#         Date Pound Oz   Gramms
# 1  2014-01-28     7  4 3288.545
# 2  2014-02-01     6  9 2976.700
# 3  2014-02-03     7  1 3203.496
# 4  2014-02-10     7  1 3203.496
# 5  2014-02-13     7 10 3458.642
# 6  2014-02-19     8  2 3685.438
# 7  2014-02-23     8 14 4025.632
# 8  2014-02-25     9  1 4110.681
# 9  2014-02-27     9  7 4280.778
# 10 2014-03-02     9 12 4422.526
# 11 2014-03-03     9 14 4479.225
# 12 2014-03-06    10  1 4564.273

# Calling plotter:
BabyGrowth(df$Date, df$Gramms, unit="g", dateformat="%Y-%m-%d", name="Aron", xtitle="Month", ytitle="Weight (kg)")

```

### Sample output:


x = c("2014-01-28", 
"2014-02-01", 
"2014-02-03", 
"2014-02-10", 
"2014-02-13", 
"2014-02-19", 
"2014-02-23", 
"2014-02-25", 
"2014-02-27", 
"2014-03-02", 
"2014-03-03", 
"2014-03-06", 
"2014-03-07", 
"2014-03-09", 
"2014-03-12", 
"2014-03-14", 
"2014-03-16", 
"2014-03-18", 
"2014-03-20", 
"2014-03-22", 
"2014-03-24", 
"2014-03-26", 
"2014-03-28", 
"2014-03-30", 
"2014-04-01", 
"2014-04-07", 
"2014-04-09", 
"2014-04-11", 
"2014-04-13", 
"2014-04-15", 
"2014-04-17", 
"2014-04-19", 
"2014-04-21", 
"2014-04-23", 
"2014-04-25", 
"2014-04-27", 
"2014-04-29")