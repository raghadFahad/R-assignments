die1<- 1:10
die2<- 1:20

roll<-function(die){
  t<- 0
  for(x in 1:6){
    dice<-sample(die,1,replace=TRUE)
    t = t+sum(dice)
  }
  print(t)
}
roll_count<-function(die,six){
  t<-0
  c<- 0
  for(x in 1:6){
    dice<-sample(die,1,replace=TRUE)
    t = t + sum(dice)
    
    if(dice > six){
      c = c+1
    }
  }
  print(t)
  print(c)
}

roll_count(die1,6)
roll_count(die2,16)