
// Prism Looping State Machine

// ShieldedConfPred PS_toy1
// --conf_pred_cte lib/cte_confpred_toy.csv
// --conf_pred_he lib/he_confpred_toy.csv
// --tempest_pred lib/temp_extr_conf.csv
// --action_filter 0.3

// PC values:
//   0 : Perceiver (CTE)
//   1 : Perceiver (HE)
//   2 : Controller
//   3 : Dynamics
//   4 : Loop Logic
//   -1 : dyn_fail

// Generated: 2025-03-11 13:23:36.175221

mdp

const N;

module ShieldedConfPred

  cte : [-1..4] init 0;
  he : [-1..2] init 0;
  a : [0..2] init 0;
  alpha : [0..N] init 0; // Counts number of times controller found no safe actions
  cte_est0 : [0..1] init 0;
  cte_est1 : [0..1] init 0;
  cte_est2 : [0..1] init 0;
  cte_est3 : [0..1] init 0;
  cte_est4 : [0..1] init 0;
  he_est0 : [0..1] init 0;
  he_est1 : [0..1] init 0;
  he_est2 : [0..1] init 0;
  pc : [-1..4] init 0; // program counter
  k : [0..N] init 1; // loop counter


  // Perceiver (CTE)
  [] cte=0 & pc=0 -> 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) ;
  [] cte=1 & pc=0 -> 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) ;
  [] cte=2 & pc=0 -> 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) ;
  [] cte=3 & pc=0 -> 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) ;
  [] cte=4 & pc=0 -> 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.03125 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) ;

  // Perceiver (HE)
  [] he=0 & pc=1 -> 0.125 : (he_est0'=0) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=0) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.125 : (he_est0'=0) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=0) & (he_est1'=1) & (he_est2'=1) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=1) & (he_est2'=1) & (pc'=2) ;
  [] he=1 & pc=1 -> 0.125 : (he_est0'=0) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=0) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.125 : (he_est0'=0) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=0) & (he_est1'=1) & (he_est2'=1) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=1) & (he_est2'=1) & (pc'=2) ;
  [] he=2 & pc=1 -> 0.125 : (he_est0'=0) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=0) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.125 : (he_est0'=0) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=0) & (he_est1'=1) & (he_est2'=1) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.125 : (he_est0'=1) & (he_est1'=1) & (he_est2'=1) & (pc'=2) ;

  // Controller
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (alpha'=alpha+1) & (pc'=3) ;

  // Dynamics
  
  [] he=1 & a=1 & pc=3 -> 1 : (he'=-1) & (pc'=-1); // error
  [] he=2 & a=2 & pc=3 -> 1 : (he'=-1) & (pc'=-1); // error
  [] cte=0 & he=0 & a=0 & pc=3 -> 1 : (pc'=4);
  [] cte=0 & he=0 & a=1 & pc=3 -> 1 : (cte'=1) & (he'=1) & (pc'=4);
  [] cte=0 & he=0 & a=2 & pc=3 -> 1 : (cte'=2) & (he'=2) & (pc'=4);
  [] cte=0 & he=1 & a=0 & pc=3 -> 1 : (cte'=1) & (pc'=4);
  [] cte=0 & he=1 & a=2 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=0 & he=2 & a=0 & pc=3 -> 1 : (cte'=2) & (pc'=4);
  [] cte=0 & he=2 & a=1 & pc=3 -> 1 : (he'=0) & (pc'=4);
  // left -side dynamics:
  [] cte=1 & he=0 & a=0 & pc=3 -> 1 : (pc'=4);
  [] cte=1 & he=0 & a=1 & pc=3 -> 1 : (cte'=3) & (he'=1) & (pc'=4);
  [] cte=1 & he=0 & a=2 & pc=3 -> 1 : (cte'=0) & (he'=2) & (pc'=4);
  [] cte=1 & he=1 & a=0 & pc=3 -> 1 : (cte'=3) & (pc'=4);
  [] cte=1 & he=1 & a=2 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=1 & he=2 & a=0 & pc=3 -> 1 : (cte'=0) & (pc'=4);
  [] cte=1 & he=2 & a=1 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=3 & he=0 & a=0 & pc=3 -> 1 : (pc'=4);
  [] cte=3 & he=0 & a=1 & pc=3 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=3 & he=0 & a=2 & pc=3 -> 1 : (cte'=1) & (he'=2) & (pc'=4);
  [] cte=3 & he=1 & a=0 & pc=3 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=3 & he=1 & a=2 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=3 & he=2 & a=0 & pc=3 -> 1 : (cte'=1) & (pc'=4);
  [] cte=3 & he=2 & a=1 & pc=3 -> 1 : (he'=0) & (pc'=4);
  // right -side dynamics:
  [] cte=2 & he=0 & a=0 & pc=3 -> 1 : (pc'=4);
  [] cte=2 & he=0 & a=1 & pc=3 -> 1 : (cte'=0) & (he'=1) & (pc'=4);
  [] cte=2 & he=0 & a=2 & pc=3 -> 1 : (cte'=4) & (he'=2) & (pc'=4);
  [] cte=2 & he=1 & a=0 & pc=3 -> 1 : (cte'=0) & (pc'=4);
  [] cte=2 & he=1 & a=2 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=2 & he=2 & a=0 & pc=3 -> 1 : (cte'=4) & (pc'=4);
  [] cte=2 & he=2 & a=1 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=4 & he=0 & a=0 & pc=3 -> 1 : (pc'=4);
  [] cte=4 & he=0 & a=1 & pc=3 -> 1 : (cte'=2) & (he'=1) & (pc'=4);
  [] cte=4 & he=0 & a=2 & pc=3 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=4 & he=1 & a=0 & pc=3 -> 1 : (cte'=2) & (pc'=4);
  [] cte=4 & he=1 & a=2 & pc=3 -> 1 : (he'=0) & (pc'=4);
  [] cte=4 & he=2 & a=0 & pc=3 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=4 & he=2 & a=1 & pc=3 -> 1 : (he'=0) & (pc'=4);
  



  // Loop Logic
  [] pc=4 & k<N -> 1 : (pc'=0) & (k'=k+1) ;


endmodule
