
// TaxiConfMat
// Prism Looping State Machine
// Generated: 2025-01-10 10:20:41.764964
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
  [] cte=-2  & pc=0 -> 0.1693121693121693 : (cte_est'=-2) & (pc'=1) + 0.19047619047619047 : (cte_est'=-1) & (pc'=1) + 0.21693121693121692 : (cte_est'=0) & (pc'=1) + 0.20105820105820105 : (cte_est'=1) & (pc'=1) + 0.2222222222222222 : (cte_est'=2) & (pc'=1) ;
  [] cte=-1  & pc=0 -> 0.225130890052356 : (cte_est'=-2) & (pc'=1) + 0.17801047120418848 : (cte_est'=-1) & (pc'=1) + 0.193717277486911 : (cte_est'=0) & (pc'=1) + 0.17801047120418848 : (cte_est'=1) & (pc'=1) + 0.225130890052356 : (cte_est'=2) & (pc'=1) ;
  [] cte=0  & pc=0 -> 0.13488372093023257 : (cte_est'=-2) & (pc'=1) + 0.22325581395348837 : (cte_est'=-1) & (pc'=1) + 0.23255813953488372 : (cte_est'=0) & (pc'=1) + 0.23255813953488372 : (cte_est'=1) & (pc'=1) + 0.17674418604651163 : (cte_est'=2) & (pc'=1) ;
  [] cte=1  & pc=0 -> 0.16923076923076924 : (cte_est'=-2) & (pc'=1) + 0.18461538461538463 : (cte_est'=-1) & (pc'=1) + 0.20512820512820512 : (cte_est'=0) & (pc'=1) + 0.2512820512820513 : (cte_est'=1) & (pc'=1) + 0.18974358974358974 : (cte_est'=2) & (pc'=1) ;
  [] cte=2  & pc=0 -> 0.20476190476190476 : (cte_est'=-2) & (pc'=1) + 0.20952380952380953 : (cte_est'=-1) & (pc'=1) + 0.1761904761904762 : (cte_est'=0) & (pc'=1) + 0.22857142857142856 : (cte_est'=1) & (pc'=1) + 0.18095238095238095 : (cte_est'=2) & (pc'=1) ;

  // Perceiver (HE)
  [] he=-1  & pc=1 -> 0.34831460674157305 : (he_est'=-1) & (pc'=2) + 0.32865168539325845 : (he_est'=0) & (pc'=2) + 0.32303370786516855 : (he_est'=1) & (pc'=2) ;
  [] he=0  & pc=1 -> 0.3375 : (he_est'=-1) & (pc'=2) + 0.328125 : (he_est'=0) & (pc'=2) + 0.334375 : (he_est'=1) & (pc'=2) ;
  [] he=1  & pc=1 -> 0.3425925925925926 : (he_est'=-1) & (pc'=2) + 0.32098765432098764 : (he_est'=0) & (pc'=2) + 0.33641975308641975 : (he_est'=1) & (pc'=2) ;

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
