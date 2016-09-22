-- create db
CREATE DATABASE nextcloud CHARACTER SET utf8 COLLATE utf8_unicode_ci;
-- create user and grant privileges
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextclouder' IDENTIFIED BY 'nextclouder_pass123pass' WITH GRANT OPTION;

FLUSH PRIVILEGES;
