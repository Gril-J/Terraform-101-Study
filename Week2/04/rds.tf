#local 변수로 각 RDS 설정 값 정의
locals {
  instance_class = "db.t3.micro"
  rds_instances = {
    "gril-mysql" = {
      identifier           = "gril-mysql-terraform"
      db_name              = "grilmysql"
      engine               = "mysql"
      engine_version       = "8.0.32"
      parameter_group_name = "mysql8"
      port                 = 3306
      username             = "mysqladmin"
    },
    "gril-postgres" = {
      identifier           = "gril-postgres-terraform"
      db_name              = "grilpostgres"
      engine               = "postgres"
      engine_version       = "13.10"
      parameter_group_name = "postgres13"
      port                 = 5432
      username             = "postgresadmin"
    }
  }
}

## Random password 생성
resource "random_password" "rds" {
  length           = 16
  special          = true
}

# parameter group 생성
resource "aws_db_parameter_group" "mysql_parameter_group" {
  name        = "mysql8"
  family      = "mysql8.0"
  description = "Parameter group for MySQL 8"
}

resource "aws_db_parameter_group" "postgres_parameter_group" {
  name        = "postgres13"
  family      = "postgres13"
  description = "Parameter group for Postgres 13"
}

resource "aws_db_instance" "gril_rds" {
  # local에 정의된 값을 활용하여 rds 반복적으로 생성
  for_each               = local.rds_instances
  identifier             = each.value.identifier
  db_name                = each.value.db_name
  engine                 = each.value.engine
  engine_version         = each.value.engine_version
  instance_class         = local.instance_class
  allocated_storage      = 20
  username               = each.value.username
  password               = random_password.rds.result
  parameter_group_name   = each.value.parameter_group_name
  skip_final_snapshot    = true
  vpc_security_group_ids = []
}