resource "aws_dynamodb_table" "quotes_table" {
  name           = "Quotes"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "Author"
  range_key      = "Date"

  attribute = [
    {
      name = "Author"
      type = "S"
    },
    {
      name = "Date"
      type = "N"
  }]
}

