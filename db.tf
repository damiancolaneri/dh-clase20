module "db" {
  source = "terraform-aws-modules/rds/aws"
  #version = "3.3.0"

  identifier = "demodb"

  engine               = "mysql"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  engine_version       = "8.0.28"

  name     = "demodb"
  username = "user"
  password = "demouser!"
  port     = "3306"

  instance_class    = "db.t2.small"
  allocated_storage = 5

  iam_database_authentication_enabled = true
  skip_final_snapshot                 = true
  publicly_accessible                 = true

  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_ids             = module.vpc.public_subnets

  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole-c9"
  create_monitoring_role = true

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  tags = local.common_tags
}
