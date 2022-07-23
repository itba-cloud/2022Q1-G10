
resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
}

resource "aws_rds_cluster" "this" {
  cluster_identifier = var.cluster_identifier
  engine             = var.engine
  engine_mode        = var.engine_mode
  engine_version     = var.engine_version
  database_name      = var.database_name
  master_username    = var.master_username
  # master_password    = data.aws_secretsmanager_secret_version.password.secret_string
  master_password = "rootroot"
  availability_zones = var.availability_zones
  storage_encrypted  = var.storage_encrypted
  final_snapshot_identifier = var.final_snapshot_identifier
  db_subnet_group_name = aws_db_subnet_group.this.name

  serverlessv2_scaling_configuration {
    max_capacity = var.max_capacity
    min_capacity = var.min_capacity
  }

  depends_on = [
    aws_db_subnet_group.this
  ]
}

resource "aws_rds_cluster_instance" "this" {
  instance_class       = "db.serverless"
  cluster_identifier   = aws_rds_cluster.this.id
  engine               = aws_rds_cluster.this.engine
  engine_version       = aws_rds_cluster.this.engine_version
  db_subnet_group_name = aws_rds_cluster.this.db_subnet_group_name

}
