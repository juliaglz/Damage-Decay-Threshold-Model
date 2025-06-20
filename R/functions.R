# Function to calculate the total damage at a given time
# Args:
#   times: A numeric vector of times at which shocks occurred.
#   init_damages: A numeric vector of initial damage values for each shock.
#   t: The current time at which to calculate total damage.
#   alpha: The damage decay rate parameter.
# Returns:
#   The sum of current damages from all past shocks.
total_damage_calc <- function(times, init_damages, t, alpha) {
  # Calculate the current damage for each shock, considering decay
  y <- init_damages * exp((-alpha) * (t - times))
  # Return the sum of all current damages
  return(sum(y))
}

# Function to simulate a Poisson process until total damage exceeds a threshold
# Args:
#   C: The damage threshold (system failure capacity).
#   alpha: The damage decay rate parameter.
# Returns:
#   A list containing the number of shocks and the time passed until failure.
poisson_process_simulation <- function(C, alpha) {
  # Parameters
  lambda <- 1 # Rate parameter for the exponential distribution (inter-arrival times)

  # Initialization of the variables
  time_passed <- 0       # Cumulative time elapsed
  num_shocks <- 0       # Count of shocks
  total_damage <- 0     # Cumulative damage
  expected_time <- 0    # Final time passed
  expected_shocks <- 0  # Final number of shocks

  # Initialization of the vectors (to store the shock times, and their damages)
  shock_times <- c()      # Stores the time of each shock
  initial_damages <- c()  # Stores the initial damage caused by each shock

  # Loop until the total damage exceeds the threshold C
  while (total_damage <= C) {
    # Simulate the time until the next shock using an exponential distribution
    time_until_next_shock <- rexp(1, lambda)
    time_passed <- time_passed + time_until_next_shock

    # Increment the number of shocks
    num_shocks <- num_shocks + 1
    shock_times <- c(shock_times, time_passed)

    # Simulate the initial damage associated with the shock using a Gamma distribution
    damage_shock <- rgamma(1, shape = 2, scale = 2/3)
    initial_damages <- c(initial_damages, damage_shock)

    # Calculate the total damage at the current time, using the helper function
    total_damage <- total_damage_calc(shock_times, initial_damages, time_passed, alpha)
  }

  # Store the final number of shocks and time passed before failure
  expected_shocks <- length(shock_times)
  expected_time <- time_passed

  # Return the results as a list
  return(list(sim_shocks = expected_shocks, sim_times = expected_time))
}
