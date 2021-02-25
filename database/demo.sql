drop database demo;
create database  inventario ;
USE `inventario` ;
-- -----------------------------------------------------
-- Table `demo`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `menu` (
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
CREATE TABLE IF NOT EXISTS `roles` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `demo`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `fullname` VARCHAR(100) NOT NULL,
  `idrol` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `users_ibfk_1`
    FOREIGN KEY (`idrol`)
    REFERENCES `roles` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
INSERT INTO `inventario`.`users` (`id`, `username`, `password`, `fullname`, `idrol`) VALUES ('1', 'Admin', 'admin1234', 'Josue Tobar', '1');
INSERT INTO `inventario`.`users` (`id`, `username`, `password`, `fullname`, `idrol`) VALUES ('2', 'Estandar', 'estandar1234', 'Usuario Estandar', '2');

-- -----------------------------------------------------
-- Table `demo`.`LINKS`
-- -----------------------------------------------------
CREATE TABLE links (
  id INT(11) NOT NULL,
  title VARCHAR(150) NOT NULL,
  url VARCHAR(255) NOT NULL,
  description TEXT,
  user_id INT(11),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id)
);

-- -----------------------------------------------------
-- Table `demo`.`submenu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `submenu` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `url` VARCHAR(45) NULL,
  `logo` VARCHAR(45) NULL,
  `idMenu` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_submenu_menu1`
    FOREIGN KEY (`idMenu`)
    REFERENCES `menu` (`id`)
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
    REFERENCES `submenu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `demo` ;
-- INSERT MENU
	INSERT INTO `menu` (`nombre`, `estado`, `logo`) VALUES ('MATERIA PRIMA', 'A', 'logo');
	INSERT INTO `menu` (`nombre`, `estado`, `logo`) VALUES ('INVENTARIO GENERAL', 'A', 'LOGO');
    INSERT INTO `menu` (`nombre`, `estado`, `logo`) VALUES ('REPORTES', 'A', 'LOGO');

SELECT * FROM MENU;

-- INSERT SUB MENU

-- INSERT ROL 
INSERT INTO `roles` (`ID`, `NOMBRE`) VALUES ('1', 'ADMIN');
INSERT INTO `roles` (`ID`, `NOMBRE`) VALUES ('2', 'ESTANDAR');

INSERT INTO `rol_menu` (`idrol_menu`, `roles_ID`, `idsubmenu`) VALUES ('2', '2', '3');
INSERT INTO `rol_menu` (`idrol_menu`, `roles_ID`, `idsubmenu`) VALUES ('3', '1', '2');

-- Select sub menu segun rol 
	SELECT  *  FROM submenu s, rol_menu r 
	where s.id = r.idsubmenu and r.roles_ID = 2;






