#!/bin/sh
###############################################################################
#
# SAKURAから、自宅のルーター経由で、自宅LAN内部にansible-playbookを行う。
#
###############################################################################

TERM() {
  # ssh-agent の停止
  eval `ssh-agent -k`
}

# u:未設定の変数使用はエラーとする
# v:シェルの入力行を表示する
set -uv
# e:パイプやサブシェルで実行したコマンドが1つでもエラーになったら直ちにシェルを終了する
set -e

# ssh-agent の起動(公開鍵による認証の準備)
eval `ssh-agent`
trap 'TERM' 0 1 2 3 15 

set +e
ssh-add -l
set -e
# 秘密鍵を登録
ssh-add ~/.ssh/id_rsa_sakura4home
# 登録済みの鍵をリスト
ssh-add -l

# ansible.cfgに従い、ansible-playbook実行
ansible-playbook -i production -k site.yml 

# 登録済みのカギをすべて削除
ssh-add -d ~/.ssh/id_rsa_sakura4home


exit 0
