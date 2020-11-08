<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20201108193021 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE package_entity (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(50) NOT NULL, cost VARCHAR(50) NOT NULL, note LONGTEXT DEFAULT NULL, car_count VARCHAR(50) NOT NULL, city VARCHAR(255) NOT NULL, order_count VARCHAR(50) NOT NULL, status VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user_entity (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(250) NOT NULL, roles JSON NOT NULL, password VARCHAR(255) DEFAULT NULL, create_date DATE DEFAULT NULL, email VARCHAR(255) DEFAULT NULL, UNIQUE INDEX UNIQ_6B7A5F55A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user_profile_entity (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, user_name VARCHAR(255) NOT NULL, location VARCHAR(255) DEFAULT NULL, story LONGTEXT DEFAULT NULL, image VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP TABLE package_entity');
        $this->addSql('DROP TABLE user_entity');
        $this->addSql('DROP TABLE user_profile_entity');
    }
}
