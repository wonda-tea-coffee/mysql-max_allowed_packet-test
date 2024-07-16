value = 'a' * ARGV[0].to_i

sql = <<~SQL
  set @@global.net_buffer_length=1024;
  set @@global.max_allowed_packet=1024;
  connect;
  select @@session.max_allowed_packet, @@session.net_buffer_length;

  drop database if exists work;
  create database work;
  use work;

  CREATE TABLE `posts` (
    `comment` text COLLATE utf8mb4_bin
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

  INSERT INTO `posts` (`comment`) VALUES ('#{value}');

  SELECT COUNT(*) FROM `posts`;
SQL

puts sql
