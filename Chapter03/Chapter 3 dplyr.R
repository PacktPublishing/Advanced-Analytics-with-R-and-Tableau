install.packages("dplyr")
install.packages("rCharts")
install.packages("RColorBrewer")
install.packages("WDI")
install.packages("countrycode")
install.packages("reshape")

library(reshape)
library(dplyr)
library(rCharts)
library(RColorBrewer)
library(countrycode)
library(WDI)


# C:\Users\Jen_2\OneDrive for Business\Technology\DATA\WPP2015_POP_F01_1_TOTAL_POPULATION_BOTH_SEXES.csv

dat <- read.csv("C:\\Users\\Jen\\OneDrive - Data Relish Ltd\\Technology\\DATA\\WPP2015_POP_F01_1_TOTAL_POPULATION_BOTH_SEXES.csv")
summary(dat)
head(dat)

#regions <- c("Africa", "Latin America and the Caribbean", "Northern America", "Europe", "Oceania", "Asia")

#variants <- c("Low", "Medium", "High", "Constant fertility")

# c_codes<-read.csv("http://data.okfn.org/data/core/country-list/r/data.csv")
# summary(c_codes)
# head(c_codes)
# dim(c_codes)

rename(dat, Code = Country.code)

# filter
# filter(flights, month == 1 | month == 2)
# It is more clear wht we are trying to do. Intuitive.
filter(dat, Major.area..region..country.or.area.. == "WORLD")

# We can slice rows by position
slice(dat, 1:3)

# verbose R
# flights[flights$month == 1 & flights$day == 1, ]
dat[dat$Major.area..region..country.or.area.. == "WORLD"]

# arrange reorders them
# arrange(flights, year, month, day) could be used when it's pivoted
# In this case, we get the data in Country Code order.
arrange(dat, Country.code)

# We could also do this in descending order
arrange(dat, desc(Country.code))

# You can rename variables with select() by using named arguments:
select(dat,Index,Variant,region=Major.area..region..country.or.area.., Notes, Countrycode=Country.code )

# But because select() drops all the variables not explicitly mentioned, it's not that useful. Instead, use rename():
rename(dat,Index=Index,Variant=Variant,region=Major.area..region..country.or.area.., Notes=Notes, Countrycode=Country.code )

# A common use of select() is to find the values of a set of variables. 
# This is particularly useful in conjunction with the distinct() verb which only returns the unique values in a table.
sampledat <- distinct(select(dat,Index,Variant,region=Major.area..region..country.or.area.., Notes, Countrycode=Country.code, X2015=X2015, X2016=X2016, X2017=X2017 ) )
head(sampledat)


distinctdat <- distinct(select(dat,Index=Index,Variant=Variant,Region=Major.area..region..country.or.area.., Notes, Countrycode=Country.code,
"2015"=X2015, "2016"=X2016,"2017"=X2017,"2018"=X2018,"2019"=X2019,"2020"=X2020,
"2021"=X2021,"2022"=X2022,"2023"=X2023,"2024"=X2024,"2025"=X2025,"2026"=X2026,"2027"=X2027,"2028"=X2028,"2029"=X2029,
"2030"=X2030,"2031"=X2031,"2032"=X2032,"2033"=X2033,"2034"=X2034,"2035"=X2035) )

head(distinctdat)

melteddata <- melt(distinctdat, id=c("Index","Variant","Region","Notes","Countrycode"))
slice(melteddata, 1:10)
summary(melteddata)
melteddata %>% rename(PopulationCount = value)

# rename the year column
rename(melteddata,PopulationCount = value)
melteddata$Year <- melteddata$variable
melteddata$PopulationCount <- melteddata$value
melteddata <- select(melteddata, select=-value, -variable)


melteddata$PopulationCount <- as.factor(melteddata$PopulationCount)
melteddata$PopulationCount <- gsub(" ","",melteddata$PopulationCount)
melteddata$PopulationCount <- as.numeric(melteddata$PopulationCount)

write.csv(melteddata, "melteddata.csv")

# cast the melted data
# cast(data, formula, function) 
Yearmeans <- cast(melteddata, Index~Year, mean)


OverallPopulationmean <- summarise(melteddata, count=n(), 
                                   OverallPopulationmean = mean(melteddata$PopulationCount, na.rm=TRUE))
head(OverallPopulationmean)

melteddata

#Often you work with large datasets with many columns but only a few are actually of interest to you. 
#select() allows you to rapidly zoom in on a useful subset using operations that usually only work on numeric variable positions:

#But because select() drops all the variables not explicitly mentioned, it's not that useful. Instead, use rename():

demo=merge(dat, c_codes,by.dat ="Country.code",by.c_codes ="Code") #left outer join
head(demo)

countrycode(dat,"Name", "iso3c")

#Use the WDIsearch function to get a list of fertility rate indicators
indicatorMetaData <- WDIsearch("Fertility rate", field="name", short=FALSE)

# Define a list of countries for which to pull data
countries <- c("United States", "Britain", "Sweden", "Germany")

# Convert the country names to iso2c format used in the World Bank data
iso2cNames <- countrycode(countries, "country.name", "iso2c")

# Pull data for each countries for the first two fertility rate indicators, for the years 2001 to 2011
wdiData <- WDI(iso2cNames, indicatorMetaData[1:2,1], start=2001, end=2011)

# Pull out indicator names
indicatorNames <- indicatorMetaData[1:2, 1]

# Create trend charts for the first two indicators
for (indicatorName in indicatorNames) { 
  pl <- ggplot(wdiData, aes(x=year, y=wdiData[,indicatorName], group=country, color=country))+
    geom_line(size=1)+
    scale_x_continuous(name="Year", breaks=c(unique(wdiData[,"year"])))+
    scale_y_continuous(name=indicatorName)+
    scale_linetype_discrete(name="Country")+
    theme(legend.title=element_blank())+
    ggtitle(paste(indicatorMetaData[indicatorMetaData[,1]==indicatorName, "name"], "\n"))
  ggsave(paste(indicatorName, ".jpg", sep=""), pl)
}



