
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:22:43.000251
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
  [] cte=-2  & pc=0 -> 0.17045454545454544 : (cte_est'=-2) & (pc'=1) + 0.14204545454545456 : (cte_est'=-1) & (pc'=1) + 0.25 : (cte_est'=0) & (pc'=1) + 0.24431818181818182 : (cte_est'=1) & (pc'=1) + 0.19318181818181818 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.20689655172413793 : (cte_est'=-2) & (pc'=1) + 0.18226600985221675 : (cte_est'=-1) & (pc'=1) + 0.19704433497536947 : (cte_est'=0) & (pc'=1) + 0.19704433497536947 : (cte_est'=1) & (pc'=1) + 0.21674876847290642 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.18579234972677597 : (cte_est'=-2) & (pc'=1) + 0.21311475409836064 : (cte_est'=-1) & (pc'=1) + 0.20218579234972678 : (cte_est'=0) & (pc'=1) + 0.1912568306010929 : (cte_est'=1) & (pc'=1) + 0.20765027322404372 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.22009569377990432 : (cte_est'=-2) & (pc'=1) + 0.20574162679425836 : (cte_est'=-1) & (pc'=1) + 0.22009569377990432 : (cte_est'=0) & (pc'=1) + 0.18181818181818182 : (cte_est'=1) & (pc'=1) + 0.1722488038277512 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.19213973799126638 : (cte_est'=-2) & (pc'=1) + 0.20087336244541484 : (cte_est'=-1) & (pc'=1) + 0.23580786026200873 : (cte_est'=0) & (pc'=1) + 0.16593886462882096 : (cte_est'=1) & (pc'=1) + 0.2052401746724891 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.31097560975609756 : (he_est'=-1) & (pc'=2) + 0.3445121951219512 : (he_est'=0) & (pc'=2) + 0.3445121951219512 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.2991202346041056 : (he_est'=-1) & (pc'=2) + 0.3548387096774194 : (he_est'=0) & (pc'=2) + 0.3460410557184751 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.3081570996978852 : (he_est'=-1) & (pc'=2) + 0.34441087613293053 : (he_est'=0) & (pc'=2) + 0.3474320241691843 : (he_est'=1) & (pc'=2) ;

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
