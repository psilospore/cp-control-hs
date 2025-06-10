
// Prism Looping State Machine

// ShieldedConfPred StochDyn_DefAct_acc90_conf99_af7
// --conf_pred_cte lib/acc90/real_cte_pred_acc90_conf99.csv
// --conf_pred_he lib/acc90/real_he_pred_acc90_conf99.csv
// --tempest_pred lib/temp_extr_dir_3.csv
// --action_filter 0.7

// PC values:
//   0 : Perceiver (CTE)
//   1 : Perceiver (HE)
//   2 : Controller
//   3 : Default Controller
//   4 : Stochastic Dynamics
//   5 : Dynamics
//   6 : Loop Logic
//   -1 : dyn_fail
//   -2 : ctrl_fail

// Generated: 2025-05-23 10:49:34.306487

mdp

const N;

module ShieldedConfPred

  cte : [-1..4] init 0;
  he : [-1..2] init 0;
  a : [0..2] init 0;
  default : [0..2] init 0; // Enum to trigger default control
  beta : [0..N] init 0; // Counts number of times controller found no safe actions
  cte_est0 : [0..1] init 0;
  cte_est1 : [0..1] init 0;
  cte_est2 : [0..1] init 0;
  cte_est3 : [0..1] init 0;
  cte_est4 : [0..1] init 0;
  he_est0 : [0..1] init 0;
  he_est1 : [0..1] init 0;
  he_est2 : [0..1] init 0;
  pc : [-2..6] init 0; // program counter
  k : [0..N] init 1; // loop counter


  // Perceiver (CTE)
  [] cte=0 & pc=0 -> 0.6493506493506493 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.006493506493506494 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.01948051948051948 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.032467532467532464 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03896103896103896 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.032467532467532464 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.012987012987012988 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.006493506493506494 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.006493506493506494 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03896103896103896 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.15584415584415584 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) ;
  [] cte=1 & pc=0 -> 0.05228758169934641 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.16339869281045752 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.11764705882352941 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.09803921568627451 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.013071895424836602 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0392156862745098 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.006535947712418301 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.08496732026143791 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.06535947712418301 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.08496732026143791 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.27450980392156865 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) ;
  [] cte=2 & pc=0 -> 0.7513812154696132 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.22099447513812154 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.027624309392265192 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) ;
  [] cte=3 & pc=0 -> 0.41818181818181815 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.06666666666666667 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.4303030303030303 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.07878787878787878 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.006060606060606061 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) ;
  [] cte=4 & pc=0 -> 0.38953488372093026 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.005813953488372093 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.29069767441860467 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.06976744186046512 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.011627906976744186 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.01744186046511628 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.029069767441860465 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.011627906976744186 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.005813953488372093 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.1686046511627907 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) ;

  // Perceiver (HE)
  [] he=0 & pc=1 -> 0.99079754601227 : (he_est0'=1) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.009202453987730062 : (he_est0'=1) & (he_est1'=1) & (he_est2'=0) & (pc'=2) ;
  [] he=1 & pc=1 -> 0.0064516129032258064 : (he_est0'=0) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.14838709677419354 : (he_est0'=0) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.0967741935483871 : (he_est0'=0) & (he_est1'=1) & (he_est2'=1) & (pc'=2) + 0.07096774193548387 : (he_est0'=1) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.0064516129032258064 : (he_est0'=1) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.13548387096774195 : (he_est0'=1) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.535483870967742 : (he_est0'=1) & (he_est1'=1) & (he_est2'=1) & (pc'=2) ;
  [] he=2 & pc=1 -> 0.8924418604651163 : (he_est0'=0) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.06686046511627906 : (he_est0'=0) & (he_est1'=1) & (he_est2'=1) & (pc'=2) + 0.040697674418604654 : (he_est0'=1) & (he_est1'=1) & (he_est2'=1) & (pc'=2) ;

  // Controller
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=2) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
 [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
[] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  // Default Controller
  
  [] (default=1 | default=2) & pc=3 -> (default'=0) & (pc'=-2);
  [dc_used] pc=-2 -> 1: (pc'=4);
  [] default=0 & pc=3 -> (pc'=4);
  

  // Stochastic Dynamics
  
  [] a=0 & pc=4 -> 0.9 : (a'=0) & (pc'=5) + 0.04999999999999999 : (a'=1) & (pc'=5) + 0.04999999999999999 : (a'=2) & (pc'=5);
  [] a=1 & pc=4 -> 0.9 : (a'=1) & (pc'=5) + 0.04999999999999999 : (a'=0) & (pc'=5) + 0.04999999999999999 : (a'=2) & (pc'=5);
  [] a=2 & pc=4 -> 0.9 : (a'=2) & (pc'=5) + 0.04999999999999999 : (a'=1) & (pc'=5) + 0.04999999999999999 : (a'=0) & (pc'=5);
  
  
  // Dynamics
  
  [] he=1 & a=1 & pc=5 -> 1 : (he'=-1) & (pc'=-1); // error
  [] he=2 & a=2 & pc=5 -> 1 : (he'=-1) & (pc'=-1); // error
  [] cte=0 & he=0 & a=0 & pc=5 -> 1 : (pc'=6);
  [] cte=0 & he=0 & a=1 & pc=5 -> 1 : (cte'=1) & (he'=1) & (pc'=6);
  [] cte=0 & he=0 & a=2 & pc=5 -> 1 : (cte'=2) & (he'=2) & (pc'=6);
  [] cte=0 & he=1 & a=0 & pc=5 -> 1 : (cte'=1) & (pc'=6);
  [] cte=0 & he=1 & a=2 & pc=5 -> 1 : (he'=0) & (pc'=6);
  [] cte=0 & he=2 & a=0 & pc=5 -> 1 : (cte'=2) & (pc'=6);
  [] cte=0 & he=2 & a=1 & pc=5 -> 1 : (he'=0) & (pc'=6);
  // left -side dynamics:
  [] cte=1 & he=0 & a=0 & pc=5 -> 1 : (pc'=6);
  [] cte=1 & he=0 & a=1 & pc=5 -> 1 : (cte'=3) & (he'=1) & (pc'=6);
  [] cte=1 & he=0 & a=2 & pc=5 -> 1 : (cte'=0) & (he'=2) & (pc'=6);
  [] cte=1 & he=1 & a=0 & pc=5 -> 1 : (cte'=3) & (pc'=6);
  [] cte=1 & he=1 & a=2 & pc=5 -> 1 : (he'=0) & (pc'=6);
  [] cte=1 & he=2 & a=0 & pc=5 -> 1 : (cte'=0) & (pc'=6);
  [] cte=1 & he=2 & a=1 & pc=5 -> 1 : (he'=0) & (pc'=6);
  [] cte=3 & he=0 & a=0 & pc=5 -> 1 : (pc'=6);
  [] cte=3 & he=0 & a=1 & pc=5 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=3 & he=0 & a=2 & pc=5 -> 1 : (cte'=1) & (he'=2) & (pc'=6);
  [] cte=3 & he=1 & a=0 & pc=5 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=3 & he=1 & a=2 & pc=5 -> 1 : (he'=0) & (pc'=6);
  [] cte=3 & he=2 & a=0 & pc=5 -> 1 : (cte'=1) & (pc'=6);
  [] cte=3 & he=2 & a=1 & pc=5 -> 1 : (he'=0) & (pc'=6);
  // right -side dynamics:
  [] cte=2 & he=0 & a=0 & pc=5 -> 1 : (pc'=6);
  [] cte=2 & he=0 & a=1 & pc=5 -> 1 : (cte'=0) & (he'=1) & (pc'=6);
  [] cte=2 & he=0 & a=2 & pc=5 -> 1 : (cte'=4) & (he'=2) & (pc'=6);
  [] cte=2 & he=1 & a=0 & pc=5 -> 1 : (cte'=0) & (pc'=6);
  [] cte=2 & he=1 & a=2 & pc=5 -> 1 : (he'=0) & (pc'=6);
  [] cte=2 & he=2 & a=0 & pc=5 -> 1 : (cte'=4) & (pc'=6);
  [] cte=2 & he=2 & a=1 & pc=5 -> 1 : (he'=0) & (pc'=6);
  [] cte=4 & he=0 & a=0 & pc=5 -> 1 : (pc'=6);
  [] cte=4 & he=0 & a=1 & pc=5 -> 1 : (cte'=2) & (he'=1) & (pc'=6);
  [] cte=4 & he=0 & a=2 & pc=5 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=4 & he=1 & a=0 & pc=5 -> 1 : (cte'=2) & (pc'=6);
  [] cte=4 & he=1 & a=2 & pc=5 -> 1 : (he'=0) & (pc'=6);
  [] cte=4 & he=2 & a=0 & pc=5 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=4 & he=2 & a=1 & pc=5 -> 1 : (he'=0) & (pc'=6);
  



  // Loop Logic
  [] pc=6 & k<N -> 1 : (pc'=0) & (k'=k+1) ;


endmodule

rewards "defaultControllerUsed"
  [dc_used] true : 1;
endrewards