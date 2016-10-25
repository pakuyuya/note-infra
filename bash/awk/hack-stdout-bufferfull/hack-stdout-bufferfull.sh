#/bin/bash

# ファイルが 数万個のところでlsとかすると、「引数が長すぎます」とエラーが出る。
# awkを使って疑似回避。
# 非常に重たい。
ls -1d msgs/*/* | awk '{
  command = sprintf("grep ERROR %s/*/*", $1);
  system(command);
  close(command);
}'
