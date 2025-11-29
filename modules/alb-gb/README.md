# Módulo ALB Blue-Green para Terraform

Este módulo implementa un Application Load Balancer (ALB) en AWS diseñado específicamente para despliegues blue-green. Crea el ALB, los target groups "blue" y "green", y configura el listener para balancear el tráfico entre ambos grupos según los pesos definidos. No es necesario definir listener rules adicionales, ya que todo el tráfico se distribuye automáticamente entre los dos entornos.

## Recursos que crea
- ALB (`aws_lb`)
- Target groups blue y green (`aws_lb_target_group`)
- Listener con balanceo por pesos (`aws_lb_listener`)

## Variables principales
- `name`: Nombre del ALB.
- `subnet_ids`: Lista de IDs de subredes donde desplegar el ALB.
- `security_group_ids`: Lista de IDs de security groups para el ALB.
- `internal`: Si el ALB es interno (`true`) o externo (`false`).
- `tags`: Tags adicionales para el ALB.
- `vpc_id`: ID de la VPC donde se crean los target groups.
- `blue_weight`: Peso para el target group blue (por defecto 50).
- `green_weight`: Peso para el target group green (por defecto 50).

## Outputs
- `alb_arn`: ARN del ALB.
- `alb_dns_name`: DNS del ALB.
- `blue_target_group_arn`: ARN del target group blue.
- `green_target_group_arn`: ARN del target group green.

## Ejemplo de uso
```hcl
module "alb_blue_green" {
  source             = "../../modules/alb"
  name               = "blue-green-alb"
  subnet_ids         = ["subnet-xxxx", "subnet-yyyy"]
  security_group_ids = ["sg-xxxx"]
  internal           = false
  vpc_id             = var.vpc_id
  blue_weight        = 80
  green_weight       = 20
  tags               = {
    Environment = "prod"
  }
}
```

## Consideraciones importantes
- **Listener rules**: No son necesarias para el balanceo blue-green puro. Todo el tráfico se distribuye entre los target groups según los pesos configurados.
- **Flexibilidad**: Puedes ajustar los pesos para dirigir más tráfico a uno u otro entorno según la estrategia de despliegue.
- **Target groups**: Los target groups se crean automáticamente y puedes asociarles instancias, ASGs, etc.
- **Seguridad**: Define correctamente los security groups para controlar el acceso al ALB.
- **Tags**: Los recursos se etiquetan automáticamente con el nombre y los tags adicionales proporcionados.

## Recomendaciones
- Usa los outputs del módulo para conectar otros recursos (ASG, EC2, etc.).
- Ajusta los pesos para gestionar el tráfico durante despliegues o pruebas.
- Mantén la consistencia en los nombres y tags para facilitar la gestión.

---
