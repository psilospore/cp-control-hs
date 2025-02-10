
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-02-03 16:26:20.813148
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
  [] cte=-2  & pc=0 -> 0.20105820105820105 : (cte_est'=-2) & (pc'=1) + 0.23809523809523808 : (cte_est'=-1) & (pc'=1) + 0.18518518518518517 : (cte_est'=0) & (pc'=1) + 0.19576719576719576 : (cte_est'=1) & (pc'=1) + 0.17989417989417988 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.22797927461139897 : (cte_est'=-2) & (pc'=1) + 0.18652849740932642 : (cte_est'=-1) & (pc'=1) + 0.21243523316062177 : (cte_est'=0) & (pc'=1) + 0.17616580310880828 : (cte_est'=1) & (pc'=1) + 0.19689119170984457 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.24186046511627907 : (cte_est'=-2) & (pc'=1) + 0.15813953488372093 : (cte_est'=-1) & (pc'=1) + 0.18604651162790697 : (cte_est'=0) & (pc'=1) + 0.19069767441860466 : (cte_est'=1) & (pc'=1) + 0.22325581395348837 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.20100502512562815 : (cte_est'=-2) & (pc'=1) + 0.11557788944723618 : (cte_est'=-1) & (pc'=1) + 0.22613065326633167 : (cte_est'=0) & (pc'=1) + 0.22110552763819097 : (cte_est'=1) & (pc'=1) + 0.23618090452261306 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.22058823529411764 : (cte_est'=-2) & (pc'=1) + 0.2107843137254902 : (cte_est'=-1) & (pc'=1) + 0.17647058823529413 : (cte_est'=0) & (pc'=1) + 0.22058823529411764 : (cte_est'=1) & (pc'=1) + 0.1715686274509804 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3473053892215569 : (he_est'=-1) & (pc'=2) + 0.31137724550898205 : (he_est'=0) & (pc'=2) + 0.3413173652694611 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.31875 : (he_est'=-1) & (pc'=2) + 0.353125 : (he_est'=0) & (pc'=2) + 0.328125 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.315028901734104 : (he_est'=-1) & (pc'=2) + 0.3554913294797688 : (he_est'=0) & (pc'=2) + 0.32947976878612717 : (he_est'=1) & (pc'=2) ;

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
