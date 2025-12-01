# Módulo Security Group para Terraform

Este módulo permite crear un Security Group en AWS de forma flexible, parametrizando las reglas de entrada (ingress), salida (egress), nombre, VPC y tags. Es ideal para arquitecturas modulares y reutilizables.

## Recursos que crea
- Security Group (`aws_security_group`)

## Variables principales
- `name`: Nombre del Security Group.
- `vpc_id`: ID de la VPC donde se creará el Security Group.
- `ingress`: Lista de reglas de entrada (puertos, protocolos, CIDRs, descripción).
- `egress`: Lista de reglas de salida (puertos, protocolos, CIDRs, descripción).
- `tags`: Tags adicionales para el Security Group (opcional).

## Outputs
- `security_group_id`: ID del Security Group creado.

## Ejemplo de uso
```hcl
module "sg" {
  source  = "../../modules/security_group"
  name    = "web-sg"
  vpc_id  = module.vpc.vpc_id
  ingress = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Permitir HTTP desde cualquier origen"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Permitir HTTPS desde cualquier origen"
    }
  ]
  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Permitir todo el tráfico de salida"
    }
  ]
  tags = {
    Environment = "prod"
  }
}
```

## Consideraciones importantes
- Puedes definir múltiples reglas de entrada y salida según tus necesidades.
- Los tags ayudan a identificar y organizar el recurso en AWS.
- Asegúrate de que las reglas sean seguras y adecuadas para tu aplicación.

## Recomendaciones
- Usa el output `security_group_id` para asociar el SG a instancias, ALB, ASG, etc.
- Mantén la consistencia en los nombres y tags para facilitar la gestión.
- Revisa y ajusta las reglas periódicamente para mantener la seguridad.

---
