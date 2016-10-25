#/bin/bash

# 基本１ 標準出力を空白文字区切りで分割し、後のスクリプトっぽい部分で一つ目なら$1、二つ目なら$2と書く。
ls foo | awk '{print $1 $2}'

# 基本２ 改行の分だけ動作を繰り返す
# ls -1 ... ファイルの一覧を改行区切りで標準出力
ls -1 foo | awk '{print $1}'

# 基本３ スクリプトっぽい部分"{ ... }"は bashではない。
# 独自（C言語っぽい？）文法。
ls -1 foo | awk '{
   print "----- " $1 " -----";

   # コマンドの字句を作成し、変数に保存
   command = sprintf("cat foo/%s", $1);
   
   # bash実行。
   buf = system(command);
   # ファイルディスクプリタを閉じる
   close(command);

   print "";
}'

# 基本４ 演算できる。なんだこの気持ち悪いインタプリタ
echo 1 | awk '{ print $1 + 1 * 2 }'

# 基本５ if もループもできる。
echo 1 | awk '{
  for (i=1; i<100; i++)
  {
    sum += i;
    if (sum >= 100) {
      break;
    }
  }
  print "i:" i " sum:" sum;
}'

 