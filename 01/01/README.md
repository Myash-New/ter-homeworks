# Чек-лист готовности к домашнему заданию
![Terraform Version](https://github.com/Myash-New/ter-homeworks/blob/main/01/01/task01version.jpg)

# Задание 1
# 1.2
согласно этому .gitignore, допустимо сохранить личную, секретную информацию
```
# own secret vars store.
personal.auto.tfvars
```
# 1.3
<details>
  <summary>SECRET</summary>
  
```
"result": "zYd8FF67IrJ19dy6",
```

</details>

# 1.4
## Ошибки в синтаксисе файла main.tf.
Ошибка №1 строка 24
```
resource "docker_image" {
```
Верно
```
resource "docker_image" "nginx" {
```
Ошибка №2 строка 29
```
resource "docker_container" "1nginx" {
```
Верно
```
resource "docker_container" "nginx" {
```
Ошибка №3 строка 31
```
name  = "example_${random_password.random_string_FAKE.resulT}"
```
Верно
```
name  = "example_${random_password.random_string.result}"
```
# 1.5

![validate](https://github.com/Myash-New/ter-homeworks/blob/main/01/01/task01validate.jpg)

![docker_ps](https://github.com/Myash-New/ter-homeworks/blob/main/01/01/task01docker_ps.jpg)

# 1.6

![docker_ps_after_name_change](https://github.com/Myash-New/ter-homeworks/blob/main/01/01/task01docker_ps2.jpg)

## -auto-approve
Опасность использования -auto-approve
Ключ -auto-approve автоматически подтверждает выполнение действий, предложенных в плане Terraform, без ручной проверки. 
Что может привести к измениею/удалению критических ресурсов и тп.

Зачем нужен -auto-approve?
Может пригодится при тестах, может использоваться для ускорения развертывания, при повтороном использовании многократнопроверенного кода. 

# 1.7

<details>
  <summary>terraform.tfstate _before_destroy</summary>
  
```
{
  "version": 4,
  "terraform_version": "1.8.4",
  "serial": 29,
  "lineage": "04578dc8-38ba-36f0-acb9-38c09d74a358",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "docker_container",
      "name": "nginx",
      "provider": "provider[\"registry.terraform.io/kreuzwerker/docker\"]",
      "instances": [
        {
          "schema_version": 2,
          "attributes": {
            "attach": false,
            "bridge": "",
            "capabilities": [],
            "cgroupns_mode": null,
            "command": [
              "nginx",
              "-g",
              "daemon off;"
            ],
            "container_logs": null,
            "container_read_refresh_timeout_milliseconds": 15000,
            "cpu_set": "",
            "cpu_shares": 0,
            "destroy_grace_seconds": null,
            "devices": [],
            "dns": null,
            "dns_opts": null,
            "dns_search": null,
            "domainname": "",
            "entrypoint": [
              "/docker-entrypoint.sh"
            ],
            "env": [],
            "exit_code": null,
            "gpus": null,
            "group_add": null,
            "healthcheck": null,
            "host": [],
            "hostname": "0965aff6abb9",
            "id": "0965aff6abb96d524db1fc5395d527abbd09d867dc8d3092a2b1688a5b85dc30",
            "image": "sha256:53a18edff8091d5faff1e42b4d885bc5f0f897873b0b8f0ace236cd5930819b0",
            "init": false,
            "ipc_mode": "private",
            "labels": [],
            "log_driver": "json-file",
            "log_opts": null,
            "logs": false,
            "max_retry_count": 0,
            "memory": 0,
            "memory_swap": 0,
            "mounts": [],
            "must_run": true,
            "name": "hello_world",
            "network_data": [
              {
                "gateway": "172.17.0.1",
                "global_ipv6_address": "",
                "global_ipv6_prefix_length": 0,
                "ip_address": "172.17.0.2",
                "ip_prefix_length": 16,
                "ipv6_gateway": "",
                "mac_address": "9e:7e:ea:61:e6:01",
                "network_name": "bridge"
              }
            ],
            "network_mode": "bridge",
            "networks_advanced": [],
            "pid_mode": "",
            "ports": [
              {
                "external": 9090,
                "internal": 80,
                "ip": "0.0.0.0",
                "protocol": "tcp"
              }
            ],
            "privileged": false,
            "publish_all_ports": false,
            "read_only": false,
            "remove_volumes": true,
            "restart": "no",
            "rm": false,
            "runtime": "runc",
            "security_opts": [],
            "shm_size": 64,
            "start": true,
            "stdin_open": false,
            "stop_signal": "SIGQUIT",
            "stop_timeout": 0,
            "storage_opts": null,
            "sysctls": null,
            "tmpfs": null,
            "tty": false,
            "ulimit": [],
            "upload": [],
            "user": "",
            "userns_mode": "",
            "volumes": [],
            "wait": false,
            "wait_timeout": 60,
            "working_dir": ""
          },
          "sensitive_attributes": [],
          "private": "eyJzY2hlbWFfdmVyc2lvbiI6IjIifQ==",
          "dependencies": [
            "docker_image.nginx"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "docker_image",
      "name": "nginx",
      "provider": "provider[\"registry.terraform.io/kreuzwerker/docker\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "build": [],
            "force_remove": null,
            "id": "sha256:53a18edff8091d5faff1e42b4d885bc5f0f897873b0b8f0ace236cd5930819b0nginx:latest",
            "image_id": "sha256:53a18edff8091d5faff1e42b4d885bc5f0f897873b0b8f0ace236cd5930819b0",
            "keep_locally": true,
            "name": "nginx:latest",
            "platform": null,
            "pull_triggers": null,
            "repo_digest": "nginx@sha256:124b44bfc9ccd1f3cedf4b592d4d1e8bddb78b51ec2ed5056c52d3692baebc19",
            "triggers": null
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "random_password",
      "name": "random_string",
      "provider": "provider[\"registry.terraform.io/hashicorp/random\"]",
      "instances": [
        {
          "schema_version": 3,
          "attributes": {
            "bcrypt_hash": "$2a$10$4HEH7mGzGPhLxHRbRu/DMOkX99ckNtG9DnK/BtnnlA95rfZ35W5S2",
            "id": "none",
            "keepers": null,
            "length": 16,
            "lower": true,
            "min_lower": 1,
            "min_numeric": 1,
            "min_special": 0,
            "min_upper": 1,
            "number": true,
            "numeric": true,
            "override_special": null,
            "result": "C3YnpbQ0VB5z8erj",
            "special": false,
            "upper": true
          },
          "sensitive_attributes": [
            [
              {
                "type": "get_attr",
                "value": "result"
              }
            ],
            [
              {
                "type": "get_attr",
                "value": "bcrypt_hash"
              }
            ]
          ]
        }
      ]
    }
  ],
  "check_results": null
}
```

</details>
<details>
  <summary>terraform.tfstate _after_destroy</summary>
  
```
{
  "version": 4,
  "terraform_version": "1.8.4",
  "serial": 33,
  "lineage": "04578dc8-38ba-36f0-acb9-38c09d74a358",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```
</details>

# 1.8
## почему не был удалён docker-образ nginx:latest
В конфигурации ресурса docker_image указано свойство **keep_locally = true**. 
```
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}
```

**Документация**:
[keep_locally](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image.html#keep_locally-1) (Boolean) - If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.
