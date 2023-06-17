# Project Name

A brief description of the project.

## Table of Contents

- [About](#About)
- [Usage](#usage)
- [Performance](#performance)


## About

The `Sums` module provides functions for calculating the sum of prime numbers within a given range, both sequentially and in parallel. It utilizes the concept of dividing the range into smaller ranges for parallel processing.

The `range_sum/3` function divides the range of numbers into smaller ranges based on the specified number of cores. It calculates the range size and distributes any remaining numbers evenly among the ranges.

The module also includes a helper function `is_prime/1` to check if a number is prime. It uses a recursive function `do_is_prime/2` to perform the divisibility check up to the square root of the number.

The sequential version `sum_primes/1` calculates the sum of prime numbers up to a given limit using the sequential approach.

The parallel version `sum_primes_parallel/2` utilizes parallel processing by dividing the range into smaller ranges and calculating the sum of primes in parallel using multiple cores. It leverages Elixir's `Task` module to asynchronously execute tasks and retrieve the results.

## Usage

To use the `Sums` module, follow these steps:

1. Ensure that you have Elixir installed on your system.

2. Add the `Sums` module to your project or load it in the Elixir interactive shell.

3. To calculate the sum of prime numbers within a range using the sequential approach, call the `sum_primes/1` function with the desired limit (non-inclusive) as an argument. For example:
   ```elixir
   Sums.sum_primes(1000000)
   ```

4. To calculate the sum of prime numbers within a range using parallel processing, call the `sum_primes_parallel/2` function with the desired limit (non-inclusive) and the number of cores as arguments. For example, to use 4 cores:
   ```elixir
   Sums.sum_primes_parallel(1000000, 4)
   ```

   Note: Ensure that your system has enough available cores for parallel processing.

5. The functions will return the calculated sum of prime numbers within the specified range. Feel free to adjust the input parameters according to your requirements. 

## Performance

### Sequential Execution

Considering the input: 5,000,000

The time (in seconds) that it takes the sequential version of the function `sum_primes` to end is:
```
T1 = 58.45s
```
### Parallel Execution

On the other hand, the time (in seconds) that it takes the parallel version of the function `sum_primes_parallel` with 4 cores (p) to end is:
```
T4 = 18.81s
```
As we can see, the parallel version using 4 cores takes less time compared to the sequential version.

The speedup can be calculated using the following formula:
```
Sp = T1 / Tp
```
Where:
- "p" is the number of processors (or cores).
- "T1" is the execution time of the sequential version of the program.
- "Tp" is the execution time of the parallel version of the program using "p" processors.
- "Sp" is the speedup obtained using "p" processors.

Considering the use of 4 cores (p = 4), the speedup is as follows:

S4 = T1 / T4 = 58.45s / 18.81s = 3.11s

If we consider the use of cores 6, 8, 10, 12, and 14, we see the following results in time and speedup:

- T6 = 13.38s, S6 = T1 / T6 = 4.37s
- T8 = 11.64s, S8 = T1 / T8 = 5.02s
- T10 = 10.60s, S10 = T1 / T10 = 5.51s
- T12 = 10.20s, S12 = T1 / T12 = 5.73s
- T14 = 10.59s, S14 = T1 / T14 = 5.52s

Graphically, we can see the following trend in terms of both the time it takes and the speedup:

[Insert graphical representation here]

According to the results, when the number of cores increases, the time it takes for the parallel version of the program to finish is reduced. The reduction in time is primarily due to the ability to distribute the workload among multiple processors or cores. With more processors, the program can be divided into smaller tasks or chunks, and each processor can independently process its assigned task. This division of work allows for better utilization of computational resources and leads to a reduction in overall execution time.

However, it's important to note that the reduction in time may not always be directly proportional to the number of processors or cores used. Factors such as the nature of the program, the presence
