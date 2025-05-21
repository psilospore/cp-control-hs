
with open('controller_excerpt.txt') as f:
	lines=f.readlines()
	count=0
	for l in lines:
		if l.strip()=='// Perceiver (HE)':
			break
		count+=1
	cte_lines=lines[1:count]
	he_lines=lines[count+1:]

# all_sets=

for line in cte_lines:
	sets=line.split(' -> ')[-1]
	sets=sets.split(' + ')
	for s in sets:
