CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `vhistorica` AS
    SELECT 
        `h`.`idHISTORIACA` AS `idHISTORIACA`,
        `u`.`idUSUARIO` AS `IDUSUARIO`,
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
        ((`historica` `h`
        JOIN `producto` `p`)
        JOIN `users` `u`)
    WHERE
        `p`.`idPRODUCTO` = `h`.`idPRODUCTO`
            AND `p`.`IDUSUARIO` = `u`.`idUSUARIO`