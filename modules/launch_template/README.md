# Módulo Launch Template para Terraform

Este módulo permite crear un Launch Template de EC2 en AWS, parametrizando la AMI, tipo de instancia, security groups, clave SSH, user data y tags. Es ideal para usarse junto con Auto Scaling Groups (ASG) y arquitecturas modulares.

## Recursos que crea
- Launch Template (`aws_launch_template`)

## Variables principales
- `name`: Nombre del Launch Template.
- `image_id`: ID de la AMI para las instancias EC2.
- `instance_type`: Tipo de instancia EC2.
- `security_group_ids`: Lista de IDs de security groups para la instancia.
- `key_name`: Nombre de la clave SSH (opcional).
- `user_data`: Script de inicialización (opcional).
- `tags`: Tags adicionales para el Launch Template (opcional).

## Outputs
- `launch_template_id`: ID del Launch Template.
- `launch_template_name`: Nombre del Launch Template.

## Ejemplo de uso
```hcl
module "launch_template" {
  source              = "../../modules/launch_template"
  name                = "blue-template"
  image_id            = "ami-xxxxxxxx"
  instance_type       = "t3.micro"
  security_group_ids  = ["sg-xxxx"]
  key_name            = "my-key"
  user_data           = file("./user_data.sh")
  tags = {
    Environment = "prod"
  }
}
```

## Consideraciones importantes
- El Launch Template puede usarse en uno o varios ASG.
- El parámetro `user_data` permite inicializar la instancia con scripts personalizados.
- Los tags ayudan a identificar y organizar el recurso en AWS.
- Asegúrate de que la AMI y los security groups sean válidos para tu entorno.

## Recomendaciones
- Usa los outputs del módulo para conectar el Launch Template con el ASG.
- Mantén la consistencia en los nombres y tags para facilitar la gestión.
- Revisa las opciones de configuración del Launch Template según las necesidades de tu aplicación.

---
