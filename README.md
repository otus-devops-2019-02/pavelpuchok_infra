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

