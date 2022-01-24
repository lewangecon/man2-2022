```{r}
cnames<-read.csv("data/cnames.csv")
FLvoters<-read.csv("data/FLvoters.csv")
FLcensus<-read.csv("data/FLCensusVTD.csv")
FLvoters <- FLvoters[!is.na(match(FLvoters$surname,cnames$surname)),]
FLvoters<-na.omit(FLvoters)
cnames$pctothers<-100-(cnames$pctapi+cnames$pctblack+cnames$pctwhite+cnames$pcthispanic)
dim(FLvoters)

```