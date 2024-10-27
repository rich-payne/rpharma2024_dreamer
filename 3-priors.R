library(dreamer)

# checking your prior
dreamer_plot_prior(
  doses = c(0, 2, 8 , 12),
  loglinear = model_loglinear(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    shape = 1,
    rate = .001
  )
)

# see individual draws of your prior
dreamer_plot_prior(
  doses = seq(0, 12, .1),
  n_samples = 25,
  plot_draws = TRUE,
  loglinear = model_loglinear(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    shape = 1,
    rate = .001
  )
)

# Also can extend to a BMA prior
# see individual draws of your prior
# Try changing the prior weight of the model
#   What changes?

dreamer_plot_prior(
  doses = seq(0, 12, .1),
  n_samples = 25,
  plot_draws = TRUE,
  loglinear = model_loglinear(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    shape = 1,
    rate = .001,
    w_prior = 1 / 2
  ),
  emax = model_emax(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    mu_b3 = log(5),
    sigma_b3 = 1,
    mu_b4 = 0,
    sigma_b4 = 10,
    shape = 1,
    rate = .001,
    w_prior = 1 / 2
  )
)

# get prior draws
mcmc_prior <- dreamer_mcmc(
  data = NULL,
  loglinear = model_loglinear(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    shape = 1,
    rate = .001,
    w_prior = 1 / 2
  ),
  emax = model_emax(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    mu_b3 = log(5),
    sigma_b3 = 1,
    mu_b4 = 0,
    sigma_b4 = 10,
    shape = 1,
    rate = .001,
    w_prior = 1 / 2
  )
)

summary(mcmc_prior)
