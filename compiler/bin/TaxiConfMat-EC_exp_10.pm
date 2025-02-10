
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:21:57.743659
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
  [] cte=-2  & pc=0 -> 0.21171171171171171 : (cte_est'=-2) & (pc'=1) + 0.20270270270270271 : (cte_est'=-1) & (pc'=1) + 0.17567567567567569 : (cte_est'=0) & (pc'=1) + 0.1981981981981982 : (cte_est'=1) & (pc'=1) + 0.21171171171171171 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.15306122448979592 : (cte_est'=-2) & (pc'=1) + 0.23469387755102042 : (cte_est'=-1) & (pc'=1) + 0.21428571428571427 : (cte_est'=0) & (pc'=1) + 0.1836734693877551 : (cte_est'=1) & (pc'=1) + 0.21428571428571427 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.22959183673469388 : (cte_est'=-2) & (pc'=1) + 0.18877551020408162 : (cte_est'=-1) & (pc'=1) + 0.19387755102040816 : (cte_est'=0) & (pc'=1) + 0.19387755102040816 : (cte_est'=1) & (pc'=1) + 0.19387755102040816 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.20224719101123595 : (cte_est'=-2) & (pc'=1) + 0.17415730337078653 : (cte_est'=-1) & (pc'=1) + 0.19101123595505617 : (cte_est'=0) & (pc'=1) + 0.19662921348314608 : (cte_est'=1) & (pc'=1) + 0.23595505617977527 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.16826923076923078 : (cte_est'=-2) & (pc'=1) + 0.19230769230769232 : (cte_est'=-1) & (pc'=1) + 0.21153846153846154 : (cte_est'=0) & (pc'=1) + 0.25 : (cte_est'=1) & (pc'=1) + 0.1778846153846154 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3081395348837209 : (he_est'=-1) & (pc'=2) + 0.3372093023255814 : (he_est'=0) & (pc'=2) + 0.3546511627906977 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.32507739938080493 : (he_est'=-1) & (pc'=2) + 0.34055727554179566 : (he_est'=0) & (pc'=2) + 0.33436532507739936 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.35435435435435436 : (he_est'=-1) & (pc'=2) + 0.33633633633633636 : (he_est'=0) & (pc'=2) + 0.30930930930930933 : (he_est'=1) & (pc'=2) ;

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
