# An R function to plot weight gain of baby boys in context of the WHO percentiles

# version: 1.0 Last modified: 2014.05.05 Daniel Suveges
    # Supports custom date format
    # Axis labels can be changed
    # Filename can be specified
    # Multiple weight units are supported: g, kg, lb

# ToDo list:
    # Support both girl and boy data
    # Support all available measures: weight, length, head circumference
    # More customizable plot labels
    # Plot become optional, just a calculator to get baby percentile.

# Usage, parameters:
#BabyGrowth(x,y,name="Baby",unit="kg",dateformat="%B-%d",xtitle="Month",ytitle="Weight(kg)", filename="Growchart.png")
    # x - Dates when the baby was measured, assuming that the first date is the date of birth
    # y - Measured value
    # name - name of the baby, used for the plot
    # unit - unit of the measured value. Supported units: g, kg, lb
    # dateformat - standard date format is supported
    # xtitle - title of the x axis
    # ytitle - title of the y axis
    # filename - output filename


# This function was written to plot baby growth over time 
BabyGrowth <- function(x, y, name="Baby", unit="kg", dateformat="%B-%d", xtitle="Month", ytitle="Weight (kg)", filename="Growchart.png"){
    
    # creating cdc dataframe
    csvfile <- c(
        "Month,L,M,S,2,5,10,25,50,75,90,95,98
        0,0.3487,3.3464,0.14602,2.459312,2.603994,2.757621,3.027282,3.3464,3.686659,4.011499,4.214527,4.419354
        1,0.2297,4.4709,0.13395,3.39089,3.566165,3.752603,4.080792,4.4709,4.889123,5.290726,5.542933,5.798331
        2,0.197,5.5675,0.12385,4.31889,4.522344,4.738362,5.117754,5.5675,6.048448,6.509323,6.798348,7.090758
        3,0.1738,6.3762,0.11727,5.018434,5.240269,5.475519,5.888058,6.3762,6.897306,7.395936,7.708329,8.024169
        4,0.1553,7.0023,0.11316,5.561377,5.797135,6.046988,6.484777,7.0023,7.554286,8.082087,8.412602,8.746662
        5,0.1395,7.5105,0.1108,5.996672,6.244465,6.507016,6.966941,7.5105,8.090161,8.644384,8.991445,9.342238
        6,0.1257,7.934,0.10958,6.352967,6.611702,6.885864,7.366195,7.934,8.539707,9.119041,9.481939,9.848832
        7,0.1134,8.297,0.10902,6.653301,6.922131,7.207057,7.706413,8.297,8.927371,9.530656,9.908738,10.29113
        8,0.1021,8.6151,0.10882,6.913126,7.19127,7.486158,8.003205,8.6151,9.268678,9.894622,10.28713,10.68428
        9,0.0917,8.9014,0.10881,7.144822,7.431644,7.735837,8.26946,8.9014,9.5769,10.22433,10.63055,11.04177
        10,0.082,9.1649,0.10891,7.356558,7.651572,7.964565,8.5139,9.1649,9.861313,10.5293,10.94868,11.37341
        11,0.073,9.4122,0.10906,7.55441,7.857229,8.178615,8.742959,9.4122,10.12867,10.81641,11.24845,11.6862
        12,0.0644,9.6479,0.10925,7.742219,8.052577,8.382077,8.960956,9.6479,10.38387,11.09087,11.53526,11.98574
        13,0.0563,9.8749,0.10949,7.922091,8.239848,8.577324,9.170505,9.8749,10.63014,11.35618,11.81281,12.27589
        14,0.0487,10.0953,0.10976,8.095984,8.421033,8.76637,9.373665,10.0953,10.86959,11.61449,12.08325,12.55884
        15,0.0413,10.3108,0.11007,8.265127,8.597424,8.950586,9.571948,10.3108,11.10416,11.86797,12.34891,12.83707
        16,0.0343,10.5228,0.11041,8.430734,8.770274,9.13126,9.7667,10.5228,11.33528,12.11808,12.61125,13.11206
        17,0.0275,10.7319,0.11079,8.593128,8.939942,9.308795,9.958406,10.7319,11.5637,12.36571,12.87128,13.38491
        18,0.0211,10.9385,0.11119,8.752902,9.107002,9.483736,10.14755,10.9385,11.7897,12.61101,13.12906,13.65558
        19,0.0148,11.143,0.11164,8.909889,9.27136,9.656076,10.33431,11.143,12.01396,12.855,13.38579,13.92552
        20,0.0087,11.3462,0.11211,9.065209,9.434095,9.826848,10.51961,11.3462,12.23713,13.09811,13.64181,14.19492
        21,0.0029,11.5486,0.11261,9.219037,9.595435,9.996335,10.70383,11.5486,12.45983,13.3411,13.89795,14.46469
        22,-0.0028,11.7504,0.11314,9.371554,9.755556,10.16471,10.88716,11.7504,12.6823,13.58426,14.15453,14.7352
        23,-0.0083,11.9514,0.11369,9.522741,9.914417,10.33191,11.06946,11.9514,12.90424,13.82718,14.41108,15.0059
        24,-0.0137,12.1515,0.11426,9.672527,10.07194,10.49784,11.25065,12.1515,13.12555,14.06979,14.66753,15.27674"
    )
    write(csvfile, file="temp.csv")
    cdc_df <- read.csv("temp.csv",header=T)
    
    # Checking if the number of date and weight values are equal
    stopifnot(length(x) == length(y))
    cat("Number of points are OK: ",length(x),"\n")

    # Checking if the units are any of the allowed (g, kg, lb)
    stopifnot(unit == "kg" | unit == "g" | unit == "lb")
    cat("Provided weight unit is: ", unit, "\n")
    
    # Converting the weight units, default weight unit is kg. Deal with g and lb
    # Other provided units will not be allowed
    if (unit == "lb"){ y = y / 2.2046}
    if (unit == "g"){ y = y / 1000}
    
    # Convering the date values into difftime object
    # At this point, there is no error handling
    date      <- as.Date(x, format=dateformat)
    xmonth    <- (date - date[1])/30.5 # Assuming the first date value is the birth date
    cat("Growth period: ", date[length(date)]- date[1], " days\n")
    
    # Setting up plot parameters
    header  <- paste(name, "'s Growthchart")
    xlime   <- c(0, xmonth[length(xmonth)]*1.2)
    ylime   <- c(2, y[length(y)]*1.1)
    
    # Initializing plot area:
    png(filename, height=400, width=550)
    par(xpd=F)
    plot(y=-4, x=-13, col="red", xaxs='i', ylim=ylime, xlim=xlime, main=header, xlab=xtitle, ylab=ytitle)
    
    # Adding the percentile ranges as polygons, data extracted from the CDC growchart page.
    polygon(y=c(cdc_df$X2,  rev(cdc_df$X5)),  x=c(cdc_df$Month, rev(cdc_df$Month)), col="#BFEFFF", border=F)
    polygon(y=c(cdc_df$X5,  rev(cdc_df$X10)), x=c(cdc_df$Month, rev(cdc_df$Month)), col="#B0E2FF", border=F)
    polygon(y=c(cdc_df$X10, rev(cdc_df$X25)), x=c(cdc_df$Month, rev(cdc_df$Month)), col="#82cffd", border=F)
    polygon(y=c(cdc_df$X25, rev(cdc_df$X75)), x=c(cdc_df$Month, rev(cdc_df$Month)), col="#67C8FF", border=F)
    polygon(y=c(cdc_df$X75, rev(cdc_df$X90)), x=c(cdc_df$Month, rev(cdc_df$Month)), col="#82cffd", border=F)
    polygon(y=c(cdc_df$X90, rev(cdc_df$X95)), x=c(cdc_df$Month, rev(cdc_df$Month)), col="#B0E2FF", border=F)
    polygon(y=c(cdc_df$X95, rev(cdc_df$X98)), x=c(cdc_df$Month, rev(cdc_df$Month)), col="#BFEFFF", border=F)
    
    # Adding 50 percentile line
    lines(x=cdc_df$Month, y=cdc_df$X50, col="blue")
    
    # Adding percentile labels:
    percentile_position <- function(x, y, x_max, y_max){
        
        # Find first outside points:
        x_out   <- min(which(x > x_max))
        y_out   <- min(which(y > y_max))
        o       <- min(x_out, y_out) # the index of the first outside point
        
        # Finding y crossing:
        y_cross <- y[o-1] + (x_max - x[o-1])*(y[o] -y[o-1] )/(x[o] - x[o-1])
        
        # Finding x crossing:
        x_cross <- x[o-1] + (y_max - y[o-1])*(x[o] -x[o-1] )/(y[o] - y[o-1])

        if (y_cross > y_max){
            y_cross <- y_max
        }
        if (x_cross > x_max){
            x_cross <- x_max * 0.96
        }
        
        return (c(x_cross,y_cross))
    }
    coord <- percentile_position(cdc_df$Month, cdc_df$X98, xlime[2], ylime[2])
    text(coord[1], coord[2], labels="98%", cex=0.65, col="blue")
    coord <- percentile_position(cdc_df$Month, cdc_df$X95, xlime[2], ylime[2])
    text(coord[1], coord[2], labels="95%", cex=0.65, col="blue")
    coord <- percentile_position(cdc_df$Month, cdc_df$X90, xlime[2], ylime[2])
    text(coord[1], coord[2], labels="90%", cex=0.65, col="blue")
    coord <- percentile_position(cdc_df$Month, cdc_df$X75, xlime[2], ylime[2])
    text(coord[1], coord[2], labels="75%", cex=0.65, col="blue")    
    coord <- percentile_position(cdc_df$Month, cdc_df$X50, xlime[2], ylime[2])
    text(coord[1], coord[2], labels="50%", cex=0.65, col="blue")
    coord <- percentile_position(cdc_df$Month, cdc_df$X25, xlime[2], ylime[2])
    text(coord[1], coord[2], labels="25%", cex=0.65, col="blue")
    coord <- percentile_position(cdc_df$Month, cdc_df$X10, xlime[2], ylime[2])
    text(coord[1], coord[2], labels="10%", cex=0.65, col="blue")    
    coord <- percentile_position(cdc_df$Month, cdc_df$X5, xlime[2], ylime[2])
    text(coord[1], coord[2], labels="5%", cex=0.65, col="blue")
    coord <- percentile_position(cdc_df$Month, cdc_df$X2, xlime[2], ylime[2])
    text(coord[1], coord[2], labels="2%", cex=0.65, col="blue")     
 
    # Adding baby data:
    par(new=T)
    plot(y=aron$Gramm, x=aronMonth, ylim=ylime, xlim=xlime, xaxs='i', xlab=" ", ylab=" ", main=" ", col="red", pch=19, cex=0.5, xaxt='n', yaxt='n')
    
    # Adding footnote:
    mtext("Percentiles downloaded from http://www.cdc.gov/growthcharts/who_charts.htm", side=1, padj=9, cex=0.75)
    dev.off()
}
