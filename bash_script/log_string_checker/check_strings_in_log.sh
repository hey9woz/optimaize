#!/bin/bash

# 定義ファイルとログファイルのパス
STRING_FILE="strings.txt"  # 確認したい文字列リストが含まれているファイル
LOG_FILE="application.log" # 確認対象のログファイル

# ファイルが存在するかどうかの確認
if [[ ! -f "$STRING_FILE" ]]; then
  echo "文字列リストファイル '$STRING_FILE' が見つかりません。"
  exit 1
fi

if [[ ! -f "$LOG_FILE" ]]; then
  echo "ログファイル '$LOG_FILE' が見つかりません。"
  exit 1
fi

# 結果表示用のフラグとメッセージの保存用配列
FOUND=false
MATCHES_LIST=()

# 文字列リストファイルを1行ずつ読み込み、ログファイル内で検索
echo "文字列の存在チェック一覧"
while IFS= read -r STRING; do
  STRING=$(echo "$STRING" | tr -d '\r' | xargs) # 余分なスペースや改行を除去
  # -F オプションで文字列として検索
  MATCHES=$(grep -Fn "$STRING" "$LOG_FILE")
  if [[ -n "$MATCHES" ]]; then
    echo "文字列 '$STRING' がログファイルに存在します。"
    MATCHES_LIST+=("$MATCHES")  # 該当行をリストに保存
    FOUND=true
  else
    echo "文字列 '$STRING' はログファイルに存在しません。"
  fi
done < "$STRING_FILE"

# すべての "存在します" メッセージを出力した後、該当行の内容を出力
if $FOUND; then
  echo -e "\n該当する行のメッセージ一覧:"
  for MATCH in "${MATCHES_LIST[@]}"; do
    echo "$MATCH"
  done
else
  echo "文字列リスト内の文字列はログファイルに存在しませんでした。"
fi

