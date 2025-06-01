### Prerequisites
- Terraform installed.
- AWS cli access

This repo deploys a secure, self-hosted development stack using:

- **Gitea** (self-hosted Git)
- **Grafana** (dashboards)
- **Authelia** (SSO gateway)
- **NGINX** (reverse proxy with HTTPS)
- **Docker Compose**
- **Terraform** (to provision EC2)
- **S3 backend for Terraform state**

```bash
This is the directory structure.

├── Readme.md
├── authelia
│   ├── configuration.yml
│   └── users.yml
├── docker-compose.yaml
├── ec2.tf
|── setup.sh
└── nginx
    ├── certs
    │   ├── local.crt
    │   ├── local.csr
    │   ├── local.key
    │   └── san.ext
    └── nginx.conf
```
### Terraform
- this has terraform cod eto create a ec2 and run the setup.sh.
- setup.sh will clone the repo with the config to run this. So make sure your code is pushed in some repo.
- nginx is being used as Reverseproxy.

### Create user in Gitea
docker exec -u git -it gitea /app/gitea/gitea admin user create \
  --username admin \
  --password changeme123 \
  --email admin@localdomain.com \
  --admin



