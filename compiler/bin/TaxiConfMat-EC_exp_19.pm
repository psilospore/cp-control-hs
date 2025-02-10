
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:24:17.975039
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
  [] cte=-2  & pc=0 -> 0.14356435643564355 : (cte_est'=-2) & (pc'=1) + 0.21782178217821782 : (cte_est'=-1) & (pc'=1) + 0.24257425742574257 : (cte_est'=0) & (pc'=1) + 0.1485148514851485 : (cte_est'=1) & (pc'=1) + 0.24752475247524752 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.22169811320754718 : (cte_est'=-2) & (pc'=1) + 0.22641509433962265 : (cte_est'=-1) & (pc'=1) + 0.18867924528301888 : (cte_est'=0) & (pc'=1) + 0.18867924528301888 : (cte_est'=1) & (pc'=1) + 0.17452830188679244 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.19095477386934673 : (cte_est'=-2) & (pc'=1) + 0.19597989949748743 : (cte_est'=-1) & (pc'=1) + 0.21608040201005024 : (cte_est'=0) & (pc'=1) + 0.20100502512562815 : (cte_est'=1) & (pc'=1) + 0.19597989949748743 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.14814814814814814 : (cte_est'=-2) & (pc'=1) + 0.2222222222222222 : (cte_est'=-1) & (pc'=1) + 0.17989417989417988 : (cte_est'=0) & (pc'=1) + 0.18518518518518517 : (cte_est'=1) & (pc'=1) + 0.26455026455026454 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.18686868686868688 : (cte_est'=-2) & (pc'=1) + 0.1919191919191919 : (cte_est'=-1) & (pc'=1) + 0.18181818181818182 : (cte_est'=0) & (pc'=1) + 0.23232323232323232 : (cte_est'=1) & (pc'=1) + 0.20707070707070707 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.32753623188405795 : (he_est'=-1) & (pc'=2) + 0.34202898550724636 : (he_est'=0) & (pc'=2) + 0.33043478260869563 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.3639240506329114 : (he_est'=-1) & (pc'=2) + 0.37341772151898733 : (he_est'=0) & (pc'=2) + 0.2626582278481013 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.3893805309734513 : (he_est'=-1) & (pc'=2) + 0.2831858407079646 : (he_est'=0) & (pc'=2) + 0.3274336283185841 : (he_est'=1) & (pc'=2) ;

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
