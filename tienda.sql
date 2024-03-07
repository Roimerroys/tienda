-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tienda
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tienda
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tienda` DEFAULT CHARACTER SET utf8 ;
USE `tienda` ;

-- -----------------------------------------------------
-- Table `tienda`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`clientes` (
  `idclientes` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(60) NOT NULL,
  `apellidos` VARCHAR(60) NOT NULL,
  `direccion` CHAR(60) NOT NULL,
  PRIMARY KEY (`idclientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`telefonos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`telefonos` (
  `idtelefonos` INT NOT NULL AUTO_INCREMENT,
  `numero` CHAR(12) NOT NULL,
  `clientes_idclientes` INT NOT NULL,
  PRIMARY KEY (`idtelefonos`),
  INDEX `fk_telefonos_clientes_idx` (`clientes_idclientes` ASC) VISIBLE,
  CONSTRAINT `fk_telefonos_clientes`
    FOREIGN KEY (`clientes_idclientes`)
    REFERENCES `tienda`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`ventas` (
  `idventas` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(60) NOT NULL,
  `fecha` DATE NOT NULL,
  `subTotal` DECIMAL NOT NULL,
  `Iva` DECIMAL NOT NULL,
  `descuento` DECIMAL NOT NULL,
  `total` DECIMAL NOT NULL,
  `clientes_idclientes` INT NOT NULL,
  PRIMARY KEY (`idventas`),
  INDEX `fk_ventas_clientes1_idx` (`clientes_idclientes` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_clientes1`
    FOREIGN KEY (`clientes_idclientes`)
    REFERENCES `tienda`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`productos` (
  `idproductos` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(80) NOT NULL,
  `precioCompra` DECIMAL NOT NULL,
  `precioVenta` DECIMAL NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`idproductos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`ventas_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`ventas_has_productos` (
  `ventas_id` INT NOT NULL,
  `productos_id` INT NOT NULL,
  PRIMARY KEY (`ventas_id`, `productos_id`),
  INDEX `fk_ventas_has_productos_productos1_idx` (`productos_id` ASC) VISIBLE,
  INDEX `fk_ventas_has_productos_ventas1_idx` (`ventas_id` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_has_productos_ventas1`
    FOREIGN KEY (`ventas_id`)
    REFERENCES `tienda`.`ventas` (`idventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_has_productos_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `tienda`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`proveedores` (
  `idproveedores` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(80) NOT NULL,
  `direccion` CHAR(80) NOT NULL,
  `telefono` CHAR(40) NOT NULL,
  `correo` CHAR(120) NOT NULL,
  PRIMARY KEY (`idproveedores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tienda`.`proveedores_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tienda`.`proveedores_has_productos` (
  `proveedores_idproveedores` INT NOT NULL,
  `productos_idproductos` INT NOT NULL,
  PRIMARY KEY (`proveedores_idproveedores`, `productos_idproductos`),
  INDEX `fk_proveedores_has_productos_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  INDEX `fk_proveedores_has_productos_proveedores1_idx` (`proveedores_idproveedores` ASC) VISIBLE,
  CONSTRAINT `fk_proveedores_has_productos_proveedores1`
    FOREIGN KEY (`proveedores_idproveedores`)
    REFERENCES `tienda`.`proveedores` (`idproveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedores_has_productos_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `tienda`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
