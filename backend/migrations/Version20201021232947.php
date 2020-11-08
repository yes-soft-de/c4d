<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20201021232947 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE user_entity (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(250) DEFAULT NULL, roles JSON NOT NULL, password VARCHAR(255) DEFAULT NULL, create_date DATE DEFAULT NULL, email VARCHAR(255) NOT NULL, UNIQUE INDEX UNIQ_6B7A5F55E7927C74 (email), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user_profile_entity (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, user_name VARCHAR(255) NOT NULL, location VARCHAR(255) DEFAULT NULL, story LONGTEXT DEFAULT NULL, image VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP TABLE user_entity');
        $this->addSql('DROP TABLE user_profile_entity');
    }
}
