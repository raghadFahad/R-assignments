#suffel cards
shuffle <- function(deck) { 
  random <- sample(1:52, size = 52)
  deck[random, ]
}
#deal cards in 2 player
deal <- function(deck) {
  deck[1, ]
}

#Deal two players from hearts deck.
deal_hearts<- function() {
  playhearts<- shuffle4(Hearts)
  h_player1<- head(playhearts, 13)
  h_player2<- tail(playhearts, 13)
}

#Deal two players & dealer from blackjack deck.
deal_jacks<- function() {
  playjacks<- shuffle4(Blackjack)
  j_player1<- head(playjacks, 2)
  j_player2<- tail(playjacks, 2)
  dealer<- playjacks[c(10:11),1:3]
}
#start with suffle the cards
deck2<- suffle(deck)
#dealing first player
player1<-deal(deck2)
#suffling cards agin
deck2<- suffle(deck)
#dealing scound player
player2<-deal(deck2)


