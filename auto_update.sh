#!/bin/bash

#空のdiff.txtを作成。

: > /home/[username]/auto_update/diff.txt


#chainpoint-nodeディレクトリに移動。
#chainpoint-nodeディレクトリがユーザーディレクトリ直下ではなく他の場所にある人は適宜変更してください。
#どこでノードを動かしているのかわからない場合はchainpoint-nodeディレクトリの中でpwdをして、それを下記のcd以降にコピペしてください。

cd  /home/[username]/chainpoint-node


#更新があったか(githubにあるコードと自分のサーバ内にあるコードの差分)をdiff.txtに保存。

git fetch
git diff origin/master >> /home/[username]/auto_update/diff.txt


#差分がなければdiff.txtは空のまま。差分があればdiff.txtになんらかの記載が追記されている。
#これをwc -cしてDIFFCHECKという変数に入れる。

DIFF=/home/[username]/auto_update/diff.txt
DIFFCHECK=`cat $DIFF | wc -c`


#DIFFCHECKが0であれば何もせず、時刻と"There is no new update"という記述がauto_update.logに追記される。
#DIFFCHECKが0でなければmake upgradeが実行され、時刻と"Update was done"という記述がauto_update.logに追記される。

if [ $DIFFCHECK -eq 0 ] ; then
  echo `date` "There is no new update" >> /home/[username]/auto_update/auto_update.log
else
  make upgrade
  echo `date` "Update was done" >> /home/[username]/auto_update/auto_update.log
fi