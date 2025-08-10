Notes on Board#immediate_winner_marker and Board#at_risk_square

Because computer must priotize offense over defense, I discovered that with the previous implementation of immediate_winner_marker, there would still be situations where defense is still prioritized over offense even when a winning move is available to the computer.

For example, let's say it's the human player's turn and the board state is:
X _ _
O X X
O O _

If the human player chooses square 2, the computer will then choose square 3 over 9, even though 9 is the winning move.

This is because the old immediate_winner_marker first finds [1, 2, 3] to be the set of square numbers that contains an immediate potential winner and returns it before the set [7, 8, 9] gets to be checked.

Therefore, I decided to modify immediate_winner_marker so that: When multiple sets of square locations contain an immediate potential winner marker, and if these different sets point to different markers, immediate_winner_marker will return the computer marker over the human marker.

I implemeted the change to immediate_winner_marker, but then I realized it was not enough to only change immediate_winner_marker. at_risk_square must also return the correct square location that is the location of the unmarked square within the set of squares that contains an immediate potential winner marker.

This is why I got rid of immediate_winner_marker and implemented the set selection mechanism in at_risk_square. Now, so long as the board state has a set of squares that contains an immediate potential winner, at_risk_square makes sure that the location of the correct unmarked square is returned.