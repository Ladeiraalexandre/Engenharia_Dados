-- MySQL Script generated by MySQL Workbench
-- Thu Dec  9 22:36:15 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema viagemdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema viagemdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `viagemdb` DEFAULT CHARACTER SET utf8 ;
USE `viagemdb` ;

-- -----------------------------------------------------
-- Table `viagemdb`.`dim_motorista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viagemdb`.`dim_motorista` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nme_motorista` VARCHAR(50) NOT NULL,
  `dat_cadastro` TIMESTAMP NOT NULL,
  `num_cnh` VARCHAR(14) NOT NULL,
  `num_telefone` VARCHAR(15) NOT NULL,
  `dsc_email` VARCHAR(50) NOT NULL,
  `id_veiculo_atual` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `viagemdb`.`dim_veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viagemdb`.`dim_veiculo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dsc_marca` VARCHAR(20) NOT NULL,
  `dsc_modelo` VARCHAR(10) NOT NULL,
  `num_placa` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `viagemdb`.`dim_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viagemdb`.`dim_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nme_cliente` VARCHAR(50) NOT NULL,
  `dsc_cpf` VARCHAR(45) NOT NULL,
  `dat_cadastro` TIMESTAMP NOT NULL,
  `dsc_genero` ENUM('M', 'F') NULL,
  `num_telefone` VARCHAR(15) NOT NULL,
  `dat_nascimento` DATE NOT NULL,
  `dsc_email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `viagemdb`.`dim_pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viagemdb`.`dim_pagamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dsc_tipo_pagamento` CHAR(10) NOT NULL,
  `dsc_tipo_cartao` VARCHAR(20) NULL,
  `num_cartao` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `viagemdb`.`dim_localizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viagemdb`.`dim_localizacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `num_latitude` INT NOT NULL,
  `num_longitude` INT NOT NULL,
  `dsc_endereco` VARCHAR(45) NOT NULL,
  `num_cep` CHAR(9) NOT NULL,
  `sig_uf` CHAR(2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `viagemdb`.`dim_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viagemdb`.`dim_data` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dsc_dia` INT NOT NULL,
  `dsc_mes` INT NOT NULL,
  `dsc_ano` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `viagemdb`.`ft_viagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viagemdb`.`ft_viagem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dim_cliente_id` INT NOT NULL,
  `dim_motorista_id` INT NOT NULL,
  `dim_veiculo_id_veiculo` INT NOT NULL,
  `dim_pagamento_id_pagamento` INT NOT NULL,
  `dim_localizacao_origem_id` INT NOT NULL,
  `dim_localizacao_destino_id` INT NOT NULL,
  `dim_data_id` INT NOT NULL,
  `dat_solicitacao` DATETIME NOT NULL,
  `tmp_inicio_viagem` DATETIME NOT NULL,
  `tmp_termino_viagem` DATETIME NOT NULL,
  `tmp_duracao_viagem` TIME NOT NULL,
  `num_score_motorista` TINYINT(2) NOT NULL,
  `num_score_cliente` TINYINT(2) NOT NULL,
  `val_viagem` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_viagem_dim_cliente_idx` (`dim_cliente_id` ASC) INVISIBLE,
  INDEX `fk_viagem_dim_motorista_idx` (`dim_motorista_id` ASC) INVISIBLE,
  INDEX `fk_viagem_dim_veiculo_idx` (`dim_veiculo_id_veiculo` ASC) VISIBLE,
  INDEX `fk_viagem_dim_pagamento_idx` (`dim_pagamento_id_pagamento` ASC) VISIBLE,
  INDEX `fk_viagem_dim_localizacao_origem_idx` (`dim_localizacao_origem_id` ASC) INVISIBLE,
  INDEX `fk_ft_viagem_dim_data_idx` (`dim_data_id` ASC) VISIBLE,
  INDEX `fk_ft_viagem_dim_localizacao_destino_idx` (`dim_localizacao_destino_id` ASC) VISIBLE,
  CONSTRAINT `fk_viagem_dim_cliente`
    FOREIGN KEY (`dim_cliente_id`)
    REFERENCES `viagemdb`.`dim_cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viagem_dim_motorista`
    FOREIGN KEY (`dim_motorista_id`)
    REFERENCES `viagemdb`.`dim_motorista` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viagem_dim_veiculo`
    FOREIGN KEY (`dim_veiculo_id_veiculo`)
    REFERENCES `viagemdb`.`dim_veiculo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viagem_dim_pagamento`
    FOREIGN KEY (`dim_pagamento_id_pagamento`)
    REFERENCES `viagemdb`.`dim_pagamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viagem_dim_localizacaoOrigem`
    FOREIGN KEY (`dim_localizacao_origem_id`)
    REFERENCES `viagemdb`.`dim_localizacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ft_viagem_dim_data`
    FOREIGN KEY (`dim_data_id`)
    REFERENCES `viagemdb`.`dim_data` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ft_viagem_dim_localizacaoDestino`
    FOREIGN KEY (`dim_localizacao_destino_id`)
    REFERENCES `viagemdb`.`dim_localizacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
