#!/bin/bash
# Запуск Jekyll сервера для локальной разработки

echo "🚀 Запуск Jekyll сервера..."
cd "$(dirname "$0")"
bundle exec jekyll serve --source docs --livereload

