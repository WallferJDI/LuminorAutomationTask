module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name    = "eks-cluster"
  cluster_version = var.kubernetes_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids

  enable_irsa                    = true
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    general = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      instance_types = ["t3.medium"]
      capacity_type = "ON_DEMAND"
    }
  }

  enable_cluster_creator_admin_permissions = true
  access_entries = {
    eks_admin = {
      principal_arn = aws_iam_role.eks_admin.arn
      kubernetes_groups = ["eks-admins"]
    },
    eks_read_only = {
      principal_arn = aws_iam_role.eks_read_only.arn
      kubernetes_groups = ["eks-read-only"]
    }
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role" "eks_admin" {
  name = "eks-admin"

  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
  tags = {
    RoleType    = "admin"
    Environment = var.environment
  }
}

resource "aws_iam_role" "eks_read_only" {
  name = "eks-read-only"

  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
  tags = {
    RoleType    = "read-only"
    Environment = var.environment
  }
}

data "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_admin_attach" {
  role       = aws_iam_role.eks_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "eks_read_only_attach" {
  role       = aws_iam_role.eks_read_only.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
