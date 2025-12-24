
#ami


data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"] 

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"] 
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"] 
  }

}


# instance
resource "aws_instance" "ec2_instance" {
  count = var.workbench_instance_count

  ami                    = var.workbench_use_ami ? var.workbench_instance_ami : data.aws_ami.amazon_linux.image_id
  instance_type          = var.workbench_instance_type
  key_name               = var.pem_key_name
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.bastion_security_group_id]
  # subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_ids[1] #여기수정 #ap-northeast-2c 지정
  iam_instance_profile = var.create_iam_instance_profile ? aws_iam_instance_profile.this[0].name : null
  
  root_block_device {
    volume_type = var.workbench_volume_type
    volume_size = var.workbench_volume_size
  }
  tags = merge(var.tags, {
    Name = var.workbench_instance_name
  })

}

# ssm



data "aws_iam_policy_document" "assume_role_policy" {
  count = var.create_iam_instance_profile ? 1 : 0

  statement {
    sid     = "EC2AssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}



resource "aws_iam_role" "this" {
  count = var.create_iam_instance_profile ? 1 : 0

  name        = var.workbench_iam_role_name
  description = "ec2 ssm role"
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy[0].json
  force_detach_policies = true
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for k, v in var.workbench_iam_role_policies : k => v if var.create_iam_instance_profile }

  policy_arn = each.value
  role       = aws_iam_role.this[0].name
}

resource "aws_iam_role_policy" "inline" {		#수정
  count = var.create_iam_instance_profile ? 1 : 0

  name = "${var.workbench_iam_role_name}-inline-eks-describe"
  role = aws_iam_role.this[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowEKSDescribeCluster",
        Effect = "Allow",
        Action = [
          "eks:DescribeCluster"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_iam_instance_profile ? 1 : 0

  role = aws_iam_role.this[0].name
  name        = var.workbench_iam_role_name
  tags = var.tags

}


#eip

resource "aws_eip" "bastion_ip" {
  count = var.workbench_instance_count
  instance = aws_instance.ec2_instance[count.index].id
}
