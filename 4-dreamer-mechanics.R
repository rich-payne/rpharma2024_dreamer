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

class(linear)

mcmc4 <- dreamer_mcmc(
  data = data,
  linear = mod_linear
)

class(mcmc4)
class(mcmc$indep)

# documentation for plotting method
?plot.dreamer_mcmc
