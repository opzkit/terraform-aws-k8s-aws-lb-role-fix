data "aws_iam_roles" "lb" {
  name_regex = "aws-load-balancer-controller.kube-system.sa.*"
}

data "aws_iam_role" "lb" {
  for_each = data.aws_iam_roles.lb.names
  name     = each.value
}

locals {
  roles_by_cluster = { for role in data.aws_iam_role.lb : role.tags["KubernetesCluster"] => role }
  role             = local.roles_by_cluster
}

resource "aws_iam_role_policy" "certs" {
  name = "ACM"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Action" : [
          "acm:ExportCertificate",
          "acm:GetAccountConfiguration",
          "acm:DescribeCertificate",
          "acm:GetCertificate",
          "acm:ListCertificates",
          "acm:ListTagsForCertificate",
          "elasticloadbalancing:AddListenerCertificates"
        ],
        "Resource" : "*"
      }
    ]
  })
  role = local.role[var.cluster_name].id
}
