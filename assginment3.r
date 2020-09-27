#sretegy one capmer if one of player had more then 21
strategy_one<-function(hands){

  #Dealer 
  Dealer_card <- sum(hands$value[hands$player=="dealer"]) #sum dealer values

  if(Dealer_card == 21){#check the sum

    print("Dealer card's is 21 and he has win") #if it equal to 21 => win

  }else if(Dealer_card > 21){ #greater then => busted

    print("Dealer card's is greater then 21 and he busted")

  }else{ # less then also busted

    print("player card's is less then 21 and you busted")
  }

  #Player 

  player_card <- sum(hands$value[hands$player=="p1"])   #sum player values

  if(player_card == 21){#if it equal to 21 => win

    print("player card's is 21 and he has win")

  }else if(player_card > 21){#greater then => busted

    print("player card's is greater then 21 and he busted")

  }else{ # less then also busted

    print("Dealer card's is less then 21 and you busted")
  }
  
}
strategy_one(hands)

#-------------------------------------------------

#strategy two will check if player have 11 card and the one have 11 card will decrease his/her score 10 points
strategy_two<-function(hands){
  #Player 1
  dealer_score=0 #Dealer  score

  player1_card <- hands$value[hands$player=="dealer"] #Dealer values

  if(dealer_card[1]==11 | dealer_card[2]==11){ #check for 11 card

    dealer_card[1] <- 1 # make first card = 1
    dealer_score <- dealer_score-10 #decrease score

    print("Dealer score")#print player1 score
    print(dealer_score)
  }

  #player 
  player_score=0 #player score

  player_card <- hands$value[hands$player=="p1"] #player values

  if(player_card[1]==11 | player_card[2]==11){ #check for 11 card

    player_card[1]<-1 # make first card = 1

    player_score <-  player_score-10 #decrease score

    print("Player score")#print player score
    print(player_score)
  }

  #Camper players scores
  if(dealer_score > player_score){

    print("Player 1 WIN")

  }else if(dealer_score < player_score){

    print("Player 2 WIN")

  }else{

    print("No one WIN ")
  }
  
}
