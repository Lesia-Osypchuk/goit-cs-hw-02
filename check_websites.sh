#!/bin/bash

# Список вебсайтів для перевірки
websites=(
    "https://google.com"
    "https://facebook.com"
    "https://twitter.com"
)

# Назва файлу логів
log_file="website_status.log"

# Очищення файлу логів перед записом нових результатів
> "$log_file"

# Цикл для перевірки кожного сайту
for site in "${websites[@]}"
do
    # Виконання HTTP GET запиту за допомогою curl і збереження HTTP статус-коду в змінну
    http_status=$(curl -s -o /dev/null -w "%{http_code}" "$site")

    # Перевірка HTTP статус-коду
    if [ "$http_status" -eq 200 ]; then
        echo "[${site}] is UP" | tee -a "$log_file"
    else
        echo "[${site}] is DOWN" | tee -a "$log_file"
    fi
done

# Вивід повідомлення про завершення роботи
echo "Results have been logged to $log_file"
