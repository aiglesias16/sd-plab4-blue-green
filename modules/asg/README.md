# Módulo Auto Scaling Group (ASG) para Terraform

Este módulo permite crear un Auto Scaling Group (ASG) en AWS utilizando un Launch Template definido externamente. Es ideal para arquitecturas modulares y despliegues blue-green, permitiendo asociar el ASG a target groups, subredes y personalizar el escalado.

## Recursos que crea
- Auto Scaling Group (`aws_autoscaling_group`)

## Variables principales
- `name`: Nombre del Auto Scaling Group.
- `launch_template_id`: ID del Launch Template a usar.
- `launch_template_version`: Versión del Launch Template (por defecto `$Latest`).
- `vpc_zone_identifier`: Lista de IDs de subredes donde desplegar el ASG.
- `min_size`: Número mínimo de instancias (por defecto 1).
- `max_size`: Número máximo de instancias (por defecto 3).
- `desired_capacity`: Capacidad deseada de instancias (por defecto 1).
- `target_group_arns`: Lista de ARNs de target groups para el ASG (opcional).
- `tags`: Tags adicionales para el ASG (opcional).

## Outputs
- `asg_id`: ID del Auto Scaling Group.
- `asg_name`: Nombre del Auto Scaling Group.

## Ejemplo de uso
```hcl
module "asg" {
  source                  = "../../modules/asg"
  name                    = "blue-asg"
  launch_template_id      = aws_launch_template.blue.id
  launch_template_version = "$Latest"
  vpc_zone_identifier     = ["subnet-xxxx", "subnet-yyyy"]
  min_size                = 1
  max_size                = 3
  desired_capacity        = 2
  target_group_arns       = [module.alb.blue_target_group_arn]
  tags = {
    Environment = "prod"
  }
}
```

## Consideraciones importantes
- El Launch Template debe definirse fuera del módulo y pasar su ID y versión como variables.
- Puedes asociar el ASG a uno o varios target groups para integrarlo con un ALB.
- Los tags permiten identificar y organizar el recurso en AWS.
- Ajusta los parámetros de escalado según las necesidades de tu aplicación.

## Recomendaciones
- Usa los outputs del módulo para conectar otros recursos y monitorear el ASG.
- Mantén la consistencia en los nombres y tags para facilitar la gestión.
- Revisa las políticas de escalado y salud para optimizar el comportamiento del ASG.

---
