resource "aws_iam_instance_profile" "ec2_admin" {
  name = "ec2_admin"
  role = aws_iam_role.admin_access.name
}
