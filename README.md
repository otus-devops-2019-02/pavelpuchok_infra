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


# Packer

`packer/ubuntu16.json` - параметризированный Ubuntu 16.04 образ VM, содержащий MongoDB и Ruby. Возможные параметризации описаны в `packer/variables.json.example`
`packer/immutable.json` - образ VM основанный на reddit-base image-family (`packer/ubuntu16.json`). В образ "запечены" reddit-app, его dependency, а так же systemd unit файл (`packer/files/redditapp.service`)

Запуск приложения происходит через запуск юнит systemd - `service redditapp start`

`config-scripts/create-reddit-vm.sh` - создает инстанс immutable образа, и firewall правило для открытия доступа к созданному инстансу

# Terraform

## Внесение изменений в инфраструкту извне TF (на примере добавления SSH key в meta data проекта):
Несмотря на то что внесенные изменения не отражены в конфигурации, TF обнаруживает их (посредством `terraform refresh`), но применение `terraform apply` приводит к их уничтожение и восстановлению состояния описаного в конфигурации TF. Таким образом, внося изменение в инфрастуктуру руками, мы получаем configuration drift и проблемы связанные с решением как отразить изменеия в конфигурации и надо ли их отражать.


## Использование count
Без использования count приходится дублировать конфигурации. Это приводит к сложной поддержке, что в свою очередь, влечет:
 * увеличение требуемого времени работы для внесением изменении
 * увеличение количества ошибок
 * увеличению количества мест для внесения изменении - что усложняет review изменении и их откатов
