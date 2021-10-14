data "aws_iam_role" "lb" {
  name = "aws-load-balancer-controller.kube-system.sa.${var.cluster_name}"
}

resource "aws_iam_role_policy" "certs" {
  name = "ACM"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "acm:ExportCertificate",
          "acm:GetAccountConfiguration",
          "acm:DescribeCertificate",
          "acm:GetCertificate",
          "acm:ListCertificates",
          "acm:ListTagsForCertificate"
        ],
        "Resource" : "*"
      }
    ]
  })
  role = data.aws_iam_role.lb.id
}
