# mysql max_allowed_packet test

## 実行方法

**mysqlの起動**

```sh
$ start.sh
```

**テスト**

```sh
# ex. ./run.sh 977
$ ./run.sh [buffer_size]
```

## 実行結果

```sh
$ ./run.sh 977
@@session.max_allowed_packet    @@session.net_buffer_length
1024    1024
COUNT(*)
1
$ ./run.sh 978
@@session.max_allowed_packet    @@session.net_buffer_length
1024    1024
ERROR 1153 (08S01) at line 14: Got a packet bigger than 'max_allowed_packet' bytes
```

## メモ

- 1024 byteがMAXで今回のSQLの場合、文字列の長さは 977 byteがMAX
  - INSERT INTO \`posts\` (\`comment\`) VALUES (': 41 byte
  - #{value}: 977 byte
  - ');: 3 byte
  - 上記で合計が1021 byte
  - 残りの3 byteはどこから来たのか
  - `max_allowed_packet` というネーミングだとMAXなので、`max_allowed_packet` と同じバイト数は許容される雰囲気を感じるが、何かが加算されたのち `>= max_allowed_packet` として比較されている
    - https://github.com/mysql/mysql-server/blob/mysql-8.0.38/sql-common/net_serv.cc#L216-L218
    - `net_realloc` の呼び出し元を探してみたものの、詳細はよく分かっていない

## 参考

- https://atsuizo.hatenadiary.jp/entry/2018/09/26/090000
  - net_buffer_length => max_allowed_packetの場合、net_buffer_lengthが1SQLの上限値になる
  - net_buffer_length < max_allowed_packetの場合、max_allowed_packetが1SQLの上限値になる
- https://yoku0825.blogspot.com/2018/09/maxallowedpacket.html
