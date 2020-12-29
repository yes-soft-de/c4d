<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20201229161235 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE captain_profile_entity ADD uuid VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE order_entity ADD uuid VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE user_profile_entity ADD uuid VARCHAR(255) DEFAULT NULL');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE captain_profile_entity DROP uuid');
        $this->addSql('ALTER TABLE order_entity DROP uuid');
        $this->addSql('ALTER TABLE user_profile_entity DROP uuid');
    }
}
