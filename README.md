## Conformal Safety Shielding for Imperfect-Perception Agents

This is the repository for the paper "Conformal Safety Shielding for Imperfect-Perception Agents". We share instructions below for reproducing the experiments reported in the paper for the autonomous airplane taxiing system.

### Training, Conformalizing, and Evaluating Perception DNN
The daataset is available at [this](https://drive.google.com/drive/u/2/folders/11fb--bx5MY4PwE2SK_XDdo5FNpw8T8w8) link.
To train a perception DNN on this data, use the `train.sh` scrip in the `train` folder. To conformalize the model and generate confusion matrices use the `test.sh` script in the same folder.

### Generating Perfect Perception Shield
To generate a shield for the perfect-perception MDP of the autonomous taxiing system, use the `build_shield.py` script in the `shielding` folder. Before running this script, you need to download the [PRISM](https://www.prismmodelchecker.org/) model checker on your machine and modify `PRISM_PATH` in the script to point to the PRISM binary.

### Constructing PRISM MDP Files
The imperfect-perception MDPs are constructed using functionality in the `compiler` and `case_studies/taxinet` folder. Refer to the READMEs in these folders for details.

### Analyzing MDP Files
The generated imperfect-perception MDPs are analyzed using the PRISM model checker. Scripts for running these analyses are available in the `case_studies/taxinet` folder.
