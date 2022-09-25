-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DIODBoficina
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DIODBoficina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DIODBoficina` DEFAULT CHARACTER SET utf8 ;
USE `DIODBoficina` ;

-- -----------------------------------------------------
-- Table `DIODBoficina`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBoficina`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBoficina`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBoficina`.`Veiculo` (
  `idVeiculo` INT NOT NULL,
  `Tipo` SMALLINT NULL COMMENT '(C)-conserto / (R)-revisão',
  `Cliente_idCliente` INT NOT NULL,
  `Marca` VARCHAR(45) NULL,
  `Modelo` VARCHAR(45) NULL,
  PRIMARY KEY (`idVeiculo`, `Cliente_idCliente`),
  INDEX `fk_Veiculo_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `DIODBoficina`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBoficina`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBoficina`.`Equipe` (
  `idEquipe` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idEquipe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBoficina`.`Ordem_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBoficina`.`Ordem_servico` (
  `idOrdem_servico` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  `Equipe_idEquipe` INT NOT NULL,
  `Numero` INT NULL,
  `Data_emissao` DATE NULL,
  `Valor_total` FLOAT NULL,
  `Status` SMALLINT NULL,
  `Tipo` SMALLINT NULL COMMENT '(C)-concerto / (R)-revisão\n',
  `Data_entrega` DATE NULL,
  `Data_autorizacao` DATE NULL,
  PRIMARY KEY (`idOrdem_servico`, `Cliente_idCliente`, `Veiculo_idVeiculo`, `Equipe_idEquipe`),
  INDEX `fk_Ordem_servico_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Ordem_servico_Veiculo1_idx` (`Veiculo_idVeiculo` ASC) VISIBLE,
  INDEX `fk_Ordem_servico_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_servico_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `DIODBoficina`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_servico_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `DIODBoficina`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_servico_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `DIODBoficina`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBoficina`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBoficina`.`Mecanico` (
  `idMecanico` INT NOT NULL,
  `Equipe_idEquipe` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Endereco` VARCHAR(45) NULL,
  `Especialidade` VARCHAR(45) NULL,
  PRIMARY KEY (`idMecanico`, `Equipe_idEquipe`),
  INDEX `fk_Mecanico_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanico_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `DIODBoficina`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBoficina`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBoficina`.`Servico` (
  `idServico` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Valor` FLOAT NULL,
  PRIMARY KEY (`idServico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBoficina`.`Peça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBoficina`.`Peça` (
  `idPeça` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Valor` FLOAT NULL,
  PRIMARY KEY (`idPeça`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBoficina`.`Ordem_servico_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBoficina`.`Ordem_servico_item` (
  `idOrdem_servico_item` INT NOT NULL,
  `Ordem_servico_idOrdem_servico` INT NOT NULL,
  `Servico_idServico` INT NOT NULL,
  `Peça_idPeça` INT NOT NULL,
  PRIMARY KEY (`idOrdem_servico_item`, `Ordem_servico_idOrdem_servico`, `Servico_idServico`, `Peça_idPeça`),
  INDEX `fk_Ordem_servico_item_Ordem_servico1_idx` (`Ordem_servico_idOrdem_servico` ASC) VISIBLE,
  INDEX `fk_Ordem_servico_item_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  INDEX `fk_Ordem_servico_item_Peça1_idx` (`Peça_idPeça` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_servico_item_Ordem_servico1`
    FOREIGN KEY (`Ordem_servico_idOrdem_servico`)
    REFERENCES `DIODBoficina`.`Ordem_servico` (`idOrdem_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_servico_item_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `DIODBoficina`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_servico_item_Peça1`
    FOREIGN KEY (`Peça_idPeça`)
    REFERENCES `DIODBoficina`.`Peça` (`idPeça`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
