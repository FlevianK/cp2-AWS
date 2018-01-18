resource "aws_autoscaling_group" "cp2-scaling" {
  lifecycle { create_before_destroy = true }
  vpc_zone_identifier = ["${var.public_subnet_id}"]
  name = "cp2_scaling-${var.cp2_lc_name}"
  max_size = "${var.scaling_max}"
  min_size = "${var.scaling_min}"
  wait_for_elb_capacity = false
  force_delete = true
  launch_configuration = "${var.cp2_lc_id}"
  load_balancers = ["${var.cp2_elb_name}"]
  tag {
    key = "Name"
    value = "${var.env_name}_scaling"
    propagate_at_launch = "true"
  }
}

#Scale Up Policy and Alarm
resource "aws_autoscaling_policy" "scale_up" {
  name = "${var.env_name}_scaling_scale_up"
  scaling_adjustment = 2
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.cp2_scaling.name}"
}
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name = "${var.env_name}-high-scaling-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "70"
  insufficient_data_actions = []
  dimensions {
      AutoScalingGroupName = "${aws_autoscaling_group.cp2_scaling.name}"
  }
  alarm_description = "EC2 CPU Utilization"
  alarm_actions = ["${aws_autoscaling_policy.scale_up.arn}"]
}

#Scale Down Policy and Alarm

resource "aws_autoscaling_policy" "scale_down" {
  name = "${var.env_name}_scaling_scale_down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 600
  autoscaling_group_name = "${aws_autoscaling_group.cp2_scaling.name}"
}

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name = "${var.env_name}-low-scaling-cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = "6"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "40"
  insufficient_data_actions = []
  dimensions {
      AutoScalingGroupName = "${aws_autoscaling_group.cp2_scaling.name}"
  }
  alarm_description = "EC2 CPU Utilization"
  alarm_actions = ["${aws_autoscaling_policy.scale_down.arn}"]
}