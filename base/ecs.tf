resource "aws_ecs_cluster" "testcluster" {
    #name = "${var.ecs_cluster}"
    name = "testcluster"
}


data "template_file" "task-json" {
  #template = "${file("${path.module}/task.json")}"
  template = "${file("${path.module}/task.json")}"


}

resource "aws_ecs_task_definition" "test_nodejs_task" {
  family = "nodejs"
  container_definitions = "${data.template_file.task-json.rendered}"
  network_mode = "host"
}

resource "aws_ecs_service" "node_js" {
  name = "nodejs_service"
  cluster = "${aws_ecs_cluster.testcluster.id}"
  task_definition = "${aws_ecs_task_definition.test_nodejs_task.arn}"

  desired_count = 1

  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 0
}
