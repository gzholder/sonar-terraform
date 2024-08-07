# Create Security Group
resource "aws_security_group" "allow_mysql" {
  name         ="aurora_sg"
  description  = "Aurora security group"
  vpc_id       = aws_vpc.sonar_vpc.id

  ingress {
    description     = "MySQL aurora"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    #security_groups = ["${aws_security_group.auto_scale_sg.id}"]
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
   from_port       = 0
   to_port         = 0
   protocol        = "-1"
   cidr_blocks     = ["0.0.0.0/0"]
   }
}

# Create subnet group
resource "aws_db_subnet_group" "sonardb_subnet_group" {
  name              = "sonardb-subnet-group"
  subnet_ids = [aws_subnet.public_subnets[0].id, aws_subnet.public_subnets[1].id, aws_subnet.public_subnets[2].id]
    #aws_subnet.public_subnets[0].id,
    #aws_subnet.private_subnets[0].id
    #    aws_subnet.private_subnets.*.id
  tags = {
    name = "SonarDB-Subnet-Group"
  }
}


#Create Cluster
resource "aws_rds_cluster" "sonar_aurora_mysql_cluster" {
  cluster_identifier           = "sonar-aurora-db"
  engine                       = "aurora-mysql"
  engine_version               = "5.7.mysql_aurora.2.12.0"
  master_username              = "admin"
  database_name                = "sonar_db"
  availability_zones            = var.a_zones
  manage_master_user_password  = true
  final_snapshot_identifier    = "sonar-db-snapshot"
  skip_final_snapshot          = false
  deletion_protection          = false
  backup_retention_period      = 10
  preferred_backup_window      = "02:00-03:00"
  preferred_maintenance_window = "sat:05:00-sat:06:00"
  db_subnet_group_name         = aws_db_subnet_group.sonardb_subnet_group.name
  vpc_security_group_ids       = [aws_security_group.allow_mysql.id]
}

# Create Cluster Instances
resource "aws_rds_cluster_instance" "sonardb_cluster_instances" {
  count               = 2
  identifier          = "sonardb-aurora-instance-${count.index}"
  cluster_identifier  = aws_rds_cluster.sonar_aurora_mysql_cluster.id
  instance_class      = "db.t3.small"
  engine              = aws_rds_cluster.sonar_aurora_mysql_cluster.engine
  engine_version      = aws_rds_cluster.sonar_aurora_mysql_cluster.engine_version
  publicly_accessible = false
}

