import matplotlib
matplotlib.use('Agg')


import numpy as np
import skfuzzy as fuzz
import matplotlib.pyplot as plt

# Generate universe variables
x_temp = np.arange(0, 11, 1)

# Generate fuzzy membership functions
temp_lo = fuzz.trimf(x_temp, [0, 0, 5])
temp_md = fuzz.trimf(x_temp, [0, 5, 10])
temp_hi = fuzz.trimf(x_temp, [5, 10, 10])

# Visualize these universes and membership functions
fig, ax = plt.subplots()

ax.plot(x_temp, temp_lo, 'b--', linewidth=1.5, label='Cold')
ax.plot(x_temp, temp_md, 'g-', linewidth=1.5, label='Warm')
ax.plot(x_temp, temp_hi, 'r:', linewidth=1.5, label='Hot')
ax.set_title('Temperature')
ax.legend()

ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)
ax.get_xaxis().tick_bottom()
ax.get_yaxis().tick_left()
ax.set_ylabel('Fuzzy membership')

plt.tight_layout()

print('saving...')
plt.grid(True)
fig.savefig('fuzzy_membership.png', dpi=100)
print('done')
