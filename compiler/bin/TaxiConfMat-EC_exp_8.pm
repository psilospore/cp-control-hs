
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:21:27.386103
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
  [] cte=-2  & pc=0 -> 0.17180616740088106 : (cte_est'=-2) & (pc'=1) + 0.18502202643171806 : (cte_est'=-1) & (pc'=1) + 0.22466960352422907 : (cte_est'=0) & (pc'=1) + 0.17180616740088106 : (cte_est'=1) & (pc'=1) + 0.24669603524229075 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.26540284360189575 : (cte_est'=-2) & (pc'=1) + 0.17535545023696683 : (cte_est'=-1) & (pc'=1) + 0.16113744075829384 : (cte_est'=0) & (pc'=1) + 0.1943127962085308 : (cte_est'=1) & (pc'=1) + 0.2037914691943128 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.2578616352201258 : (cte_est'=-2) & (pc'=1) + 0.15723270440251572 : (cte_est'=-1) & (pc'=1) + 0.18238993710691823 : (cte_est'=0) & (pc'=1) + 0.2641509433962264 : (cte_est'=1) & (pc'=1) + 0.13836477987421383 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.2186046511627907 : (cte_est'=-2) & (pc'=1) + 0.24651162790697675 : (cte_est'=-1) & (pc'=1) + 0.12558139534883722 : (cte_est'=0) & (pc'=1) + 0.2 : (cte_est'=1) & (pc'=1) + 0.20930232558139536 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.2127659574468085 : (cte_est'=-2) & (pc'=1) + 0.22872340425531915 : (cte_est'=-1) & (pc'=1) + 0.20212765957446807 : (cte_est'=0) & (pc'=1) + 0.1595744680851064 : (cte_est'=1) & (pc'=1) + 0.19680851063829788 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.3896457765667575 : (he_est'=-1) & (pc'=2) + 0.3188010899182561 : (he_est'=0) & (pc'=2) + 0.29155313351498635 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.30625 : (he_est'=-1) & (pc'=2) + 0.3125 : (he_est'=0) & (pc'=2) + 0.38125 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.2715654952076677 : (he_est'=-1) & (pc'=2) + 0.36421725239616615 : (he_est'=0) & (pc'=2) + 0.36421725239616615 : (he_est'=1) & (pc'=2) ;

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
