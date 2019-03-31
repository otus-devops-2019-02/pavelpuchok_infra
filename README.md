# pavelpuchok_infra
pavelpuchok Infra repository

# Cloud Bastion
bastion_IP = 35.210.162.102
someinternalhost_IP = 10.132.0.5

Подключение к someinternalhost через bastion:
`ssh -J appuser@35.210.162.102 appuser@someinternalhost
`

Подключение к someinternalhost статическая конфигурация:
1. Конфигурируем ssh config (`~/.ssh/config`):
    ```
    Host bastion
        HostName 35.210.162.102
        User appuser
        IdentityFile ~/.ssh/otus_infra


    Host someinternalhost
        HostName someinternalhost
        User appuser
        IdentityFile ~/.ssh/otus_infra
        ProxyJump bastion
    ```
1. Устанавливаем alias (`~/.bashrc`)
    ```
    alias someinternalhost='ssh someinternalhost'
    alias bastion='ssh bastion'
    ```
1. `source ~/.bashrc`
1. Теперь можно подключаться через команды:
    * someinternalhost: `ssh someinternalhost` или `someinternalhost`
    * bastion: `ssh bastion` или `bastion`


# Cloud Test App
testapp_IP = 35.205.250.223
testapp_port = 9292

## Запуск VM вместе со startup script:
```
gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup_script.sh
  ```
## Создание firewall-rule через gcloud:
```gcloud compute firewall-rules create default-puma-server --allow tcp:9292```

