BabyGrowth
==========

An R function to plot weight gain of baby boys in context of the WHO percentiles

___version: 1.0 Last modified: 2014.05.05 Daniel Suveges___
* Supports custom date format
* Axis labels can be changed
* Filename can be specified
* Multiple weight units are supported: g, kg, lb

___ToDo list for further versions:___
* Support both girl and boy data
* Support all available measures: weight, length, head circumference
* More customizable plot labels
* Plot become optional, just a calculator to get baby percentile.
* More rubust error hangling
* customizable units on the chart (eg. lb-s instead of kg)

___Usage, parameters:___
```
BabyGrowth(x,y,name="Baby",unit="kg",dateformat="%B-%d",xtitle="Month",ytitle="Weight(kg)", filename="Growchart.png")
```
* Parameters:

   __x__ - Dates when the baby was measured, assuming that the first date is the date of birth

   __y__ - Measured value
   
   ___name___ - Name of the baby, used for the plot
   
   ___unit___ - Unit of the measured value. Supported units: g, kg, lb
   
   ___dateformat___ - Standard date format is supported
   
   ___xtitle___ - Title of the x axis

  ___ytitle___ - Title of the y axis
  
  ___filename___ - Output filename
  
___Sample input:___

Date values: 
```
x <- c("Jan-28", "Feb-1", "Feb-3", "Feb-10", "Feb-13", "Feb-19", "Feb-23", "Feb-25", "Feb-27")
```
Measured values: 
```
y <- c(3288.5, 2976.7, 3203.5, 3203.5, 3458.6, 3685.4, 4025.6, 4110.7, 4280.8)
```

___Sample output:___

![BabyGrowth(aron$Date, aron$Gramm, unit="kg", dateformat="%B-%d", name="Áron", xtitle="Month", ytitle="Weight (kg)")](http://kepfeltoltes.hu/140505/Growchart_www.kepfeltoltes.hu_.png)