resource "aws_db_subnet_group" "this" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags = { Name = "${var.db_name}-subnet-group" }
}

resource "aws_db_instance" "this" {
  identifier              = var.db_name
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = true
  publicly_accessible     = false
}