library(shiny)
library(shinyjs)
library(AzureTableStor)
library(openssl)
library(stringr)

# connect to a table in azure storage
table <- table_endpoint(
  Sys.getenv("STORAGE_URI"),
  key = Sys.getenv("STORAGE_KEY")
) |>
  storage_table("nhsrconf22raffle")

# keep track of how many raffle tickets have currently been assigned
n_entries <- list_table_entities(table) |>
  nrow()

# use a salt for our pbkdf2 encryption of passwords. reuse the storage key as the hmac key
salt <- sha256(
  "nhs-r conference 2022",
  Sys.getenv("STORAGE_KEY")
) |>
  charToRaw()

# encrypt the password using pbkdf - this is a one way (e.g., not decryptable) function
generate_hash <- function(email) {
  email |>
    bcrypt_pbkdf(salt, 256L, 32L) |>
    paste(collapse = "")
}

# function to validate email (https://emailregex.com/)
validate_email <- function(email) {
  regex <- r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)"

  str_detect(email, regex)
}

# define our ui
ui <- fluidPage(
  useShinyjs(),
  h1("NHS-R Conference T-Shirt Raffle"),
  textInput("email", "Email"),
  selectInput("size", "T-Shirt Size", c("S", "M", "L", "XL", "2XL")),
  actionButton("go", "Enter Raffle"),
  p(
    "We will only store a hash of your password using PBKDF2.",
    "You can only enter once, but you can resubmit if you forget your number."
  ),
  textOutput("results")
)

server <- function(input, output, session) {

  # either insert a record, or update it
  # hash is the hashed email and is used as the row/partition key
  upsert_record <- function(hash, size) {
     exists <- list_table_entities(
       table,
       filter = glue::glue("RowKey eq '{hash}'"),
       select = "n"
     )

     # as we filter on the RowKey, we can only get 1 or 0 rows above
     if (length(exists) == 1) {
       n <- exists$n
       fn <- update_table_entity
     } else {
       # increment our n_entries, and use that as the raffle number
       n_entries <<- n_entries + 1
       n <- n_entries
       fn <- insert_table_entity
     }

     # insert or update the row
     fn(
       table,
       list(
         RowKey = hash,
         PartitionKey = hash,
         size = size,
         n = n
       )
     )

     # return the raffle number
     return(n)
  }

  # show the raffle number when the go button is pressed
  output$results <- renderText({
    # make sure we have a valid email address
    validate(
      need(validate_email(input$email), "Email is not valid")
    )
    # disable the submit button so we can't press it a second time
    disable("go")

    # generate the hash of the email
    hash <- generate_hash(input$email)
    # insert or update the record, which returns the raffle number
    n <- upsert_record(hash, input$size)

    paste("Thanks! Your raffle number is:", n)
  }) |>
    bindEvent(input$go)
}

shinyApp(ui, server)
