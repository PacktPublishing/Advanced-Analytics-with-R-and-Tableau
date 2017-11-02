
# demo decision system - based bayesian decision theory

# decision action
# d1 = distribute water
# d2 = cleaning the water


# prior
p_w1 = 0.8
p_w2 = 0.2

# lost matrix
lambda_1_1 = 0
lambda_1_2 = 5
lambda_2_1 = 10
lambda_2_2 = 0


# class conditional probabilities
# taking some observations if water is bad or not.
# x1 = negative
# x2 = positive
p_x1_w1 = 0.3
p_x1_w2 = 0.7
p_x2_w1 = 0.2
p_x2_w2 = 0.8


# calculate p_x1 and p_x2
p_x1 = p_x1_w1 * p_w1 + p_x1_w2 * p_w2
p_x2 = p_x2_w1 * p_w1 + p_x2_w2 * p_w2


# calculate conditional risk given the observation
p_w1_x1 = (p_x1_w1 * p_w1) / p_x1
p_w2_x1 = (p_x1_w2 * p_w2) / p_x1
p_w1_x2 = (p_x2_w1 * p_w1) / p_x2
p_w2_x2 = (p_x2_w2 * p_w2) / p_x2


r_d1_x1 = p_w1_x1 * lambda_1_1 + p_w2_x1 * lambda_1_2
r_d2_x1 = p_w1_x1 * lambda_2_1 + p_w2_x1 * lambda_2_2
r_d1_x2 = p_w1_x2 * lambda_1_1 + p_w2_x2 * lambda_1_2
r_d2_x2 = p_w1_x2 * lambda_2_1 + p_w2_x2 * lambda_2_2

print("r_a1_x1: ", r_d1_x1)
print("r_a2_x1: ", r_d2_x1)
print("r_a1_x2: ", r_d1_x2)
print("r_a2_x2: ", r_d2_x2)


# calculate the total risk
e_d1 = p_x1 * r_d1_x1 + p_x2 * r_d1_x2
e_d2 = p_x1 * r_d2_x1 + p_x2 * r_d2_x2
print("e_d1: ", e_d1)
print("e_d2: ", e_d2)


if e_d1 < e_d2:
    print("final decision: d1 - distribute water")
else:
    print("final decision: d2 - cleaning the water")


