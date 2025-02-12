
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:20:57.029193
// PC values:
//   0 : Perceiver (CTE)
//   1 : Perceiver (HE)
//   2 : Controller
//   3 : Dynamics
//   4 : Aborter
//   5 : Loop Logic
//   6 : cte_fail
//   7 : he_fail
//   8 : dyn_fail


dtmc

const N;

module TaxiConfMat

  cte : [-4..4] init 0;
  he : [-2..2] init 0;
  cte_est : [-2..2] init 0;
  he_est : [-1..1] init 0;
  a : [-1..1] init 0;
  pc : [0..8] init 0; // program counter
  k : [0..N] init 1; // loop counter


  // Perceiver (CTE)
  [] cte=-2  & pc=0 -> 0.17142857142857143 : (cte_est'=-2) & (pc'=1) + 0.19523809523809524 : (cte_est'=-1) & (pc'=1) + 0.21428571428571427 : (cte_est'=0) & (pc'=1) + 0.22380952380952382 : (cte_est'=1) & (pc'=1) + 0.19523809523809524 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.26519337016574585 : (cte_est'=-2) & (pc'=1) + 0.19337016574585636 : (cte_est'=-1) & (pc'=1) + 0.17679558011049723 : (cte_est'=0) & (pc'=1) + 0.18232044198895028 : (cte_est'=1) & (pc'=1) + 0.18232044198895028 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.20657276995305165 : (cte_est'=-2) & (pc'=1) + 0.18779342723004694 : (cte_est'=-1) & (pc'=1) + 0.19718309859154928 : (cte_est'=0) & (pc'=1) + 0.1784037558685446 : (cte_est'=1) & (pc'=1) + 0.2300469483568075 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.19101123595505617 : (cte_est'=-2) & (pc'=1) + 0.2303370786516854 : (cte_est'=-1) & (pc'=1) + 0.15730337078651685 : (cte_est'=0) & (pc'=1) + 0.1853932584269663 : (cte_est'=1) & (pc'=1) + 0.23595505617977527 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.22477064220183487 : (cte_est'=-2) & (pc'=1) + 0.20642201834862386 : (cte_est'=-1) & (pc'=1) + 0.17889908256880735 : (cte_est'=0) & (pc'=1) + 0.2018348623853211 : (cte_est'=1) & (pc'=1) + 0.18807339449541285 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3045977011494253 : (he_est'=-1) & (pc'=2) + 0.3620689655172414 : (he_est'=0) & (pc'=2) + 0.3333333333333333 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.32450331125827814 : (he_est'=-1) & (pc'=2) + 0.33112582781456956 : (he_est'=0) & (pc'=2) + 0.3443708609271523 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.29428571428571426 : (he_est'=-1) & (pc'=2) + 0.38285714285714284 : (he_est'=0) & (pc'=2) + 0.32285714285714284 : (he_est'=1) & (pc'=2) ;

  // Controller
  [] cte_est=-2 & he_est=-1  & pc=2 -> 1 : (a'=1) & (pc'=3) ;
  [] cte_est=-2 & he_est=0  & pc=2 -> 1 : (a'=1) & (pc'=3) ;
  [] cte_est=-2 & he_est=1  & pc=2 -> 1 : (a'=0) & (pc'=3) ;
  [] cte_est=-1 & he_est=-1  & pc=2 -> 1 : (a'=1) & (pc'=3) ;
  [] cte_est=-1 & he_est=0  & pc=2 -> 1 : (a'=1) & (pc'=3) ;
  [] cte_est=-1 & he_est=1  & pc=2 -> 1 : (a'=0) & (pc'=3) ;
  [] cte_est=0 & he_est=-1  & pc=2 -> 1 : (a'=1) & (pc'=3) ;
  [] cte_est=0 & he_est=0  & pc=2 -> 1 : (a'=0) & (pc'=3) ;
  [] cte_est=0 & he_est=1  & pc=2 -> 1 : (a'=-1) & (pc'=3) ;
  [] cte_est=1 & he_est=-1  & pc=2 -> 1 : (a'=0) & (pc'=3) ;
  [] cte_est=1 & he_est=0  & pc=2 -> 1 : (a'=-1) & (pc'=3) ;
  [] cte_est=1 & he_est=1  & pc=2 -> 1 : (a'=-1) & (pc'=3) ;
  [] cte_est=2 & he_est=-1  & pc=2 -> 1 : (a'=0) & (pc'=3) ;
  [] cte_est=2 & he_est=0  & pc=2 -> 1 : (a'=-1) & (pc'=3) ;
  [] cte_est=2 & he_est=1  & pc=2 -> 1 : (a'=-1) & (pc'=3) ;

  // Dynamics
  [] cte>=-2 & cte<=2 & he>=-1 & he<=1 & pc=3 -> 1 : (he'=he+a) & (cte'=cte+he+a) & (pc'=4) ;
  [] (cte< -2 | cte>2 | he< -1 | he>1) & pc=3 -> 1 : (pc'=8) ;

  // Aborter
  [] (cte< -2 | cte>2) & pc=4 -> 1 : (pc'=6) ;
  [] (he< -1 | he>1) & pc=4 -> 1 : (pc'=7) ;
  [] cte>=-2 & cte<=2 & he>=-1 & he<=1 & pc=4 -> 1 : (pc'=5) ;



  // Loop Logic
  [] pc=5 & k < N -> 1 : (pc'=0) & (k'=k+1) ;


endmodule
