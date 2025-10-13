#!/usr/bin/env bash
set -euo pipefail

# Односторонняя синхронизация: Obsidian -> этот проект (docs/)
# Используется rsync с удалением файлов, которых нет в источнике (чистое зеркало)
# Исключаются служебные и конфигурационные файлы; защищаем docs/assets и docs/_config.yml

SOURCE_DIR="/Users/aasamo28/Documents/Obsidian v1/Публичная база знаний"
TARGET_DIR="/Users/aasamo28/Documents/Github/knowledge-base/docs"

DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
fi

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "[Ошибка] Не найден источник: $SOURCE_DIR" >&2
  exit 1
fi
if [[ ! -d "$TARGET_DIR" ]]; then
  echo "[Ошибка] Не найдена цель: $TARGET_DIR" >&2
  exit 1
fi

RSYNC_EXCLUDES=(
  ".obsidian/"
  ".DS_Store"
  "*/.DS_Store"
  "*/.obsidian/"
  "**/.git/"
  "**/.trash/"
  "**/.history/"
  ".jekyll-cache/" # исключаем локальный кэш Jekyll в docs/.jekyll-cache
  "assets/"       # защита локальных ассетов Jekyll в docs/assets
  "_config.yml"    # защита Jekyll-конфига в docs/_config.yml
)

OPTS=( -avh --delete --prune-empty-dirs --human-readable --update )
if [[ $DRY_RUN -eq 1 ]]; then
  OPTS+=( -n )
fi

EXCLUDE_ARGS=()
for pat in "${RSYNC_EXCLUDES[@]}"; do
  EXCLUDE_ARGS+=( --exclude "$pat" )
done

rsync "${OPTS[@]}" "${EXCLUDE_ARGS[@]}" \
  --include "*/" \
  --include "*.md" \
  --include "*.png" --include "*.jpg" --include "*.jpeg" --include "*.gif" --include "*.webp" --include "*.svg" \
  --include "*.mp4" --include "*.mov" --include "*.mp3" --include "*.wav" \
  --include "*.pdf" \
  --exclude "*" \
  "$SOURCE_DIR/" "$TARGET_DIR/"

# Удаляем пустые директории, появившиеся после фильтрации
find "$TARGET_DIR" -type d -empty -delete || true

echo "[OK] Синхронизация завершена: $SOURCE_DIR -> $TARGET_DIR (dry-run=$DRY_RUN)"
