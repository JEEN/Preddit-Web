CREATE DATABASE IF NOT EXISTS preddit DEFAULT CHARACTER SET 'utf8';

CREATE USER 'preddit'@'%' IDENTIFIED BY 'preddit';
GRANT ALL ON preddit.* TO 'preddit'@'%';
CREATE USER 'preddit'@'localhost' IDENTIFIED BY 'preddit';
GRANT ALL ON preddit.* TO 'preddit'@'localhost';

FLUSH PRIVILEGES;

CREATE TABLE IF NOT EXISTS preddit.entry (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    title         VARCHAR(255) NOT NULL DEFAULT '',
    description   MEDIUMTEXT NOT NULL DEFAULT '',
    author_id     INT UNSIGNED NOT NULL DEFAULT 0,
    created_at    DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
    updated_at    DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
    PRIMARY KEY(id)
) ENGINE=InnoDB DEFAULT CHARACTER SET 'utf8';

