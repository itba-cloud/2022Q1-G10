resource "aws_rds_cluster" "this" {
  cluster_identifier = "NC-aurora-cluster"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name      = "aurora-cluster-db"
  master_username    = "postgres"
  master_password    = "root"
  engine             = "aurora-postgresql"
  storage_encrypted = true
}
resource "aws_rds_cluster_instance" "this" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = "db.r4.large"
  engine             = aws_rds_cluster.this.engine
  engine_version     = aws_rds_cluster.this.engine_version
}
