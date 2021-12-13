data "aws_iam_roles" "lb" {
  name_regex = "aws-load-balancer-controller.kube-system.sa.*"
}

data "aws_iam_role" "lb" {
  name = tolist(data.aws_iam_roles.lb.names)[0]
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
  role = data.aws_iam_role.lb.id
}
