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
    GROUP BY `h`.`idPRODUCTO`