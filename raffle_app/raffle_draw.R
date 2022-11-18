library(AzureRMR)
library(AzureTableStor)
library(tidyverse)
library(qrcode)

# generate a QR code of the URL so people can easily enter the raffle
qr_code("https://connect.strategyunitwm.nhs.uk/nhsr_2022_raffle/") |> plot()

# this function can be used if you have access to the storage account, otherwise we can load in the results from a csv
get_entries_from_azure <- function() {
  # connect to a table storage account
  table <- table_endpoint(
    Sys.getenv("STORAGE_URI"),
    key = Sys.getenv("STORAGE_KEY")
  ) |>
    # connect to the table which contains our data
    storage_table("nhsrconf22raffle") |>
    # query all of the entities in the table
    list_table_entities() |>
    # convert to tibble, select just the raffle number and t-shirt size, and sort the results
    as_tibble() |>
    select(n, size) |>
    arrange(n)
}

create_entries_sample <- function() {
  tibble(
    n = 1:20,
    # generate 5 entries for each t-shirt size, then shuffle them into a random order
    size = rep(c("L", "M", "S", "XL"), each = 5) |> sample()
  )
}

# for sampling results, set seed using the date of day 2 of the conference
set.seed(20221117)

# get the entries to the raffle [could replace read_csv here with get_entries_from_azure()]
entries <- create_entries_sample() |>
  # randomly shuffle the rows
  sample_frac() |>
  # create a row number within each group (size of t-shirt)
  group_by(size) |>
  mutate(row_number = row_number())

# create a table that contains n rows for the amount of t-shirts we have in that size
t_counts <- c("S" = 2, "M" = 1, "L" = 1, "XL" = 2) |>
  enframe("size", "count")  |>
  mutate(row_number = map(count, seq, from = 1)) |>
  unnest(row_number)

# we can now join our entries to the t-shirt counts table, which will filter to give us our winners
entries |>
  inner_join(t_counts) |>
  arrange(n) |>
  select(n, size)
