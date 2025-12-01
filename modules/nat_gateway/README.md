# Módulo NAT Gateway para Terraform

Este módulo permite crear un NAT Gateway en AWS, junto con su Elastic IP (EIP), en una subnet pública específica. Es útil para dar acceso a Internet a las subredes privadas de la VPC, permitiendo que los recursos privados salgan a Internet sin ser accesibles desde fuera.

## Recursos que crea
- Elastic IP (`aws_eip`)
- NAT Gateway (`aws_nat_gateway`)

## Variables principales
- `subnet_id`: ID de la subnet pública donde se creará el NAT Gateway.
- `tags`: Tags adicionales para el NAT Gateway y el EIP (opcional).

## Outputs
- `nat_gateway_id`: ID del NAT Gateway creado.
- `nat_gateway_eip`: IP pública asociada al NAT Gateway.

## Ejemplo de uso
```hcl
module "nat_gateway" {
  source    = "../../modules/nat_gateway"
  subnet_id = module.vpc.public_subnet_ids["public-1"]
  tags      = {
    Environment = "prod"
  }
}
```

## Consideraciones importantes
- El NAT Gateway requiere una Elastic IP (EIP), que se crea automáticamente en el módulo.
- Debe desplegarse en una subnet pública para funcionar correctamente.
- Las rutas hacia el NAT Gateway deben definirse en las tablas de rutas privadas fuera de este módulo.
- Los tags permiten identificar y organizar los recursos en AWS.

## Recomendaciones
- Usa el output `nat_gateway_id` para asociar rutas en las tablas de rutas privadas.
- Mantén la consistencia en los tags para facilitar la gestión y el monitoreo.

---
