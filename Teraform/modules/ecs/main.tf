/*---------------------------------------------------
 modules/ecs/main.tf
---------------------------------------------------*/

/*resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  tags = var.tags
}


resource "aws_ecs_capacity_provider" "fargate_sp" {
  name = "FARGATE_SPOT_CP"

  auto_scaling_group_provider {
    auto_scaling_group_arn = var.fargate_asg_arn

    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 70
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 1000
    }

    managed_termination_protection = "ENABLED"
  }

  tags = var.tags
}
*/
