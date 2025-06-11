import re
import subprocess
import itertools
import os
import csv

# Configuration: adjust these paths and lists as needed
PRISM_PATH = "./prism-4.7-src/prism/bin/prism"  # Path to the PRISM executable
MODEL_TEMPLATE = "../system_models/taxinet_Boeing5bins_perfect_shielding_stochdyn.pm"  # Original model file with init...endinit block
PROPERTY_FILE = "../system_models/shielding_prop.pctl"  # PRISM property file
OUTPUT_DIR = "prism_outputs"  # Directory for outputs

# Values to iterate over
cte_values = [0, 1, 2, 3, 4]  # example cte values
he_values = [0, 1, 2]          # example he values
a_values  = [0, 1, 2]        # example a values

# Ensure output directory exists
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Read the template model file
with open(MODEL_TEMPLATE, 'r') as f:
    template_content = f.read()

# Regex to find and replace the init...endinit block
def build_model(content, cte_val, he_val, a_val):
    pattern = re.compile(r"init(.*?)endinit", re.DOTALL)
    match = pattern.search(content)
    if not match:
        raise ValueError("init...endinit block not found in model file")
    inner = match.group(1)
    # Split assignments on '&' and strip
    assigns = [s.strip() for s in inner.split('&') if s.strip()]
    new_assigns = []
    for assignment in assigns:
        if assignment.startswith('cte='):
            new_assigns.append(f'    cte={cte_val}')
        elif assignment.startswith('he='):
            new_assigns.append(f'    he={he_val}')

        elif assignment.startswith('cte_est='):
            new_assigns.append(f'    cte_est={cte_val}')
        elif assignment.startswith('he_est='):
            new_assigns.append(f'    he_est={he_val}')
        elif assignment.startswith('a='):
            new_assigns.append(f'    a={a_val}')
        elif assignment.startswith('pc='):
            new_assigns.append(f'    pc=4')
        else:
            new_assigns.append('    ' + assignment)
    # Rebuild init block with '&' separators
    new_block = 'init ' + ' & '.join(new_assigns) + ' endinit'
    return pattern.sub(new_block, content)

# Store results
driver_results = []

# Loop over all combinations of parameters
for cte, he, a in itertools.product(cte_values, he_values, a_values):
    # Prepare modified model file
    model_filename = os.path.join(OUTPUT_DIR, f'model_cte{cte}_he{he}_a{a}.pm')
    modified_content = build_model(template_content, cte, he, a)
    with open(model_filename, 'w') as mf:
        mf.write(modified_content)

    # Run PRISM and redirect output
    output_file = os.path.join(OUTPUT_DIR, f'output_cte{cte}_he{he}_a{a}.txt')
    with open(output_file, 'w') as outf:
        subprocess.run([
            PRISM_PATH,
            model_filename,
            PROPERTY_FILE
        ], stdout=outf, stderr=subprocess.STDOUT, check=True)

    # Parse the 'Result: ' line
    with open(output_file, 'r') as outf:
        for line in outf:
            if line.startswith('Result:'):
                match = re.search(r'Result:\s*([0-9\.eE+-]+)', line)
                if match:
                    val = float(match.group(1))
                    driver_results.append({'cte': cte, 'he': he, 'a': a, 'result': val})
                break

# Write aggregated results to CSV
csv_file = os.path.join(OUTPUT_DIR, 'aggregated_results.csv')
with open(csv_file, 'w', newline='') as cf:
    fieldnames = ['cte', 'he', 'a', 'result']
    writer = csv.DictWriter(cf, fieldnames=fieldnames)
    writer.writeheader()
    for row in driver_results:
        writer.writerow(row)

print(f"Completed PRISM runs for {len(driver_results)} combinations.")
print(f"Results saved in {csv_file}.")

# Construct shield from aggregated results and write to file
shield_file = os.path.join(OUTPUT_DIR, 'shield.txt')
with open(shield_file, 'w') as sf:
    for cte in cte_values:
        for he in he_values:
            # Header with fixed fields
            header = (
                f"[cte={cte} & he={he}   & cte_est={cte}     & he_est={he}      "
                "& pc=3  & a=-1  & crash=0]"
            )
            # Gather results for this (cte, he)
            results = [r for r in driver_results if r['cte']==cte and r['he']==he]
            # Build action outputs
            actions_str = []
            for idx, a in enumerate(a_values):
                # find corresponding result
                entry = next((r for r in results if r['a']==a), None)
                if entry == None:
                    continue
                res_val = entry['result']
                if idx < len(a_values) - 1:
                    actions_str.append(f"{res_val}: ({idx} {{}});")
                else:
                    actions_str.append(f"{res_val}: ({idx} {{}})")
            # Print combined line
            line = header + " " + "     ".join(actions_str)
            sf.write(line + "\n")
