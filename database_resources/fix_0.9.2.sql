# Fixes to migrate from 0.9.1 or 0.9.2 to 0.9.3 database version
# (C) Miguel Chavez Gamboa 2009-2010 [GPL v2 or later]

use lemondb;

ALTER TABLE products       CHANGE groupElements groupElements varchar(1000) collate utf8_general_ci default '';
ALTER TABLE transactions   CHANGE specialOrders specialOrders varchar(1000) collate utf8_general_ci default '';
ALTER TABLE transactions   CHANGE itemslist itemslist         varchar(1000) collate utf8_general_ci default '';
ALTER TABLE special_orders CHANGE notes notes                 varchar(800)  collate utf8_general_ci default '';
ALTER TABLE special_orders CHANGE groupElements groupElements varchar(1000) collate utf8_general_ci default '';
ALTER TABLE balances       CHANGE transactions transactions   varchar(1000) collate utf8_general_ci NOT NULL;
ALTER TABLE balances       CHANGE cashflows cashflows         varchar(1000) collate utf8_general_ci default '';

ALTER TABLE clients       CHANGE name name                    varchar(255) collate utf8_general_ci default '';
ALTER TABLE users         CHANGE name name                    varchar(255) collate utf8_general_ci default '';
ALTER TABLE cashflow      CHANGE reason reason                varchar(255) collate utf8_general_ci default '';
ALTER TABLE providers     CHANGE name name                    varchar(255) collate utf8_general_ci default '';
ALTER TABLE stock_corrections CHANGE reason reason            varchar(255) collate utf8_general_ci NOT NULL;

ALTER TABLE offers DROP PRIMARY KEY, ADD PRIMARY KEY(`id`);

CREATE OR REPLACE VIEW `v_transS` AS
select
`transactions`.`id`,
`transactions`.`userid`,
`transactions`.`clientid`,
`transactions`.`date`,
`transactions`.`time`,
`transactions`.`state`,
`transactions`.`itemslist`,
`transactions`.`terminalnum`,
`transactions`.`itemcount`
from `transactions` WHERE (`transactions`.`state`= 1) AND (`transactions`.`type` = 1) AND (`transactions`.`itemcount` > 0)
order by `transactions`.`id`;

