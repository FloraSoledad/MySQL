-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema playground
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema playground
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `playground` DEFAULT CHARACTER SET utf8 ;
USE `playground` ;

-- -----------------------------------------------------
-- Table `playground`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`categorias` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`usuarios` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `contrasenia` VARCHAR(255) NOT NULL,
  `categoria_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_usuarios_categorias_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_categorias`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `playground`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`cursos` (
  `id` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` TEXT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_finalizacion` DATE NOT NULL,
  `cupo_maximo` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`unidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`unidades` (
  `id` INT NOT NULL,
  `titulo` TEXT NULL,
  `descripcion` VARCHAR(45) NULL,
  `cursos_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_unidades-cursos_idx` (`cursos_id` ASC) VISIBLE,
  CONSTRAINT `fk_unidades-cursos`
    FOREIGN KEY (`cursos_id`)
    REFERENCES `playground`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`cursos_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`cursos_usuarios` (
  `id` INT NOT NULL,
  `cursos_id` INT NULL,
  `usuarios_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuarios_cursos_idx` (`cursos_id` ASC) VISIBLE,
  INDEX `fk_cursos_usuarios_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_cursos_usuarios`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `playground`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_cursos`
    FOREIGN KEY (`cursos_id`)
    REFERENCES `playground`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`tipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`tipos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`clases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`clases` (
  `id` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `visible` TINYINT NOT NULL DEFAULT 0,
  `unidad_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clases_unidad_idx` (`unidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_clases_unidad`
    FOREIGN KEY (`unidad_id`)
    REFERENCES `playground`.`unidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground`.`bloques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`bloques` (
  `id` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `visible` TINYINT NULL DEFAULT 0,
  `contenido` VARCHAR(45) NULL,
  `tipo_id` INT NULL,
  `clase-id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bloques_tipos_idx` (`tipo_id` ASC) VISIBLE,
  INDEX `fk_bloques-clases_idx` (`clase-id` ASC) VISIBLE,
  CONSTRAINT `fk_bloques_tipos`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `playground`.`tipos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bloques-clases`
    FOREIGN KEY (`clase-id`)
    REFERENCES `playground`.`clases` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
