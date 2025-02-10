
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:20:11.403493
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
  [] cte=-2  & pc=0 -> 0.18604651162790697 : (cte_est'=-2) & (pc'=1) + 0.19186046511627908 : (cte_est'=-1) & (pc'=1) + 0.19186046511627908 : (cte_est'=0) & (pc'=1) + 0.19186046511627908 : (cte_est'=1) & (pc'=1) + 0.23837209302325582 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.18932038834951456 : (cte_est'=-2) & (pc'=1) + 0.19902912621359223 : (cte_est'=-1) & (pc'=1) + 0.18932038834951456 : (cte_est'=0) & (pc'=1) + 0.2766990291262136 : (cte_est'=1) & (pc'=1) + 0.14563106796116504 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.2393617021276596 : (cte_est'=-2) & (pc'=1) + 0.18085106382978725 : (cte_est'=-1) & (pc'=1) + 0.13829787234042554 : (cte_est'=0) & (pc'=1) + 0.2553191489361702 : (cte_est'=1) & (pc'=1) + 0.18617021276595744 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.16143497757847533 : (cte_est'=-2) & (pc'=1) + 0.23318385650224216 : (cte_est'=-1) & (pc'=1) + 0.19282511210762332 : (cte_est'=0) & (pc'=1) + 0.19730941704035873 : (cte_est'=1) & (pc'=1) + 0.21524663677130046 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.25118483412322273 : (cte_est'=-2) & (pc'=1) + 0.17535545023696683 : (cte_est'=-1) & (pc'=1) + 0.20853080568720378 : (cte_est'=0) & (pc'=1) + 0.1895734597156398 : (cte_est'=1) & (pc'=1) + 0.17535545023696683 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3333333333333333 : (he_est'=-1) & (pc'=2) + 0.3302752293577982 : (he_est'=0) & (pc'=2) + 0.3363914373088685 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.3165680473372781 : (he_est'=-1) & (pc'=2) + 0.35798816568047337 : (he_est'=0) & (pc'=2) + 0.3254437869822485 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.3641791044776119 : (he_est'=-1) & (pc'=2) + 0.2656716417910448 : (he_est'=0) & (pc'=2) + 0.3701492537313433 : (he_est'=1) & (pc'=2) ;

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
