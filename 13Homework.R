install.packages("lpSolve")
library(lpSolve)

#profit for 2 bears
f.obj<-c(13,23,30)

#constrant 
f.con <- matrix(c(5,15,10,
                4,4,4,
                35,20,15), nrow = 4, byrow = TRUE)
#diraction
f.dir <- c("<=",
           "<=",
           "<=",
           "<=")
#right hand sid
f.rhs <- c(480,
           160,
           1190,
           650)

sol <- lp("max", f.obj, f.con, f.dir, f.rhs, compute.sens = TRUE)

sol$objval #1200
sol$solution # 0 0 40
#shadow prices
sol$duals # 0.0   7.5   0.0   0.0 -17.0  -7.0   0.0


#Markov Chains
install.packages("Matrix")

install.packages("expm")
library(expm)
T <- matrix(c(0.95,0.05,0,0,0.75,0.2,0.05,0,0.2,0.55,0.2,0.05,0.2, 0.55,0.2,0.05), nrow = 4, byrow = TRUE)
colnames(T) = c(0,1,2,3)
rownames(T) = c(0,1,2,3)

T

T%^%2

T%^%5

T%^%20