defmodule Sums do
  # Divides the range of numbers into smaller ranges for parallel processing
  def range_sum(start, finish, cores) do
    total_numbers = finish - start # total numbers to conside
    range_size = div(total_numbers, cores) # size of the ranges
    remaining_numbers = rem(total_numbers, cores) # remaining numbers
    ranges(start, range_size, cores, remaining_numbers) # call to the function that generates appropriate ranges between start and finish
  end


  def ranges(start, range_size, cores, remaining_numbers), do: do_ranges(start, range_size, cores, remaining_numbers, [])

  # if the cores are 0, return the result
  defp do_ranges(_, _, 0, _, res), do: Enum.reverse(res)

  # if there are remaining numbers, include them in the ranges
  defp do_ranges(start, range_size, cores, remaining_numbers, res) when remaining_numbers > 0 do
    e = start + range_size # end of range
    next_start = e + 1
    do_ranges(next_start, range_size, cores - 1, remaining_numbers - 1, [{start, e} | res])
  end

  # generates ranges of size `range_size`
  defp do_ranges(start, range_size, cores, remaining_numbers, res) do
    e = start + (range_size - 1)
    do_ranges(e + 1, range_size, cores - 1, remaining_numbers, [{start, e} | res])
  end

  # Sequential version: Calculates the sum of prime numbers within a given range (non-inclusive)
  defp sum_primes_in_range({min, max}) do
    min..max
    |> Enum.filter(&is_prime/1)  # Filters the range for prime numbers
    |> Enum.sum()  # Sums up the filtered prime numbers
  end

  # Checks if a number is prime
  def is_prime(n), do: do_is_prime(n, 2)  # Call the helper function `do_is_prime` with initial divisor as 2

  defp do_is_prime(n, _) when n == 2, do: true  # If the number is 2, it is prime

  defp do_is_prime(n, _) when n < 2, do: false  # If the number is less than 2, it is not prime

  defp do_is_prime(n, i) when rem(n, i) == 0, do: false  # If the number is divisible by `i`, it is not prime

  defp do_is_prime(n, i) do  # Recursive function to check divisibility up to the square root of the number
    if i > :math.sqrt(n) do  # If the divisor exceeds the square root of the number, it is prime
      true
    else
      do_is_prime(n, i + 1)  # Check divisibility with the next divisor
    end
  end

  # Sequential version: Calculates the sum of prime numbers up to a given limit
  def sum_primes(limit), do: sum_primes_in_range({1, limit - 1})

  # Parallel version: Calculates the sum of prime numbers up to a given limit using multiple cores
  def sum_primes_parallel(limit, cores) do
    ranges = range_sum(1, limit, cores)  # Divide the range into smaller ranges
           |> Enum.map(&Task.async(fn -> sum_primes_in_range(&1) end))  # Spawn tasks to calculate sums in parallel
           |> Enum.map(&Task.await(&1, :infinity))  # Wait for tasks to complete and retrieve results
           |> Enum.sum()  # Sum up the results
  end
end
