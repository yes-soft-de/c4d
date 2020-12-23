<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20201222201752 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE accepted_order_entity (id INT AUTO_INCREMENT NOT NULL, order_id VARCHAR(255) NOT NULL, captain_id VARCHAR(255) NOT NULL, date DATETIME DEFAULT NULL, duration DATETIME DEFAULT NULL, state VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE branches_entity (id INT AUTO_INCREMENT NOT NULL, owner_id VARCHAR(255) NOT NULL, location JSON DEFAULT NULL, city VARCHAR(255) DEFAULT NULL, branche_name VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE captain_profile_entity (id INT AUTO_INCREMENT NOT NULL, captain_id VARCHAR(255) NOT NULL, name VARCHAR(255) NOT NULL, image VARCHAR(255) DEFAULT NULL, location VARCHAR(255) DEFAULT NULL, age INT DEFAULT NULL, car VARCHAR(255) DEFAULT NULL, driving_licence VARCHAR(255) DEFAULT NULL, salary DOUBLE PRECISION NOT NULL, status VARCHAR(100) NOT NULL, state VARCHAR(255) DEFAULT NULL, bounce DOUBLE PRECISION NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE order_entity (id INT AUTO_INCREMENT NOT NULL, owner_id VARCHAR(255) NOT NULL, source JSON DEFAULT NULL, destination JSON NOT NULL, date DATETIME DEFAULT NULL, note LONGTEXT DEFAULT NULL, payment VARCHAR(255) NOT NULL, recipient_name VARCHAR(255) DEFAULT NULL, recipient_phone VARCHAR(255) DEFAULT NULL, update_date DATETIME DEFAULT NULL, state VARCHAR(255) DEFAULT NULL, from_branch VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE package_entity (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(50) NOT NULL, cost VARCHAR(50) NOT NULL, note LONGTEXT DEFAULT NULL, car_count VARCHAR(50) NOT NULL, city VARCHAR(255) NOT NULL, order_count VARCHAR(50) NOT NULL, status VARCHAR(255) NOT NULL, branch VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE rating_entity (id INT AUTO_INCREMENT NOT NULL, owner_id VARCHAR(255) NOT NULL, captain_id VARCHAR(255) NOT NULL, type VARCHAR(100) NOT NULL, order_id VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE subscription_entity (id INT AUTO_INCREMENT NOT NULL, owner_id VARCHAR(255) NOT NULL, package_id INT NOT NULL, start_date DATETIME DEFAULT NULL, end_date DATETIME DEFAULT NULL, status VARCHAR(255) NOT NULL, note LONGTEXT DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user_entity (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(250) NOT NULL, roles JSON NOT NULL, password VARCHAR(255) DEFAULT NULL, create_date DATE DEFAULT NULL, email VARCHAR(255) DEFAULT NULL, UNIQUE INDEX UNIQ_6B7A5F55A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user_profile_entity (id INT AUTO_INCREMENT NOT NULL, user_id VARCHAR(255) NOT NULL, user_name VARCHAR(255) NOT NULL, story LONGTEXT DEFAULT NULL, image VARCHAR(255) DEFAULT NULL, branch VARCHAR(255) DEFAULT NULL, status VARCHAR(100) NOT NULL, free TINYINT(1) DEFAULT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP TABLE accepted_order_entity');
        $this->addSql('DROP TABLE branches_entity');
        $this->addSql('DROP TABLE captain_profile_entity');
        $this->addSql('DROP TABLE order_entity');
        $this->addSql('DROP TABLE package_entity');
        $this->addSql('DROP TABLE rating_entity');
        $this->addSql('DROP TABLE subscription_entity');
        $this->addSql('DROP TABLE user_entity');
        $this->addSql('DROP TABLE user_profile_entity');
    }
}
