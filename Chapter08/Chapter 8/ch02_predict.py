import matplotlib
matplotlib.use('Agg')

import numpy as np
import matplotlib.pyplot as plt

# initialization
np.random.seed(100)
alpha, sigma = 0.5, 0.5
beta = [1, 2.5]
size = 100

# Predictor variable
X1 = np.random.randn(size)
X2 = np.random.randn(size) * 0.37

# Simulate outcome variable
Y = alpha + beta[0]*X1 + beta[1]*X2 + np.random.randn(size)*sigma

fig, ax = plt.subplots(1, 2, sharex=True, figsize=(10, 4))
fig.subplots_adjust(bottom=0.15, left=0.1)

ax[0].scatter(X1, Y)
ax[1].scatter(X2, Y)
ax[0].set_ylabel('Y')
ax[0].set_xlabel('X1')
ax[1].set_xlabel('X2')


plt.grid(True)
fig.savefig('predict.png', dpi=100)
print("finish")

