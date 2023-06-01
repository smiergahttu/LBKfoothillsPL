library(Bchron)
#dd1 is the list of radiocarbon determination. It needs columns named "BP" - radiocarbon years, and "Std" - standart deviation (radiocarbon years). See dd.csv in this repo.

#calculate and format data.frame (for plots etc.)
ddens <- BchronDensity(dd$BP, dd$Std, rep("intcal20", length(dd$BP)))
yden <- data.frame("year"=1950-ddens$ageGrid, "dens"=ddens$densities)
#Define time span of analysis (if wider/narrower periods are needed, change "100")
centuries <- seq(-5400,-4800, 100)
#bin probability distribution into grid
cdens_LBK = 1
for (i in 1:length(centuries)){
  cdens_LBK[i] <- sum(yden_LBK$dens[which(yden_LBK$year >= centuries[i] & yden_LBK$year < centuries[i]+100)])
}
#normalise
Ndens_LBK <- cdens_LBK/sum(cdens_LBK)

#formulate dataframe and write csv
df_Ndens_LBK <- data.frame("Year"=centuries, "dens"=round(N_dens_LBK, 2))
write.csv(df_Ndens_LBK, "LBKfoothils_Ndens_LBK.csv")