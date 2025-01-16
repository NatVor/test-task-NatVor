repo-root/
├── terraform/                # Директорія для Terraform-коду
│   ├── main.tf               # Основний файл Terraform
│   ├── variables.tf          # Змінні для Terraform
│   ├── outputs.tf            # Вихідні значення Terraform
│   └── provider.tf           # Налаштування провайдера для Azure
│
├── ansible/                  # Директорія для Ansible playbooks
│   ├── playbooks/
│   │   ├── web-server.yml    # Playbook для веб-сервера (Nginx, Docker, Certbot)
│   │   ├── db-server.yml     # Playbook для бази даних (MySQL)
│   │   └── common.yml        # Спільні таски, якщо потрібно
│   ├── group_vars/
│   │   ├── all.yml           # Глобальні змінні Ansible
│   ├── inventory/
│   │   └── inventory.ini     # Інвентар-файл Ansible
│   └── roles/                # Ролі для структурованих завдань
│       ├── web/
│       │   ├── tasks/        # Завдання для веб-сервера
│       │   ├── templates/    # Шаблони конфігурацій Nginx
│       │   └── files/        # Додаткові файли (сертифікати, скрипти тощо)
│       └── db/
│           ├── tasks/        # Завдання для бази даних
│           ├── templates/    # Шаблони конфігурацій MySQL
│           └── files/        # SQL-дампи або початкові дані
│
├── web-app/                  # Директорія для веб-додатку
│   ├── index.html            # Статична веб-сторінка (для Nginx)
│   ├── Dockerfile            # Dockerfile для Nginx
│   └── certbot/              # Додаткові файли Certbot, якщо потрібно
│
├── flask-app/                # (Опціонально) Flask API-додаток
│   ├── app.py                # Код Python-додатку
│   ├── requirements.txt      # Залежності Python
│   └── Dockerfile            # Dockerfile для Flask
│
├── docker-compose.yml        # (Опціонально) Для локального тестування
│
├── README.md                 # Документація з інструкціями
└── .gitignore                # Ігнорування зайвих файлів (сертифікати, логи, тощо)
