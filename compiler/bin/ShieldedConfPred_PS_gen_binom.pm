
// Prism Looping State Machine

// ShieldedConfPred PS_gen_binom
// --conf_pred_cte lib/cte_confpred_gen_binom.csv
// --conf_pred_he lib/he_confpred_gen_binom.csv
// --tempest_pred lib/temp_extr_dir.csv
// --action_filter 0.5

// PC values:
//   0 : Perceiver (CTE)
//   1 : Perceiver (HE)
//   2 : Controller
//   3 : Default Controller
//   4 : Dynamics
//   5 : Loop Logic
//   -1 : dyn_fail

// Generated: 2025-03-28 11:25:31.772881

mdp

const N;

module ShieldedConfPred

  cte : [-1..4] init 0;
  he : [-1..2] init 0;
  a : [0..2] init 0;
  default : [0..1] init 0; // Flag to trigger default control
  beta : [0..N] init 0; // Counts number of times controller found no safe actions
  cte_est0 : [0..1] init 0;
  cte_est1 : [0..1] init 0;
  cte_est2 : [0..1] init 0;
  cte_est3 : [0..1] init 0;
  cte_est4 : [0..1] init 0;
  he_est0 : [0..1] init 0;
  he_est1 : [0..1] init 0;
  he_est2 : [0..1] init 0;
  pc : [-1..5] init 0; // program counter
  k : [0..N] init 1; // loop counter


  // Perceiver (CTE)
  [] cte=0 & pc=0 -> 0.0006 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0025 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.002 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.003 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.001 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.002 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0025 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0021 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0299 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0197 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0227 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0078 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0079 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0109 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0092 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0064 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0874 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0473 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0463 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0184 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0836 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0495 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0455 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0146 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.301 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0848 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0786 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0128 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) ;
  [] cte=1 & pc=0 -> 0.0009 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0002 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0023 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0007 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0113 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0013 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.1061 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0071 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0175 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0011 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0708 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0021 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0012 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0002 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0323 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0021 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0033 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0003 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0277 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0013 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.1269 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0057 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.3643 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0096 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.082 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0041 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.1153 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0023 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) ;
  [] cte=2 & pc=0 -> 0.0005 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0001 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.012 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.1065 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.001 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.007 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0023 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0003 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0152 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0649 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0015 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0022 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0007 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0319 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0001 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0022 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.124 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.3708 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0069 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0131 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0027 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0247 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0003 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0011 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.083 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.1185 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0039 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0026 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) ;
  [] cte=3 & pc=0 -> 0.1219 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0001 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0038 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0018 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.6457 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0099 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0504 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0013 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0024 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.1612 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) + 0.0015 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=0) & (pc'=1) ;
  [] cte=4 & pc=0 -> 0.1212 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0002 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0024 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.6346 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0001 : (cte_est0'=0) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0033 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0001 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0114 : (cte_est0'=0) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0561 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0026 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.1647 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0001 : (cte_est0'=1) & (cte_est1'=0) & (cte_est2'=1) & (cte_est3'=1) & (cte_est4'=1) & (pc'=1) + 0.0011 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=0) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) + 0.0002 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=0) & (pc'=1) + 0.0019 : (cte_est0'=1) & (cte_est1'=1) & (cte_est2'=1) & (cte_est3'=0) & (cte_est4'=1) & (pc'=1) ;

  // Perceiver (HE)
  [] he=0 & pc=1 -> 0.0153 : (he_est0'=0) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.0165 : (he_est0'=0) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.0995 : (he_est0'=0) & (he_est1'=1) & (he_est2'=1) & (pc'=2) + 0.1215 : (he_est0'=1) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.285 : (he_est0'=1) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.2748 : (he_est0'=1) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.1874 : (he_est0'=1) & (he_est1'=1) & (he_est2'=1) & (pc'=2) ;
  [] he=1 & pc=1 -> 0.0001 : (he_est0'=0) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.3294 : (he_est0'=0) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.0421 : (he_est0'=0) & (he_est1'=1) & (he_est2'=1) & (pc'=2) + 0.0209 : (he_est0'=1) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.0085 : (he_est0'=1) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.5676 : (he_est0'=1) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.0314 : (he_est0'=1) & (he_est1'=1) & (he_est2'=1) & (pc'=2) ;
  [] he=2 & pc=1 -> 0.3338 : (he_est0'=0) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.0447 : (he_est0'=0) & (he_est1'=1) & (he_est2'=1) & (pc'=2) + 0.022 : (he_est0'=1) & (he_est1'=0) & (he_est2'=0) & (pc'=2) + 0.5605 : (he_est0'=1) & (he_est1'=0) & (he_est2'=1) & (pc'=2) + 0.0072 : (he_est0'=1) & (he_est1'=1) & (he_est2'=0) & (pc'=2) + 0.0318 : (he_est0'=1) & (he_est1'=1) & (he_est2'=1) & (pc'=2) ;

  // Controller
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=0 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=0 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=0 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=0 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=0 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=0 & he_est2=1 & pc=2 -> (a'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=0 & pc=2 -> (a'=2) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=0 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=0 & pc=2 -> (a'=0) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=0 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=0 & pc=2 -> (default'=1) & (pc'=3) ;
  [] cte_est0=1 & cte_est1=1 & cte_est2=1 & cte_est3=1 & cte_est4=1 & he_est0=1 & he_est1=1 & he_est2=1 & pc=2 -> (default'=1) & (pc'=3) ;

  // Default Controller
  
  [] default=1 & beta<N & pc=3 -> (default'=0) & (a'=0) & (beta'=beta+1) & (pc'=4);
  [] default=1 & beta=N & pc=3 -> (default'=0) & (a'=0) & (pc'=4); // shoud never occur
  [] default=0 & pc=3 -> (pc'=4);

  // Dynamics
  
  [] he=1 & a=1 & pc=4 -> 1 : (he'=-1) & (pc'=-1); // error
  [] he=2 & a=2 & pc=4 -> 1 : (he'=-1) & (pc'=-1); // error
  [] cte=0 & he=0 & a=0 & pc=4 -> 1 : (pc'=5);
  [] cte=0 & he=0 & a=1 & pc=4 -> 1 : (cte'=1) & (he'=1) & (pc'=5);
  [] cte=0 & he=0 & a=2 & pc=4 -> 1 : (cte'=2) & (he'=2) & (pc'=5);
  [] cte=0 & he=1 & a=0 & pc=4 -> 1 : (cte'=1) & (pc'=5);
  [] cte=0 & he=1 & a=2 & pc=4 -> 1 : (he'=0) & (pc'=5);
  [] cte=0 & he=2 & a=0 & pc=4 -> 1 : (cte'=2) & (pc'=5);
  [] cte=0 & he=2 & a=1 & pc=4 -> 1 : (he'=0) & (pc'=5);
  // left -side dynamics:
  [] cte=1 & he=0 & a=0 & pc=4 -> 1 : (pc'=5);
  [] cte=1 & he=0 & a=1 & pc=4 -> 1 : (cte'=3) & (he'=1) & (pc'=5);
  [] cte=1 & he=0 & a=2 & pc=4 -> 1 : (cte'=0) & (he'=2) & (pc'=5);
  [] cte=1 & he=1 & a=0 & pc=4 -> 1 : (cte'=3) & (pc'=5);
  [] cte=1 & he=1 & a=2 & pc=4 -> 1 : (he'=0) & (pc'=5);
  [] cte=1 & he=2 & a=0 & pc=4 -> 1 : (cte'=0) & (pc'=5);
  [] cte=1 & he=2 & a=1 & pc=4 -> 1 : (he'=0) & (pc'=5);
  [] cte=3 & he=0 & a=0 & pc=4 -> 1 : (pc'=5);
  [] cte=3 & he=0 & a=1 & pc=4 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=3 & he=0 & a=2 & pc=4 -> 1 : (cte'=1) & (he'=2) & (pc'=5);
  [] cte=3 & he=1 & a=0 & pc=4 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=3 & he=1 & a=2 & pc=4 -> 1 : (he'=0) & (pc'=5);
  [] cte=3 & he=2 & a=0 & pc=4 -> 1 : (cte'=1) & (pc'=5);
  [] cte=3 & he=2 & a=1 & pc=4 -> 1 : (he'=0) & (pc'=5);
  // right -side dynamics:
  [] cte=2 & he=0 & a=0 & pc=4 -> 1 : (pc'=5);
  [] cte=2 & he=0 & a=1 & pc=4 -> 1 : (cte'=0) & (he'=1) & (pc'=5);
  [] cte=2 & he=0 & a=2 & pc=4 -> 1 : (cte'=4) & (he'=2) & (pc'=5);
  [] cte=2 & he=1 & a=0 & pc=4 -> 1 : (cte'=0) & (pc'=5);
  [] cte=2 & he=1 & a=2 & pc=4 -> 1 : (he'=0) & (pc'=5);
  [] cte=2 & he=2 & a=0 & pc=4 -> 1 : (cte'=4) & (pc'=5);
  [] cte=2 & he=2 & a=1 & pc=4 -> 1 : (he'=0) & (pc'=5);
  [] cte=4 & he=0 & a=0 & pc=4 -> 1 : (pc'=5);
  [] cte=4 & he=0 & a=1 & pc=4 -> 1 : (cte'=2) & (he'=1) & (pc'=5);
  [] cte=4 & he=0 & a=2 & pc=4 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=4 & he=1 & a=0 & pc=4 -> 1 : (cte'=2) & (pc'=5);
  [] cte=4 & he=1 & a=2 & pc=4 -> 1 : (he'=0) & (pc'=5);
  [] cte=4 & he=2 & a=0 & pc=4 -> 1 : (cte'=-1) & (pc'=-1); // error
  [] cte=4 & he=2 & a=1 & pc=4 -> 1 : (he'=0) & (pc'=5);
  



  // Loop Logic
  [] pc=5 & k<N -> 1 : (pc'=0) & (k'=k+1) ;


endmodule
