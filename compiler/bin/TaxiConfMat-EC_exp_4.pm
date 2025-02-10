
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:20:26.676055
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
  [] cte=-2  & pc=0 -> 0.14507772020725387 : (cte_est'=-2) & (pc'=1) + 0.21243523316062177 : (cte_est'=-1) & (pc'=1) + 0.21243523316062177 : (cte_est'=0) & (pc'=1) + 0.22797927461139897 : (cte_est'=1) & (pc'=1) + 0.20207253886010362 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.1878453038674033 : (cte_est'=-2) & (pc'=1) + 0.2154696132596685 : (cte_est'=-1) & (pc'=1) + 0.20441988950276244 : (cte_est'=0) & (pc'=1) + 0.1712707182320442 : (cte_est'=1) & (pc'=1) + 0.22099447513812154 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.18981481481481483 : (cte_est'=-2) & (pc'=1) + 0.19907407407407407 : (cte_est'=-1) & (pc'=1) + 0.20833333333333334 : (cte_est'=0) & (pc'=1) + 0.20833333333333334 : (cte_est'=1) & (pc'=1) + 0.19444444444444445 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.23529411764705882 : (cte_est'=-2) & (pc'=1) + 0.20098039215686275 : (cte_est'=-1) & (pc'=1) + 0.21568627450980393 : (cte_est'=0) & (pc'=1) + 0.18137254901960784 : (cte_est'=1) & (pc'=1) + 0.16666666666666666 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.20388349514563106 : (cte_est'=-2) & (pc'=1) + 0.1796116504854369 : (cte_est'=-1) & (pc'=1) + 0.23300970873786409 : (cte_est'=0) & (pc'=1) + 0.1941747572815534 : (cte_est'=1) & (pc'=1) + 0.18932038834951456 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.2964071856287425 : (he_est'=-1) & (pc'=2) + 0.3652694610778443 : (he_est'=0) & (pc'=2) + 0.3383233532934132 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.34626865671641793 : (he_est'=-1) & (pc'=2) + 0.33432835820895523 : (he_est'=0) & (pc'=2) + 0.3194029850746269 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.37462235649546827 : (he_est'=-1) & (pc'=2) + 0.32628398791540786 : (he_est'=0) & (pc'=2) + 0.2990936555891239 : (he_est'=1) & (pc'=2) ;

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
