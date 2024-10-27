library(dreamer)

# how does dreamer work?
mod_linear <- model_linear(
  mu_b1 = 0,
  sigma_b1 = 10,
  mu_b2 = 0,
  sigma_b2 = 10,
  shape = 1,
  rate = .001
)

mod_linear

class(mod_linear)

set.seed(88)
data <- dreamer_data_independent(
  n_cohorts = c(25, 25, 25, 25),
  doses = c(0, 3, 9, 21),
  # response at each dose -- see documentation
  b1 = c(1, 5, 8, 9),
  sigma = 3
)

mcmc4 <- dreamer_mcmc(
  data = data,
  linear = mod_linear
)

class(mcmc4)
class(mcmc4$linear)

# documentation for plotting method
?plot.dreamer_mcmc
