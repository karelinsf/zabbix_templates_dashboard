# Домашнее задание к занятию «Система мониторинга Zabbix. Часть 2» (Карелин С.Ф.)

### Задание 1
Создайте свой шаблон, в котором будут элементы данных, мониторящие загрузку CPU и RAM хоста.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
2. В веб-интерфейсе Zabbix Servera в разделе Templates создайте новый шаблон
3. Создайте Item который будет собирать информацию об загрузке CPU в процентах
4. Создайте Item который будет собирать информацию об загрузке RAM в процентах

#### Решение 1
Скриншот страницы шаблона с названием «Задание 1»

![Задание 1](https://github.com/karelinsf/zabbix_templates_dashboard/blob/main/screen/zabbix-templates.png)

### Задание 2
Добавьте в Zabbix два хоста и задайте им имена <фамилия и инициалы-1> и <фамилия и инициалы-2>. Например: ivanovii-1 и ivanovii-2.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
2. Установите Zabbix Agent на 2 виртмашины, одной из них может быть ваш Zabbix Server
3. Добавьте Zabbix Server в список разрешенных серверов ваших Zabbix Agentов
4. Добавьте Zabbix Agentов в раздел Configuration > Hosts вашего Zabbix Servera
5. Прикрепите за каждым хостом шаблон Linux by Zabbix Agent
6. Проверьте что в разделе Latest Data начали появляться данные с добавленных агентов

#### Требования к результату
Результат данного задания вместе с заданием 3

### Задание 3
Привяжите созданный шаблон к двум хостам. Также привяжите к обоим хостам шаблон Linux by Zabbix Agent.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
2. Зайдите в настройки каждого хоста и в разделе Templates прикрепите к этому хосту ваш шаблон
3. Так же к каждому хосту привяжите шаблон Linux by Zabbix Agent
4. Проверьте что в раздел Latest Data начали поступать необходимые данные из вашего шаблона

#### Решение 2-3
Cкриншот страницы хостов, где будут видны привязки шаблонов с названиями «Задание 2-3». Хосты должны иметь зелёный статус подключения

![Задание 2-3](https://github.com/karelinsf/zabbix_templates_dashboard/blob/main/screen/zabbix-hosts.png)

### Задание 4
Создайте свой кастомный дашборд.

#### Процесс выполнения
1. Выполняя ДЗ сверяйтесь с процессом отражённым в записи лекции.
2. В разделе Dashboards создайте новый дашборд
3. Разместите на нём несколько графиков на ваше усмотрение.

#### Решение 4
Скриншот дашборда с названием «Задание 4»

![Задание 4](https://github.com/karelinsf/zabbix_templates_dashboard/blob/main/screen/zabbix-dashboard.png)

### Задание 5*
Создайте карту и расположите на ней два своих хоста.

#### Процесс выполнения
1. Настройте между хостами линк.
2. Привяжите к линку триггер, связанный с agent.ping одного из хостов, и установите индикатором сработавшего триггера красную пунктирную линию.
3. Выключите хост, чей триггер добавлен в линк. Дождитесь срабатывания триггера.

#### Решение 5
Скриншот карты, где видно, что триггер сработал, с названием «Задание 5» 

![Задание 5](https://github.com/karelinsf/zabbix_templates_dashboard/blob/main/screen/zabbix-map.png)

### Задание 6*
Создайте UserParameter на bash и прикрепите его к созданному вами ранее шаблону. Он должен вызывать скрипт, который:
- при получении 1 будет возвращать ваши ФИО,
- при получении 2 будет возвращать текущую дату.

#### Решение 6
Код скрипта

```bash
#!/bin/bash
PREFIX="${1:-NOT_SET}"
[[ "$PREFIX" = "NOT_SET" ]] && { echo "Required argument"; }
[[ "$PREFIX" = "1" ]] && { echo "KarelinSF"; }
[[ "$PREFIX" = "2" ]] && { echo "$(date +"%Y-%m-%d")"; }
```

Скриншот Latest data с результатом работы скрипта на bash, чтобы был виден результат работы скрипта при отправке в него 1 и 2
 
![Задание 6](https://github.com/karelinsf/zabbix_templates_dashboard/blob/main/screen/zabbix-bash.png)

### Задание 7*
Доработайте Python-скрипт из лекции, создайте для него UserParameter и прикрепите его к созданному вами ранее шаблону. 
Скрипт должен:
- при получении 1 возвращать ваши ФИО,
- при получении 2 возвращать текущую дату,
- делать всё, что делал скрипт из лекции.

### Решение 8
Код скрипта

```python
from datetime import date
import sys
import os
import re
if (sys.argv[1] == '1'):
  print('KarelinSF')
elif (sys.argv[1] == '2'):
  print(date.today())
elif (sys.argv[1] == '-ping'): # Если -ping
  result=os.popen("ping -c 1 " + sys.argv[2]).read() # Делаем пинг по заданному адресу
  result=re.findall(r"time=(.*) ms", result) # Выдёргиваем из результата время
  print(result[0]) # Выводим результат в консоль
elif (sys.argv[1] == '-simple_print'): # Если simple_print
  print(sys.argv[2]) # Выводим в консоль содержимое sys.arvg[2]
else: # Во всех остальных случаях
  print(f"unknown input: {sys.argv[1]}") # Выводим непонятый запрос в консоль
```

Скриншот Latest data с результатом работы скрипта на Python, чтобы были видны результаты работы скрипта при отправке в него 1, 2, -ping, а также -simple_print.*
 
![Задание 7](https://github.com/karelinsf/zabbix_templates_dashboard/blob/main/screen/zabbix-python.png)

### Задание 8*

Настройте автообнаружение и прикрепление к хостам созданного вами ранее шаблона.

#### Решение 8
Скриншот правила обнаружения

![Задание 8](https://github.com/karelinsf/zabbix_templates_dashboard/blob/main/screen/zabbix-discover-rules.png)

Скриншот страницы Discover, где видны оба хоста.*

![Задание 8](https://github.com/karelinsf/zabbix_templates_dashboard/blob/main/screen/zabbix-discover.png)

### Задание 9*

Доработайте скрипты Vagrant для 2-х агентов, чтобы они были готовы к автообнаружению сервером, а также имели на борту разработанные вами ранее параметры пользователей.

Файл Vagrantfile

```yaml

VAGRANTFILE_API_VERSION = "2"
#ENV['VAGRANT_SERVER_URL'] = 'http://vagrant.elab.pro'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #config.vm.provider = 'virtualbox'
  config.vm.boot_timeout = 800
  
  config.vm.define "zabbixserver" do | zs |
    zs.vm.box = 'ubuntu/jammy64'
    zs.vm.host_name = "zabbixserv"
    zs.vm.network "public_network", bridge: "enp7s0"
    zs.vm.network "private_network", ip: "192.168.56.10"
       zs.vm.provider :virtualbox do |res|

          res.customize ["modifyvm", :id, "--cpus", "2"]
          res.customize ["modifyvm", :id, "--memory", "2000"]
       end

  end

  config.vm.define "net1" do | n1 |
    n1.vm.box= 'ubuntu/jammy64'
    n1.vm.host_name = "net1"

    n1.vm.network "private_network", ip: "192.168.56.11"
    
      n1.vm.provider :virtualbox do |res|

        res.customize ["modifyvm", :id, "--cpus", "2"]
        res.customize ["modifyvm", :id, "--memory", "2000"]
      end

  end

  config.vm.define "net2" do | n2 |
    n2.vm.box= 'ubuntu/jammy64'
    n2.vm.host_name = "net1"

    n2.vm.network "private_network", ip: "192.168.56.12"
    
      n2.vm.provider :virtualbox do |res|

        res.customize ["modifyvm", :id, "--cpus", "2"]
        res.customize ["modifyvm", :id, "--memory", "2000"]
      end

  end

  config.vm.provision "ansible" do |ansible|
    ansible.groups = {
      "zabbix-server" => ["zabbixserver"],
      "zabbix-agent" => ["net1", "net2"],
    }
    ansible.playbook = "playbook.yml"
    ansible.compatibility_mode = "2.0"
  end

end
```

Файл для ansible
```yaml
# Install zabbix-server
- name: Add repository
  hosts: all
  become: yes
  tasks:

  - name: Download repo Zabbix
    shell: wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_6.0+ubuntu22.04_all.deb

  - name: install repo
    shell: dpkg -i zabbix-release_latest_6.0+ubuntu22.04_all.deb

  - name: Update apt packages
    become: true
    apt:
      update_cache: yes

- name: Install Zabbix-server
  hosts: zabbix-server
  become: yes
  tasks:

  - name: install postgresql
    apt:
      name:
        - postgresql
      state: present
  
  - name: install zabbix-server 
    apt:
      name:
        - zabbix-server-pgsql 
        - zabbix-frontend-php
        - php8.1-pgsql
        - zabbix-apache-conf
        - zabbix-sql-scripts
        - zabbix-agent
      state: present
  
  - name: create user psql
    shell: su - postgres -c 'psql --command "CREATE USER zabbix WITH PASSWORD '\'123456789\'';"' 
    ignore_errors: true

  - name: make owner
    shell: su - postgres -c 'psql --command "CREATE DATABASE zabbix OWNER zabbix;"'
    ignore_errors: true
    
  - name: extract archive
    shell: zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

  - name: set passwd DB
    shell:  sed -i 's/# DBPassword=/DBPassword=123456789/g' /etc/zabbix/zabbix_server.conf

  - name: retart and enable zabbix-server
    systemd:
      name: zabbix-server
      state: restarted
      enabled: yes

  - name: retart and enable apache2
    systemd:
      name: apache2
      state: restarted
      enabled: yes

  - name: zabbix-server status
    shell:  service zabbix-server status
    register: zabbixtxt
  
  - name: "Print the file content to a console"
    debug:
      msg: "{{ zabbixtxt.stdout }}"
 
  - name: rm package file
    shell: rm zabbix-release_latest_6.0+ubuntu22.04_all.deb*
 
 
- name: Install Zabbix-agent
  hosts: zabbix-agent
  become: yes
  tasks:

  - name: install zabbix-agent
    apt:
      name:
        - zabbix-agent
      state: present
  
  - name: set zabbix server IP
    shell:  sed -i 's/Server=127.0.0.1/Server=192.168.56.10/g' /etc/zabbix/zabbix_agentd.conf

  - name: copy UserParameter
    ansible.builtin.copy:
      src: UserParameter/
      dest: /etc/zabbix/zabbix_agentd.d/

  - name: retart and enable zabbix-agent
    systemd:
      name: zabbix-agent
      state: restarted
      enabled: yes

  - name: zabbix-agent status
    shell:  service zabbix-agent status
    register: zabbixtxt
  
  - name: "Print the file content to a console"
    debug:
      msg: "{{ zabbixtxt.stdout }}"
 
  - name: rm package file
    shell: rm zabbix-release_latest_6.0+ubuntu22.04_all.deb*  
```
