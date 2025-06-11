# Load the functions from the 'functions.R' file
source("R/functions.R")

# --- Simulation Parameters ---
MC <- 1000 # Number of Monte Carlo simulations
C <- 10    # System failure capacity threshold
alpha <- 0.1 # Damage decay rate

# --- Data Storage for Simulation Results ---
shocks <- c() # To store the number of shocks for each simulation
times <- c()  # To store the time until failure for each simulation

# --- Run Monte Carlo Simulation ---
start_time <- Sys.time() # Record start time for performance measurement

for (i in 1:MC) {
  # Run a single simulation of the Poisson process
  result <- poisson_process_simulation(C, alpha)
  
  # Store the results from the current simulation
  shocks <- c(shocks, result$sim_shocks)
  times <- c(times, result$sim_times)
}

end_time <- Sys.time() # Record end time

# --- Display Simulation Summary Statistics ---
cat("Expected number of shocks before failure:", mean(shocks), "\n")
cat("Expected time until the system fails (in hours):", mean(times), "\n")
cat("The program took ", end_time - start_time, " to finish\n")

# --- Visualize Distributions ---
# Ensure the 'results' directory exists to save plots
if (!dir.exists("results")) {
  dir.create("results")
}

# Save histogram for number of shocks
png("results/shocks_distribution.png", width = 800, height = 600, res = 100)
par(mfrow = c(1, 1)) # Reset par to single plot per page
hist(shocks, 
     main = "Distribution of Number of Shocks Until System Failure", 
     xlab = "Number of shocks until system breaks", 
     ylab = "Frequency",
     col = "lightblue", border = "black")
abline(v = mean(shocks), col = "red", lty = 2, lwd = 2)
legend("topright", legend = c("Mean"), col = "red", lty = 2, cex = 0.8)
dev.off() # Close the PNG device

# Save histogram for time until failure
png("results/times_distribution.png", width = 800, height = 600, res = 100)
par(mfrow = c(1, 1)) # Reset par to single plot per page
hist(times, 
     main = "Distribution of Time Until System Failure", 
     xlab = "Number of hours until system breaks", 
     ylab = "Frequency",
     col = "lightgreen", border = "black")
abline(v = mean(times), col = "blue", lty = 2, lwd = 2)
legend("topright", legend = c("Mean"), col = "blue", lty = 2, cex = 0.8)
dev.off() # Close the PNG device

message("Plots saved to the 'results/' directory.")

# --- Final Results Summary ---
message("\n--- Simulation Results ---")
message(paste("After running", MC, "simulations, we obtained that on average:"))
message(paste("- The system fails after about", round(mean(shocks), 3), "shocks."))
message(paste("- The system lasts around", round(mean(times), 3), "hours before breaking down."))
message("These numbers help understand system robustness under given parameters (alpha =", alpha, ", C =", C, ").")
