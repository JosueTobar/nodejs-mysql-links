drop database demo;
create database  demo ;
USE `demo` ;

-- -----------------------------------------------------
-- Table `demo`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`menu` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `estado` VARCHAR(1) NULL DEFAULT NULL,
  `logo` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `demo`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`roles` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `demo`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `fullname` VARCHAR(100) NOT NULL,
  `idrol` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `users_ibfk_1`
    FOREIGN KEY (`idrol`)
    REFERENCES `demo`.`roles` (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `demo`.`submenu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`submenu` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `url` VARCHAR(45) NULL,
  `logo` VARCHAR(45) NULL,
  `idMenu` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_submenu_menu1`
    FOREIGN KEY (`idMenu`)
    REFERENCES `demo`.`menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `demo`.`rol_menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `demo`.`rol_menu` (
  `idrol_menu` INT NOT NULL AUTO_INCREMENT,
  `roles_ID` INT(11) NOT NULL,
  `idsubmenu` INT NOT NULL,
  PRIMARY KEY (`idrol_menu`),
  CONSTRAINT `fk_rol_menu_roles1`
    FOREIGN KEY (`roles_ID`)
    REFERENCES `demo`.`roles` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rol_menu_submenu1`
    FOREIGN KEY (`idsubmenu`)
    REFERENCES `demo`.`submenu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `demo` ;
-- INSERT MENU
INSERT INTO `demo`.`menu` (`nombre`, `estado`, `logo`) VALUES ('mantenimiento', 'A', 'logo');
INSERT INTO `demo`.`menu` (`nombre`, `estado`, `logo`) VALUES ('reportes', 'A', 'LOGO');

SELECT * FROM MENU;

-- INSERT SUB MENU

-- INSERT ROL 
INSERT INTO `demo`.`roles` (`ID`, `NOMBRE`) VALUES ('1', 'ADMIN');
INSERT INTO `demo`.`roles` (`ID`, `NOMBRE`) VALUES ('2', 'ESTANDAR');

INSERT INTO `demo`.`rol_menu` (`idrol_menu`, `roles_ID`, `idsubmenu`) VALUES ('2', '2', '3');
INSERT INTO `demo`.`rol_menu` (`idrol_menu`, `roles_ID`, `idsubmenu`) VALUES ('3', '1', '2');

-- Select sub menu segun rol 
	SELECT  *  FROM submenu s, rol_menu r 
	where s.id = r.idsubmenu and r.roles_ID = 2;






