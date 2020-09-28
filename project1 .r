#Casino Game: Craps (Pass Line Bet)

#the rules of the game:
#1-first the player rolling two 6-sided dice 
#2-If the player roll a 7 or 11, he win and the round is over before it started
#3-If he roll a 2, 3, or 12 that's a Craps and he lose: again, it's over before it started
#4-Any other number (4, 5, 6, 8, 9, 10) becomes the Point
#5-the player re-rolls until either the Point is rolled again, or a 7 is rolled
#6-If the Point is tossed the player wins and the round is over
#7-If the player tosses a 7, he lose and the round is over

craps<-function(){

  num_simulation <- 1000 

  craps_data<-data.frame() # build data frame for simulations 
  
  for (i in 1:num_simulation) { 

    player_lose <- 0    # lose scores
    player_win <- 0     # win scores
    stop = 0            # to check if player win or lose or has to roll dice agin

    current_len <- 1    # to count current game length 

   sum_dice = 2:12      # sum of 2 dices 
   roll = sample(sum_dice,size = 1,replace= TRUE) #rolling dices
  
   if (roll == 7 | roll == 11){ # player win
     player_win <- player_win + 1 #increase player score's
    
   }
  
   else if  (roll == 2 | roll == 3 | roll == 12){ # player lose
     player_lose <- player_lose +1 #decrease player score's
   }
  
   else {# if player nither win or lose
    point = roll # save the current player's dices
    while(stop == 0){ 
      current_len = current_len +1 # increase game length
      roll = sample(sum_dice,size = 1,replace= TRUE) # roll agin
      if (roll == 7 ){ #player lose
        player_lose <- player_lose +1 
        stop = stop + 1
      }else if (roll == point){ #player win
        player_win <- player_win + 1
        stop = stop + 1
      }
      
    }
  }

  temp_craps_data<-data.frame(win=c(player_win), lose= c(player_lose), game_lenght= c(current_len)) #temporary data frame for current simulation
  craps_data<-rbind(craps_data,temp_craps_data) # merge data frams 
  }

  # Calculate probabilities 

  p_win = sum(prof$win)/num_simulation # win probabilitie of player
  print("probabilitie of the player win" )
  print(p_win)
  p_lose = sum(prof$lose)/num_simulation #lose probabilitie of player
  print("probabilitie of the player lose" )
  print(p_lose)
  
}

#As we notice the win probability of player is less than the lose probability of player which benefits the casino profits

