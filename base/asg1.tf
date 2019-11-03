resource "aws_launch_template" "far" {
  name = "far"
  key_name               = "${aws_key_pair.auth.id}"
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }
  image_id               = "${var.dev_ami}"
  instance_type = "${var.dev_instance_type}"
  iam_instance_profile {
    arn = "${aws_iam_instance_profile.test_profile.arn}"

  }

  monitoring {
    enabled = true
  }
  vpc_security_group_ids = ["${aws_security_group.public_sg.id}"]
  user_data = "${base64encode(data.template_file.asg-template.rendered)}"
}

resource "aws_autoscaling_group" "far" {
  name                      = "far-terraform-nginx"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  vpc_zone_identifier       = ["${aws_subnet.public.id}"]
  launch_template {
    id= "${aws_launch_template.far.id}"
    version = "$Latest"
  }
  lifecycle {
    create_before_destroy = true

  }

}
