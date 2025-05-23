#!/bin/bash

action_filter=$1



for acc in {95,99,995}; do

  set -x

  python3 src/TaxiShieldedConfPred.py -cpcte lib/acc90/real_cte_pred_acc90_conf${acc}.csv -cphe lib/acc90/real_he_pred_acc90_conf${acc}.csv -tp lib/temp_extr_dir_3.csv -af ${action_filter} --label StochDyn_acc90_conf${acc}_af${action_filter#*.}

  python3 src/TaxiShieldedConfPred.py -cpcte lib/acc90/real_cte_pred_acc90_conf${acc}.csv -cphe lib/acc90/real_he_pred_acc90_conf${acc}.csv -tp lib/temp_extr_dir_3.csv -af ${action_filter} --default_action --label StochDyn_DefAct_acc90_conf${acc}_af${action_filter#*.}

  set +x

done



