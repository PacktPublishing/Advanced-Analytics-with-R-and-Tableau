install.packages("WDI")
install.packages("wbstats")
library(WDI)
library(wbstats)


df = data.frame(
  Year=c(2013, 2013, 2013), 
  Country=c("Arab World","Caribbean States", "Central Europe"),
  LifeExpectancy=c(71, 72, 76))

df
head(df)
df[2, "Country"]
summary(df)

df$Year <- as.factor(df$Year)


df <- data.frame(
  
#  data.table(
  wb(indicator = c("SP.POP.TOTL",
                   "SP.DYN.LE00.IN",
                   "SP.DYN.TFRT.IN"), mrv = 60)
) 

df$date <- as.factor(df$date)


summary(df)

# Installation of Rserve
install.packages("Rserve")
library(Rserve)
Rserve()

# Iris
head(iris)
IrisBySpecies <- split(iris,iris$Species)


output <- list()

for(n in names(IrisBySpecies)){
  
  ListData <- IrisBySpecies[[n]]
  
  output[[n]] <- data.frame(species=n,
                            
                            MinPetalLength=min(ListData$Petal.Length),
                            
                            MaxPetalLength=max(ListData$Petal.Length),
                            
                            MeanPetalLength=mean(ListData$Petal.Length),
                            
                            NumberofSamples=nrow(ListData))
  
  output.df <- do.call(rbind,output)
  
}

print(output.df)

