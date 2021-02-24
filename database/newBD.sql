-- -----------------------------------------------------
-- Schema inventario
-- -----------------------------------------------------
CREATE DATABASE `inventario` ;
USE `inventario` ;

-- -----------------------------------------------------
-- Table `inventario`.`roles`
-- -----------------------------------------------------
CREATE TABLE `inventario`.`roles` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `inventario`.`users`
-- -----------------------------------------------------
CREATE TABLE `inventario`.`users` (
  `idUSUARIO` INT(11) NOT NULL AUTO_INCREMENT,
  `fullname` VARCHAR(100) NULL DEFAULT NULL,
  `username` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(450) NULL DEFAULT NULL,
  `Idroles` INT(11) NOT NULL,
  PRIMARY KEY (`idUSUARIO`),
  CONSTRAINT `fk_USUARIO_roles1`
    FOREIGN KEY (`Idroles`)
    REFERENCES `inventario`.`roles` (`ID`)
    );
-- -----------------------------------------------------
-- Table `inventario`.`producto`
-- -----------------------------------------------------
CREATE TABLE `inventario`.`producto` (
  `idPRODUCTO` INT(11) NOT NULL AUTO_INCREMENT,
  `CODIGO` VARCHAR(450) NULL DEFAULT NULL,
  `NOMBRE` VARCHAR(450) NULL DEFAULT NULL,
  `IMG` VARCHAR(450) NULL DEFAULT NULL,
  `CALIDAD` VARCHAR(450) NULL DEFAULT NULL,
  `COLOR` VARCHAR(450) NULL DEFAULT NULL,
  `ORIGEN` VARCHAR(450) NULL DEFAULT NULL,
  `TEXTURA` VARCHAR(450) NULL DEFAULT NULL,
  `LOTE` VARCHAR(450) NULL DEFAULT NULL,
  `COMENTARIOS` TEXT NULL,
  `ESTADO` VARCHAR(45) NULL DEFAULT NULL,
  `MARCA` VARCHAR(450) NULL DEFAULT NULL,
  `EMPAQUE` VARCHAR(450) NULL DEFAULT NULL,
  `DESCRIPCION` TEXT NULL,
  `TIPOUNIDAD` VARCHAR(45) NULL,
  `STOKMINIMO` INT(11) NULL DEFAULT NULL,
  `FCHINGRESO` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `FCHUPDATE` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `PESONETO` DECIMAL(11,2) NULL,
  `PESOBRUTO` DECIMAL(11,2) NULL,
  `IDUSUARIO` INT(11),
  PRIMARY KEY (`idPRODUCTO`), 
  constraint foreign key (IDUSUARIO) REFERENCES users (idUSUARIO)
  );
-- -----------------------------------------------------
-- Table `inventario`.`ubicacion`
-- -----------------------------------------------------
CREATE TABLE `inventario`.`ubicacion` (
  `idUBICACION` INT(11) NOT NULL AUTO_INCREMENT,
  `TIPO` VARCHAR(45) NULL DEFAULT NULL,
  `ESTADO` VARCHAR(45) NULL DEFAULT NULL,
  `DESCRIPCION` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idUBICACION`));

-- -----------------------------------------------------
-- Table `inventario`.`caja`
-- -----------------------------------------------------
CREATE TABLE `inventario`.`caja` (
  `idCAJA` INT(11) NOT NULL AUTO_INCREMENT,
  `PESONETO` DECIMAL(11,2) NULL DEFAULT NULL,
  `PESOBRUTO` DECIMAL(11,2) NULL DEFAULT NULL,
  `CANTIDAD` VARCHAR(45) NULL DEFAULT NULL,
  `idPRODUCTO` INT(11) NOT NULL,
  `idUBICACION` INT(11) NOT NULL,
  PRIMARY KEY (`idCAJA`),
  CONSTRAINT `fk_CAJA_PRODUCTO1`
    FOREIGN KEY (`idPRODUCTO`)
    REFERENCES `inventario`.`producto` (`idPRODUCTO`),
  CONSTRAINT `fk_DETALLEU_UBICACION1`
    FOREIGN KEY (`idUBICACION`)
    REFERENCES `inventario`.`ubicacion` (`idUBICACION`)
	);


-- -----------------------------------------------------
-- Table `inventario`.`historica`
-- -----------------------------------------------------
CREATE TABLE `inventario`.`historica` (
  `idHISTORIACA` INT(11) NOT NULL AUTO_INCREMENT,
  `TRANSACCION` VARCHAR(45) NULL DEFAULT NULL,
  `FCHTRANSACCION` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `CANTIDAD` DECIMAL(11,2) NULL DEFAULT NULL,
  `DESTINATARIO` VARCHAR(450) NULL DEFAULT NULL,
  `DESCRIPCION` MEDIUMTEXT NULL DEFAULT NULL,
  `ENTRADAS` INT(11) NULL DEFAULT NULL,
  `SALIDAS` INT(11) NULL DEFAULT NULL,
  `idPRODUCTO` INT(11) NOT NULL,
  `idUSUARIO` INT(11) NOT NULL,
  PRIMARY KEY (`idHISTORIACA`),
  CONSTRAINT `fk_HISTORIACA_PRODUCTO1` FOREIGN KEY (`idPRODUCTO`)
    REFERENCES `inventario`.`producto` (`idPRODUCTO`),
  CONSTRAINT `fk_HISTORIACA_USUARIO1`
    FOREIGN KEY (`idUSUARIO`)
    REFERENCES `inventario`.`users` (`idUSUARIO`)
    );


-- -----------------------------------------------------
-- Table `inventario`.`images`
-- -----------------------------------------------------
CREATE Table `inventario`.`IMAGES` (
  `idMAGES` INT(11) NOT NULL auto_increment,
  `TIPO` VARCHAR(45) NULL DEFAULT NULL,
  `URL` VARCHAR(45) NULL DEFAULT NULL,
  `idPRODUCTO` INT(11) NOT NULL,
  PRIMARY KEY (`idMAGES`),
  CONSTRAINT `fk_DOCUMENTO_PRODUCTO1`
    FOREIGN KEY (`idPRODUCTO`)
    REFERENCES `inventario`.`producto` (`idPRODUCTO`)
    );


-- -----------------------------------------------------
-- Table `inventario`.`menu`
-- -----------------------------------------------------
CREATE TABLE `inventario`.`menu` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `estado` VARCHAR(1) NULL DEFAULT NULL,
  `logo` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`));

-- -----------------------------------------------------
-- Table `inventario`.`submenu`
-- -----------------------------------------------------
CREATE TABLE `inventario`.`submenu` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `url` VARCHAR(45) NULL DEFAULT NULL,
  `logo` VARCHAR(45) NULL DEFAULT NULL,
  `idMenu` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_submenu_menu1`
    FOREIGN KEY (`idMenu`)
    REFERENCES `inventario`.`menu` (`id`));

-- -----------------------------------------------------
-- Table `inventario`.`rol_menu`
-- -----------------------------------------------------
CREATE TABLE `inventario`.`rol_menu` (
  `idrol_menu` INT(11) NOT NULL AUTO_INCREMENT,
  `Idroles` INT(11) NOT NULL,
  `idsubmenu` INT(11) NOT NULL,
  PRIMARY KEY (`idrol_menu`),
  CONSTRAINT `fk_rol_menu_roles1`
    FOREIGN KEY (`Idroles`)
    REFERENCES `inventario`.`roles` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rol_menu_submenu1`
    FOREIGN KEY (`idsubmenu`)
    REFERENCES `inventario`.`submenu` (`id`));


-- -----------------------------------------------------
-- Table `inventario`.`sessions`
-- -----------------------------------------------------
CREATE TABLE `inventario`.`sessions` (
  `session_id` VARCHAR(128) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin' NOT NULL,
  `expires` INT(11) UNSIGNED NOT NULL,
  `data` MEDIUMTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_bin' NULL DEFAULT NULL,
  PRIMARY KEY (`session_id`));

INSERT INTO `inventario`.`roles` (`ID`, `NOMBRE`) VALUES ('1', 'Administrador');
INSERT INTO `inventario`.`roles` (`ID`, `NOMBRE`) VALUES ('2', 'Bodega General');
INSERT INTO `inventario`.`roles` (`ID`, `NOMBRE`) VALUES ('3', 'Bodega de Accesorios');
INSERT INTO `inventario`.`roles` (`ID`, `NOMBRE`) VALUES ('4', 'Inventario General');



-- -----------------------------------------------------
-- Vista de producto
-- -----------------------------------------------------

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `vproductos` AS
    SELECT 
        `p`.`idPRODUCTO` AS `idPRODUCTO`,
        `p`.`IDUSUARIO` AS `IDUSUARIO`,
        CONCAT('../uploads/', `p`.`IMG`) AS `IMG`,
        `p`.`NOMBRE` AS `NOMBRE`,
        `p`.`CODIGO` AS `CODIGO`,
        `p`.`STOKMINIMO` AS `STOKMINIMO`,
        `p`.`TIPOUNIDAD` AS `TIPOUNIDAD`,
        `p`.`DESCRIPCION` AS `DESCRIPCION`,
        SUM(`h`.`ENTRADAS`) AS `ENTRADAS`,
        SUM(`h`.`SALIDAS`) AS `SALIDAS`,
        SUM(`h`.`ENTRADAS`) - SUM(`h`.`SALIDAS`) AS `EXISTENCIA`
    FROM
        (`producto` `p`
        JOIN `historica` `h`)
    WHERE
        `p`.`idPRODUCTO` = `h`.`idPRODUCTO`
    GROUP BY `h`.`idPRODUCTO`;

-- -----------------------------------------------------
-- Vista Historial
-- -----------------------------------------------------
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `inventario`.`vhistorica` AS
    SELECT 
        `h`.`idHISTORIACA` AS `idHISTORIACA`,
        `p`.`NOMBRE` AS `NOMBRE`,
        `p`.`CODIGO` AS `CODIGO`,
        `h`.`TRANSACCION` AS `TRANSACCION`,
        CONCAT('../uploads/', `p`.`IMG`) AS `FOTO`,
        CONCAT(`h`.`FCHTRANSACCION`) AS `FCHTRANSACCION`,
        `h`.`DESTINATARIO` AS `DESTINATARIO`,
        `u`.`fullname` AS `USUARIO`,
        `p`.`TIPOUNIDAD` AS `TIPOUNIDAD`,
        `h`.`CANTIDAD` AS `CANTIDAD`,
        `h`.`DESCRIPCION` AS `DESCRIPCION`,
        `h`.`ENTRADAS` AS `ENTRADAS`,
        `h`.`SALIDAS` AS `SALIDAS`,
        `h`.`ENTRADAS` - `h`.`SALIDAS` AS `EXISTENCIA`,
        `p`.`STOKMINIMO` AS `STOKMINIMO`
    FROM
        ((`inventario`.`historica` `h`
        JOIN `inventario`.`producto` `p`)
        JOIN `inventario`.`users` `u`)
    WHERE
        `p`.`idPRODUCTO` = `h`.`idPRODUCTO`
            AND `p`.`IDUSUARIO` = `u`.`idUSUARIO