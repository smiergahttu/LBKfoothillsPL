#Preparation

install.packages("Bchron")
library(Bchron)
#LBK_Fthlls is the list of radiocarbon determination. It needs columns named "BP" - radiocarbon years, and "Std" - standart deviation (radiocarbon years). Calibration use Intacl2 calibration curve. See LBK_Fthlls.csv and LBK_Fthlls_ref.txt in this repo.
data <- read.csv("LBK_fthlls.csv")

#calculate and format data frame (for plots etc.).
dens <- BchronDensity(data$BP, data$Std, rep("intcal20", length(data$BP)))
year_den <- data.frame("year"=1950-dens$ageGrid, "dens"=dens$densities)
plot(year_den, type="l")

#Define time span of analysis (5400-4800 BC, by 100 years).
centuries <- seq(-5400,-4900, 100)

#bin probability distribution into grid.
cdens_LBK = 1
for (i in 1:length(centuries)){
  cdens_LBK[i] <- sum(year_den$dens[which(year_den$year >= centuries[i] & year_den$year < centuries[i]+100)])
}

#normalisation
Ndens_LBK <- cdens_LBK/sum(cdens_LBK)

#graphical comparison. Red line: normalised distribution, blue line - not normalised.
plot(Ndens_LBK, type="l", col="red")
lines(cdens_LBK, col="blue")

#formulate data frame (output rounded to 2 decimal places) and write as csv.
df_Ndens_LBK <- data.frame("Year"=centuries, "dens"=round(Ndens_LBK, 2))
write.csv(df_Ndens_LBK, "LBKfoothils_Ndens_LBK.csv")
