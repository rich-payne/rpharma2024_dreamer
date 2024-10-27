library(dreamer)
library(ggplot2)

# generate data using dreamer
set.seed(88)
data <- dreamer_data_independent(
  n_cohorts = c(25, 25, 25, 25),
  doses = c(0, 3, 9, 21),
  # response at each dose -- see documentation
  b1 = c(1, 5, 8, 9),
  sigma = 3
)

# plot the data
ggplot(data, aes(dose, response)) +
  geom_point() +
  ggtitle("Simulated Data") +
  theme(plot.title = element_text(hjust = 0.5))

# fit an independent dose-response model
# for help, look up the documentation: ?model_independent
mcmc <- dreamer_mcmc(
  data = data,
  indep = model_independent(
    # prior on mean of each dose, respectively
    mu_b1 = c(0, 0, 0, 0),
    sigma_b1 = c(10, 10, 10, 10),
    doses = c(0, 3, 9, 21),
    # prior on variance (inverse-gamma)
    shape = 1,
    rate = .001
  )
)

# check MCMC diagnostics
diagnostics(mcmc)
plot_trace(mcmc)

# parameter inference
summary(mcmc)

# print model summary
mcmc

# plot dose response
plot(mcmc)
# with data
plot(mcmc, data = data)
# placebo adjusted
plot(mcmc, reference_dose = 0)

# posterior mean at each dose
posterior(mcmc)
# placebo adjusted estimates
posterior(mcmc, reference_dose = 0)

# dose response model
mcmc_linear <- dreamer_mcmc(
  data = data,
  linear = model_linear(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    shape = 1,
    rate = .001
  )
)

# how is the model fit?
plot(mcmc_linear, data = data)

# back to the independent model...
#   Try to make the model fit poorly with strong priors
# fit an independent dose-response model
# for help, look up the documentation! :)
mcmc_poor_fit <- dreamer_mcmc(
  data = data,
  indep = model_independent(
    # prior on mean of each dose, respectively
    # model parameterizations are in the documentation:
    # change these priors:
    mu_b1 = c(0, 0, 0, 0),
    sigma_b1 = c(10, 10, 10, 10),
    doses = c(0, 3, 9, 21),
    # prior on variance (inverse gamma)
    shape = 1,
    rate = .001
  )
)

plot(mcmc_poor_fit, data = data)
