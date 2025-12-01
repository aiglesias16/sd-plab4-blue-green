# Módulo Internet Gateway para Terraform

Este módulo permite crear un Internet Gateway (IGW) en AWS y asociarlo a una VPC específica. Es útil para dar acceso a Internet a los recursos públicos dentro de la VPC.

## Recursos que crea
- Internet Gateway (`aws_internet_gateway`)

## Variables principales
- `vpc_id`: ID de la VPC donde se creará el Internet Gateway.
- `tags`: Tags adicionales para el Internet Gateway (opcional).

## Outputs
- `internet_gateway_id`: ID del Internet Gateway creado.

## Ejemplo de uso
```hcl
module "internet_gateway" {
  source  = "../../modules/internet_gateway"
  vpc_id  = module.vpc.vpc_id
  tags    = {
    Environment = "prod"
  }
}
```

## Consideraciones importantes
- El Internet Gateway no requiere Elastic IP (EIP).
- Es necesario asociar el IGW a la VPC para que las subredes públicas tengan acceso a Internet.
- Las rutas hacia el IGW deben definirse en las tablas de rutas públicas fuera de este módulo.
- Los tags permiten identificar y organizar el recurso en AWS.

## Recomendaciones
- Usa el output `internet_gateway_id` para asociar rutas en las tablas de rutas públicas.
- Mantén la consistencia en los tags para facilitar la gestión y el monitoreo.

---
