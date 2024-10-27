library(dreamer)
library(ggplot2)

set.seed(3311)
data2 <- dreamer_data_loglinear(
  n_cohorts = rep(40, 4),
  doses = c(0, 2, 4, 8),
  b1 = 1,
  b2 = 5,
  sigma = 5
)

ggplot(data2, aes(dose, response)) +
  geom_point() +
  ggtitle("Simulated Data") +
  theme(plot.title = element_text(hjust = 0.5))

set.seed(15)
mcmc2 <- dreamer_mcmc(
  data = data2,
  # model names are arbitrary
  linear = model_linear(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    shape = 1,
    rate = .001,
    w_prior = 1 / 3
  ),
  loglinear = model_loglinear(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    shape = 1,
    rate = .001,
    w_prior = 1 / 3
  ),
  emax = model_emax(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    mu_b3 = log(10),
    sigma_b3 = 2,
    mu_b4 = 0,
    sigma_b4 = 10,
    shape = 1,
    rate = .001,
    w_prior = 1 / 3
  )
)

summary(mcmc2)

# look at posterior weights
mcmc2
mcmc2$w_post

# posterior samples (for custom output)
post <- posterior(mcmc2, return_samples = TRUE)
head(post$samps)
table(post$samps$model) / nrow(post$samps)
mcmc2$w_post

# plot BMA fit
plot(mcmc2, data = data2)
# plot individual model
plot(mcmc2$linear, data = data2)
plot(mcmc2$loglinear, data = data2)
plot(mcmc2$emax, data = data2)

# compare model fits graphically
plot_comparison(mcmc2)
plot_comparison(mcmc2, data = data) +
  facet_wrap(~Model)

# posterior for Bayesian model averaging
posterior(mcmc2)
# posterior fits for individual fits
posterior(mcmc2$emax)
posterior(mcmc2$loglinear)

# calculate Pr(mean response > 12) with BMA
pr_eoi(mcmc2, eoi = 12, dose  = c(4, 6, 8))
# with log-linear alone
pr_eoi(mcmc2$loglinear, eoi = 12, dose  = c(4, 6, 8))

# Try different prior model weights
#   How do the posterior weights change?
#   How does the fit change?

mcmc2_test <- dreamer_mcmc(
  data = data2,
  # model names are arbitrary
  linear = model_linear(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    shape = 1,
    rate = .001,
    w_prior = 
  ),
  loglinear = model_loglinear(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    shape = 1,
    rate = .001,
    w_prior = 
  ),
  emax = model_emax(
    mu_b1 = 0,
    sigma_b1 = 10,
    mu_b2 = 0,
    sigma_b2 = 10,
    mu_b3 = log(10),
    sigma_b3 = 2,
    mu_b4 = 0,
    sigma_b4 = 10,
    shape = 1,
    rate = .001,
    w_prior = 
  )
)

mcmc2_test

plot(mcmc2_test, data = data2)

