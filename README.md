# Tierion_autoupdate_with_cron

サーバ内のcronを使用し、自動で更新があったかどうかを確認して、更新があった場合にのみ自動でノードの更新をするスクリプトです。

Ubuntu 16.04 で動作確認済。

### 設定方法
  
1. 使用前にauto_updateという名前のディレクトリをサーバのユーザーディレクトリ直下に作ります。  
  
  
2. ダウンロードしたauto_update.shを、今作成したauto_updateディレクトリに保存します。または、新たにauto_update.shというスクリプトを作って保存します。  
  
  
3. 使用前にauto_update.sh内の[username]は自身の使用しているユーザー名に置き換えてください。  
  
  
4. また、auto_update.sh内の12行目のchainpoint-nodeディレクトリへcdで移動する部分を自身の状況に合わせて適宜ご変更ください。  
  
  
5. auto_update.shをauto_updateディレクトリに作成または保存したら、以下のコマンドでオーナーと実行権限を変更します。  
  
  
    `sudo chmod 700 /home/[username]/auto_update/auto_update.sh`  
  
    `sudo chown root:root /home/[username]/auto_update/auto_update.sh`
  

6. 次に、下記のコマンドでcrontabを開きます。初めてだとどのエディタを使うか聞かれるので、好きなものを選びます。  
  

    `sudo crontab -u root -e`

7. 最後に下記を、開いたcrontabファイルの最下段に追記します。下記の設定では、1日2回、0時と12時に更新があったかを確認して、更新があった場合はauto_update.shが実行されてmake upgradeをかけます。  
  

    `0 0 * * * /bin/bash /home/[username]/auto_update/auto_update.sh`

    `0 12 * * * /bin/bash /home/[username]/auto_update/auto_update.sh`
  
  
   以上で設定は終了です。

   更新を行ったかどうかは/home/[username]/auto_update/auto_update.logに書き込まれます。

    `less /home/[username]/auto_update/auto_update.log`

   上記コマンドなどで更新されたか否かをご確認ください。

