resource "aws_iam_role_policy" "admin_policy" {
  name = "admin_policy"
  role = aws_iam_role.admin_access.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
