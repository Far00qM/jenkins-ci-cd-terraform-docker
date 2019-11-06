

resource "aws_iam_instance_profile" "test_profile" {
  name = "${var.vpc_name}-test_profile"
  role = "${aws_iam_role.role_c.name}"
}

resource "aws_iam_role" "role_c" {
  name = "${var.vpc_name}-role_c"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "test_policy" {
  name = "${var.vpc_name}-test_policy"
  role = "${aws_iam_role.role_c.id}"

  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "ec2:DescribeTags",
                  "ecs:CreateCluster",
                  "ecs:DeregisterContainerInstance",
                  "ecs:DiscoverPollEndpoint",
                  "ecs:Poll",
                  "ecs:RegisterContainerInstance",
                  "ecs:StartTelemetrySession",
                  "ecs:UpdateContainerInstancesState",
                  "ecs:Submit*",
                  "ecr:*",
                  "ecr:GetAuthorizationToken",
                  "ecr:BatchCheckLayerAvailability",
                  "ecr:GetDownloadUrlForLayer",
                  "ecr:BatchGetImage",
                  "logs:CreateLogStream",
                  "logs:PutLogEvents"
              ],
              "Resource": "*"
          }
      ]
}
EOF
}





resource "aws_iam_role" "ecs-service-role" {
  name = "${var.vpc_name}-ecs-service-role"
  path = "/"
  
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF

}



resource "aws_iam_policy_attachment" "service-role-ecr" {
  name = "${var.vpc_name}-ecs-service-role-ecr"
  roles = ["${aws_iam_role.ecs-service-role.name}"]
  #policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerRegistryReadOnly"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"


}



