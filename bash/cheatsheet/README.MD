
### ls

`path`が指定するディレクトリ内の一覧を詳細付きで表示する

```bash
ls -l [<path>]
```

パスが示すディレクトリ自体をフルパスで表示する。

```bash
ls -d <path to directory>
```

出力一覧を改行表示する(`awk`で便利)

```bash
ls -1 [<path>]
```

### tar

圧縮（拡張子自動識別）`*.tar.gz`とか`*.tar`とか。

```bash
tar axf <path_to_ziped> <path_to_target>
```

展開（拡張子自動識別）。`*.tar.gz`は二重展開？

```bash
tar xf <path_to_ziped>
```

