data "aws_iam_policy_document" "alb_controller" {
  statement {
    actions = [
      "elasticloadbalancing:*",
      "ec2:Describe*",
      "ec2:CreateSecurityGroup",
      "ec2:CreateTags",
      "ec2:AuthorizeSecurityGroupIngress",
      "iam:CreateServiceLinkedRole",
      "cognito-idp:DescribeUserPoolClient",
      "waf-regional:GetWebACLForResource",
      "waf-regional:GetWebACL",
      "waf-regional:AssociateWebACL",
      "waf-regional:DisassociateWebACL",
      "wafv2:GetWebACLForResource",
      "wafv2:GetWebACL",
      "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL",
      "shield:GetSubscriptionState",
      "shield:DescribeProtection",
      "shield:CreateProtection",
      "shield:DeleteProtection"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "alb_controller" {
  name   = "AWSLoadBalancerControllerPolicy"
  policy = data.aws_iam_policy_document.alb_controller.json
}

