INSERT INTO `diodboficina`.`cliente` (`idCliente`,`Nome`)  VALUES (1,'Cliente da Oficina 01');
INSERT INTO `diodboficina`.`cliente` (`idCliente`,`Nome`)  VALUES (2,'Cliente da Oficina 02');
INSERT INTO `diodboficina`.`cliente` (`idCliente`,`Nome`)  VALUES (3,'Cliente da Oficina 03');
INSERT INTO `diodboficina`.`cliente` (`idCliente`,`Nome`)  VALUES (4,'Cliente da Oficina 04');

INSERT INTO `diodboficina`.`equipe` (`idEquipe`,`Nome`) VALUES (1, 'Equipe 01');
INSERT INTO `diodboficina`.`equipe` (`idEquipe`,`Nome`) VALUES (2, 'Equipe 02');
INSERT INTO `diodboficina`.`equipe` (`idEquipe`,`Nome`) VALUES (3, 'Equipe 03');
INSERT INTO `diodboficina`.`equipe` (`idEquipe`,`Nome`) VALUES (4, 'Equipe 04');

INSERT INTO `diodboficina`.`mecanico` (`idMecanico`,`Equipe_idEquipe`,`Nome`,`Endereco`,`Especialidade`)
VALUES (1,1, 'Mecanico 01','Endereço 01','Motor'),
	(2,1, 'Mecanico 02','Endereço 02','Motor'),
	(3,2, 'Mecanico 03','Endereço 03','Freios'),
	(4,2, 'Mecanico 04','Endereço 04','Freios'),
	(5,3, 'Mecanico 05','Endereço 05','Pneus'),
	(6,3, 'Mecanico 06','Endereço 06','Pneus');

INSERT INTO `diodboficina`.`peça` (`idPeça`,`Nome`,`Valor`) VALUES (1,'Peça 01',10.00);
INSERT INTO `diodboficina`.`peça` (`idPeça`,`Nome`,`Valor`) VALUES (2,'Peça 02',20.00);
INSERT INTO `diodboficina`.`peça` (`idPeça`,`Nome`,`Valor`) VALUES (3,'Peça 04',30.00);
INSERT INTO `diodboficina`.`peça` (`idPeça`,`Nome`,`Valor`) VALUES (4,'Peça 04',40.00);

INSERT INTO `diodboficina`.`servico` (`idServico`,`Nome`,`Valor`) VALUES (1,'Serviço 01',10.00);
INSERT INTO `diodboficina`.`servico` (`idServico`,`Nome`,`Valor`) VALUES (2,'Serviço 02',20.00);
INSERT INTO `diodboficina`.`servico` (`idServico`,`Nome`,`Valor`) VALUES (3,'Serviço 03',30.00);
INSERT INTO `diodboficina`.`servico` (`idServico`,`Nome`,`Valor`) VALUES (4,'Serviço 04',40.00);

INSERT INTO `diodboficina`.`veiculo` (`idVeiculo`,`Tipo`,`Cliente_idCliente`,`Marca`,`Modelo`) VALUES (1,'C',1,'Marca 01','Modelo 01');
INSERT INTO `diodboficina`.`veiculo` (`idVeiculo`,`Tipo`,`Cliente_idCliente`,`Marca`,`Modelo`) VALUES (2,'C',2,'Marca 02','Modelo 02');
INSERT INTO `diodboficina`.`veiculo` (`idVeiculo`,`Tipo`,`Cliente_idCliente`,`Marca`,`Modelo`) VALUES (3,'R',3,'Marca 03','Modelo 03');
INSERT INTO `diodboficina`.`veiculo` (`idVeiculo`,`Tipo`,`Cliente_idCliente`,`Marca`,`Modelo`) VALUES (4,'R',4,'Marca 04','Modelo 04');

INSERT INTO `diodboficina`.`ordem_servico`
(`idOrdem_servico`,`Cliente_idCliente`,`Veiculo_idVeiculo`,`Equipe_idEquipe`,`Numero`,`Data_emissao`,`Valor_total`,`Status`,`Tipo`,`Data_entrega`,`Data_autorizacao`)
VALUES (1,1,1,1,100,'2022-10-12', 300.00,1,'R','2022-10-14','2022-10-12'),
	(2,2,2,2,200,'2022-10-12', 400.00,1,'R','2022-10-12','2022-10-12'),
    (3,3,3,3,300,'2022-10-11', 400.00,1,'R','2022-10-12','2022-10-12'),
    (4,4,4,4,400,'2022-10-10', 400.00,1,'R','2022-10-11','2022-10-12');

INSERT INTO `diodboficina`.`ordem_servico_item` (`idOrdem_servico_item`,`Ordem_servico_idOrdem_servico`,`Servico_idServico`,`Peça_idPeça`) VALUES (1,1,1,1);
INSERT INTO `diodboficina`.`ordem_servico_item` (`idOrdem_servico_item`,`Ordem_servico_idOrdem_servico`,`Servico_idServico`,`Peça_idPeça`) VALUES (2,2,2,2);
INSERT INTO `diodboficina`.`ordem_servico_item` (`idOrdem_servico_item`,`Ordem_servico_idOrdem_servico`,`Servico_idServico`,`Peça_idPeça`) VALUES (3,3,3,3);
INSERT INTO `diodboficina`.`ordem_servico_item` (`idOrdem_servico_item`,`Ordem_servico_idOrdem_servico`,`Servico_idServico`,`Peça_idPeça`) VALUES (4,4,4,4);

/* Lista a quantidade de mecanicos por especialidade */
SELECT Especialidade, COUNT(*) TOTAL FROM `diodboficina`.`mecanico` GROUP BY Especialidade ORDER BY Especialidade;
SELECT Especialidade, COUNT(*) TOTAL FROM `diodboficina`.`mecanico` WHERE Especialidade = 'Freios';

/* Lista a quantidade de mecanicos por especialidade quando houver mais de um especialista */
SELECT Especialidade, COUNT(*) TOTAL FROM `diodboficina`.`mecanico` GROUP BY Especialidade HAVING COUNT(*) > 1 ORDER BY Especialidade;

/* Lista ordem de serviço com data de entrega dia 2022-10-12 e valores */
SELECT o.idOrdem_servico, c.Nome, v.Marca, v.Modelo, o.Valor_total, o.Valor_total * 0.10 AS Valor_Desconto, 
o.Valor_total - (o.Valor_total * 0.10) AS Valor_Cliente
FROM `diodboficina`.`ordem_servico` o
INNER JOIN `diodboficina`.`cliente` c ON c.idCliente = o.Cliente_idCliente
INNER JOIN `diodboficina`.`veiculo` v ON v.idVeiculo = o.Veiculo_idVeiculo
 WHERE o.Data_entrega =  '2022-10-12'
 ORDER BY Nome;
 
 
 








