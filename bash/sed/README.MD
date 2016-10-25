世にも恐ろしいbash黒魔術の一つ。

標準出力やファイルの内容を読み込み、オプションによっていろいろ置き換えたり抽出したりして標準出力に吐く。

```
使用法: sed [OPTION]... {script-only-if-no-other-script} [input-file]...

  -n, --quiet, --silent
                 パターン空間の自動出力を抑制する
  -e script, --expression=script
                 実行するコマンドとして script を追加する
  -f script-file, --file=script-file
                 実行するコマンドとして script-file の中身を追加する
  --follow-symlinks
                 処理の際にその場でシンボリックリンクを辿る
  -i[SUFFIX], --in-place[=SUFFIX]
                 edit files in place (makes backup if SUFFIX supplied)
  -l N, --line-length=N
                 `l' コマンドの行折り返しの長さを指定する
  --posix
                 全ての GNU 拡張を無効にする
  -r, --regexp-extended
                 スクリプトで拡張正規表現を使用する
  -s, --separate
                 複数のファイルを処理する際に連続した単一の長いストリーム
                 としてではなく、個別に取り扱う
  -u, --unbuffered
                 入力ファイルからデータをごく少量ずつ取り込み、頻繁に出力
                 バッファに出力 (flush) する
  -z, --null-data
                 separate lines by NUL characters
      --help     このヘルプを表示して終了する
      --version  バージョン情報を表示して終了する

-e、--expression、-f または --file オプションのいずれも与えられない場合、
最初のオプションでない引数が解釈する sed スクリプトとして扱われます。
全ての残りの引数は入力ファイル名として扱われます。入力ファイルが指定さ
れていない場合は、標準入力から読み込みます。
```

## -e オプション

-e オプションに続く引数の最初の文字によって、色々な処理を行う。

### sコマンド

正規表現置き換え。

```bash
# hogeをfooに置き換える
echo hogehoge | sed -e "s/hoge/foo/g"
```
置き換え後の表現に&を使うとマッチングした文字の全体置き換え、\1、\2と指定すると、()でくくったグループに置き換え。

```bash
# -e オプションだと制御文字の前に\が必要
echo 1x12x23x3 | sed -e 's/\(.\)x\(.\)/& => \1-\2,  /g'
# -E オプションは不要？
echo 1x12x23x3 | sed -E 's/(.)x(.)/& => \1-\2,  /g'
```

### dコマンド
あとでかく