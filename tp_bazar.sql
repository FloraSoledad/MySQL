-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bazar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bazar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bazar` DEFAULT CHARACTER SET utf8 ;
USE `bazar` ;

-- -----------------------------------------------------
-- Table `bazar`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar`.`roles` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar`.`empleados` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` INT(8) NOT NULL,
  `sueldo` INT NOT NULL,
  `rol_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empleados_roles_idx` (`rol_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_roles`
    FOREIGN KEY (`rol_id`)
    REFERENCES `bazar`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar`.`categorias` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar`.`articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar`.`articulos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` INT NULL,
  `descripcion` TEXT NOT NULL,
  `stock` INT NOT NULL,
  `uso_profesional` TINYINT NULL DEFAULT 0,
  `categoria_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_articulos_categorias_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_articulos_categorias`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `bazar`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar`.`medios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar`.`medios` (
  `id` INT NOT NULL,
  `medio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar`.`ventas` (
  `id` INT NOT NULL,
  `total_compra` INT NULL,
  `cantidad` INT NULL,
  `comision` INT NULL,
  `medios_id` INT NULL,
  `articulos_id` INT NULL,
  `empleados_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ventas_empleados_idx` (`empleados_id` ASC) VISIBLE,
  INDEX `fk_ventas_articulos_idx` (`articulos_id` ASC) VISIBLE,
  INDEX `fk_ventas_medios_idx` (`medios_id` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_empleados`
    FOREIGN KEY (`empleados_id`)
    REFERENCES `bazar`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_articulos`
    FOREIGN KEY (`articulos_id`)
    REFERENCES `bazar`.`articulos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_medios`
    FOREIGN KEY (`medios_id`)
    REFERENCES `bazar`.`medios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
