#simulate 10,000 blackjack on hands 
simulation_blackjack <- function(blackjack){
  
winnings<- vector("integer",10000)
Acc_winnings<- vector("integer",10000)

num_players<- 3 #Dealer, player1,player2

#score for each player
dealer_wins <- 0
player1_wins <- 0
player2_wins <- 0

#score of tie
tie <- 0

#rates 
player_win_rate <- 0
tie_rate <- 0

#matrixes
player_win_matrix <- matrix(0,10,13)
tie_matrix <- matrix(0,10,13)


for(x in 1:13){
  for(y in 1:10 ){
    local_hands= deal_blackjack
    #Dealer
    total_dealer_card <- sum(hands$value[hands$player=="dealer"]) # sum of cared's value
    dealer_card_num = length(hands$value[hands$player=="dealer"]) #num of dealer's cared
    
    #Player1
    total_player1_card <- sum(hands$value[hands$player=="p1"])# sum of cared's value
    player1_card_num = length(hands$value[hands$player=="p1"]) #num of player1's cared
    
    #Player2
    total_player2_card <- sum(hands$value[hands$player=="p2"])# sum of cared's value
    player2_card_num = length(hands$value[hands$player=="p2"]) #num of player2's cared
    
    for(i in 1:length(winnings)){
      if(total_dealer_card > 21){
        total_dealer_card <- 0
      }else if( total_dealer_card == 21 & dealer_card_num == 2 ){
        total_dealer_card <- 22
      }
      if( total_player1_card == 21 & player1_card_num == 2){
        total_player1_card <- 22
      }
      if( total_player2_card == 21 & player2_card_num == 2){
        total_player2_card <- 22
      }
      
      #update wins score
      if(total_dealer_card > total_player1_card & total_dealer_card > total_player2_card){ #dealer wins
        dealer_wins <- dealer_wins + 1 
      }
      else if(total_player1_card > total_dealer_card & total_player1_card > total_player2_card){ #palyer1 wins
        player1_wins <- player1_wins + 1
      }
      else{#player2 wins
        player2_wins <- player2_wins + 1
        
      }
      
      # if players tie 
      if(total_dealer_card == total_player1_card & total_dealer_card == total_player2_card){
        tie <- tie +1
      }
      
    }
    #rates
    player_win_rate <- player1_wins+player2_wins / length(winnings)
    tie_rate <- tie / length(winnings)
    
    #vectors
    player_win_matrix[y,x] <- player_win_rate
    tie_matrix[y,x] <- tie_rate
    
  }
}

return(player_win_matrix)
}

#for test
simulate_test<-simulation_blackjack(blackjack)
View(simulate_test)