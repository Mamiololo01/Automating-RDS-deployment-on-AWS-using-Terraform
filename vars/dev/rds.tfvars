# Network Vars
region                      = "us-east-1"
subnet_ids                  = ["subnet-08b9cf9419906dc9d", "subnet-076f1b6dd01464bcc", "subnet-0a21b618796ce11e4"]
multi_az                    = false
publicly_accessible         = true

# DB Vars
db_engine                   = "mysql"
db_storage_type             = "gp2"
db_username                 = "level4"
db_instance_class           = "db.t2.micro"
db_storage_size             = 20
set_secret_manager_password = true
set_db_password             = false
db_password                 = "l4secret"

# Security Group Vars
from_port                   = 3306
to_port                     = 3306
protocol                    = "tcp"
cidr_block                  = ["0.0.0.0/0"]

# Backup vars
backup_retention_period     = 7
delete_automated_backups    = true
copy_tags_to_snapshot       = true
skip_final_snapshot         = true
apply_immediately           = true

# Tag Vars
owner                       = "level4-devops"
environment                 = "dev"
cost_center                 = "level4"
application                 = "level4-commerce"