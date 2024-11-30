resource "random_id" "db_username" {
  byte_length = 8
}

resource "random_password" "db_password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "rds-postgres-credentials"
}

resource "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = random_id.db_username.hex
    password = random_password.db_password.result
  })
}

resource "aws_db_subnet_group" "eu_west_1" {
  name       = "main-db-subnet-group"
  subnet_ids = var.private_subnets_eu_west_1
}

resource "aws_db_subnet_group" "us_west_1" {
  provider   = aws.us_east_1
  name       = "main-db-subnet-group"
  subnet_ids = var.private_subnets_us_east_1
}

resource "aws_db_instance" "primary" {
  identifier              = "primary-postgres-db"
  engine                  = "postgres"
  engine_version          = "13.4"
  instance_class          = "db.t3.medium"
  db_subnet_group_name    = aws_db_subnet_group.eu_west_1.name
  multi_az                = true
  publicly_accessible     = false
  storage_encrypted       = true
  storage_type            = "gp2"
  allocated_storage       = 20
  max_allocated_storage   = 100
  backup_retention_period = 7
  maintenance_window      = "Sun:03:00-Sun:04:00"

  username = random_id.db_username.hex
  password = random_password.db_password.result

  tags = {
    Environment = var.environment
  }
}

resource "aws_db_instance" "replica" {
  provider             = aws.us_east_1
  identifier           = "replica-postgres-db"
  engine               = "postgres"
  instance_class       = "db.t3.medium"
  db_subnet_group_name = aws_db_subnet_group.us_west_1.name
  publicly_accessible  = false
  storage_encrypted    = true
  storage_type         = "gp2"
  allocated_storage    = 20
  replicate_source_db  = aws_db_instance.primary.id

  tags = {
    Environment = var.environment
  }
}
