resource "aws_instance" "Tuenti" {
  ami               = var.ami
  availability_zone = "us-east-2a"
  instance_type     = var.instance_type
  security_groups   = [var.SG_id_1]

  user_data = <<-EOF
              #!/bin/bash
              yum install -y amazon-efs-utils
              mkdir /mnt/efs
              echo "${aws_efs_file_system.efs.dns_name}:/ /mnt/efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0 0" >> /etc/fstab
              mount -a -t nfs4
              EOF
  tags = {
    Name = "Tuenti"
  }
}

resource "aws_instance" "Backup" {
  ami               = var.ami
  availability_zone = "us-east-2b"
  instance_type     = var.instance_type
  security_groups   = [var.SG_id_2]

  user_data = <<-EOF
              #!/bin/bash
              yum install -y amazon-efs-utils
              mkdir /mnt/efs
              echo "${aws_efs_file_system.efs.dns_name}:/ /mnt/efs nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0 0" >> /etc/fstab
              mount -a -t nfs4
              EOF
  tags = {
    Name = "Tuenti_Backup"
  }
}

#-----------------------------------------------------
resource "aws_ebs_volume" "Tuenti_ebs" {
  availability_zone = "us-east-2a"
  size              = 10
}

resource "aws_volume_attachment" "ebs_Tuenti" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.Tuenti_ebs.id
  instance_id = aws_instance.Tuenti.id
}

resource "aws_ebs_volume" "Backup_ebs" {
  availability_zone = "us-east-2b"
  size              = 10
}

resource "aws_volume_attachment" "ebs_Backup" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.Backup_ebs.id
  instance_id = aws_instance.Backup.id
}

#------------------------------------------------------

resource "aws_efs_file_system" "efs" {
  creation_token = "my_product"

  tags = {
    Name = "EFS"
  }
}

resource "aws_efs_mount_target" "alpha" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_1
  security_groups = [var.SG_id_1]
}
