# Автоматизация работы с Docker и Ansible 

# Описание 

   Проект включает три раздела:
  1. Работа со скриптом: Bash-скрипт, выполняющий HTTP-запросы к сервису https://httpstat.us, но я использовал такой же открытый источник https://httbin.org. Обрабатывающий ответы в зависимости от статус-кодов и логирующий результаты.
  2. Docker-образ на базе Ubuntu 22.04, содержащий Bash-скрипт, который выполняет HTTP-запросы.
  3. Автоматизация с помощью Ansible: Ansible playbook, который автоматизирует установку Docker на целевом хосте, а также проверку работоспособности скрипта внутри Docker-контейнера.

# Структура проекта
/yadro2
│
├── httscript.sh # Bash-скрипт для выполнения HTTP-запросов
│
├── Dockerfile # Dockerfile для создания контейнера
│
├── install_docker.yml # Playbook для установки Docker
│
├── none_auto_script.yml # Playbook для проверки работы скрипта в контейнере и проверка логов вручную
│
├── check_script_auto.yml # Playbook для автоматической проверки работы скрипта
│
           **Раздел 1**
    Перед запуском скрипта выдаём права 
sudo chmod +x httscript.sh
    Запускаем
./httscript.sh 
           **Раздел 2**
    Создаём Dockerfile на основе Ubuntu 22.04, и устанавливаем зависимости. Также копировался скрипт в контейнер и 
    чтобы запускался при запуске контейнера
    Собираем образ через
docker build -t httscript.sh .
    Запускаем
docker run --name httscript.sh httscript.sh:latest
    Проверяем также логи 
docker logs httscript.sh
					 **Раздел 3**
    Для автоматизации процесса создал Playbook's, которые устанавливают докер(install_docker.yml).  
    Запуск Playbook
ansile-playbook -i hosts.ini install_docker.yml
    Проверку работы скрипта в контейнере и вывода exit code (none_auto_script.yml).
ansile-playbook -i hosts.ini none_auto_script.yml
    Чтобы проверить логи вручную, они заданы в файле (script_docker.yml)
docker logs https-script-container 
    Автоматическая проверка логов и вывод exit code (script_docker.yml)
ansile-playbook -i hosts.ini script_docker.yml
        **Важно находиться в директории с файлами**
              #Интересный проект, всем спасибо#
