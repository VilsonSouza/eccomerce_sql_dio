
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `ecommercedio`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `client`
--

CREATE TABLE `client` (
  `idClient` int(11) NOT NULL,
  `Fname` varchar(10) DEFAULT NULL,
  `Minit` char(3) DEFAULT NULL,
  `Lname` varchar(20) DEFAULT NULL,
  `CPF` char(11) NOT NULL,
  `Address` varchar(30) DEFAULT NULL,
  `Type` enum('PF','PJ') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `client`
--

INSERT INTO `client` (`idClient`, `Fname`, `Minit`, `Lname`, `CPF`, `Address`, `Type`) VALUES
(1, 'João', 'A', 'Silva', '12345678901', 'Rua A', 'PF'),
(2, 'Empresa X', 'B', 'Comércio', '12345678902', 'Avenida B', 'PJ'),
(3, 'Maria', 'C', 'Souza', '12345678903', 'Rua C', 'PF'),
(4, 'Empresa Y', 'D', 'Indústria', '12345678904', 'Avenida D', 'PJ'),
(5, 'Pedro', 'E', 'Oliveira', '12345678905', 'Rua E', 'PF');

-- --------------------------------------------------------

--
-- Estrutura para tabela `orders`
--

CREATE TABLE `orders` (
  `idOrder` int(11) NOT NULL,
  `idOrderClient` int(11) DEFAULT NULL,
  `OrderStatus` enum('Cancelado','Confirmado','Em Processamento') NOT NULL DEFAULT 'Em Processamento',
  `OrderDescription` varchar(255) DEFAULT NULL,
  `SendValue` float DEFAULT 10,
  `PaymentCash` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `orders`
--

INSERT INTO `orders` (`idOrder`, `idOrderClient`, `OrderStatus`, `OrderDescription`, `SendValue`, `PaymentCash`) VALUES
(1, 1, 'Confirmado', 'Pedido 1', 100, 0),
(2, 2, 'Em Processamento', 'Pedido 2', 50, 1),
(3, 3, 'Em Processamento', 'Pedido 3', 200, 0),
(4, 4, 'Confirmado', 'Pedido 4', 300, 0),
(5, 5, 'Cancelado', 'Pedido 5', 25, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `payments`
--

CREATE TABLE `payments` (
  `idClient` int(11) DEFAULT NULL,
  `idPayment` int(11) NOT NULL,
  `TypePayment` enum('Boleto','Cartão de Débito','Cartão de Crédito','Pix') DEFAULT NULL,
  `LimitAvailable` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `payments`
--

INSERT INTO `payments` (`idClient`, `idPayment`, `TypePayment`, `LimitAvailable`) VALUES
(1, 1, 'Cartão de Crédito', 5000),
(2, 2, 'Boleto', 3000),
(3, 3, 'Pix', 1000),
(4, 4, 'Cartão de Débito', 2500),
(5, 5, 'Cartão de Crédito', 1500);

-- --------------------------------------------------------

--
-- Estrutura para tabela `product`
--

CREATE TABLE `product` (
  `idProduct` int(11) NOT NULL,
  `Pname` varchar(10) NOT NULL,
  `ClassificationKids` tinyint(1) DEFAULT 0,
  `Category` enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') NOT NULL,
  `Avaliacao` float DEFAULT 0,
  `Size` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `product`
--

INSERT INTO `product` (`idProduct`, `Pname`, `ClassificationKids`, `Category`, `Avaliacao`, `Size`) VALUES
(1, 'Celular', 0, 'Eletrônico', 4.5, '10x5'),
(2, 'Camiseta', 1, 'Vestimenta', 3.8, 'M'),
(3, 'Boneca', 1, 'Brinquedos', 4.2, 'Pequeno'),
(4, 'Arroz', 0, 'Alimentos', 4.7, '1kg'),
(5, 'Sofá', 0, 'Móveis', 4, '2 lugares');

-- --------------------------------------------------------

--
-- Estrutura para tabela `productorder`
--

CREATE TABLE `productorder` (
  `idPOproduct` int(11) NOT NULL,
  `idPOorder` int(11) NOT NULL,
  `POQuantity` int(11) DEFAULT 1,
  `POStatus` enum('Disponivel','Sem Estoque') DEFAULT 'Disponivel'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `productorder`
--

INSERT INTO `productorder` (`idPOproduct`, `idPOorder`, `POQuantity`, `POStatus`) VALUES
(1, 1, 2, 'Disponivel'),
(2, 2, 1, 'Disponivel'),
(3, 3, 3, 'Sem Estoque'),
(4, 4, 4, 'Disponivel'),
(5, 5, 1, 'Sem Estoque');

-- --------------------------------------------------------

--
-- Estrutura para tabela `productseller`
--

CREATE TABLE `productseller` (
  `idPseller` int(11) NOT NULL,
  `idProduct` int(11) DEFAULT NULL,
  `ProdQuantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `productseller`
--

INSERT INTO `productseller` (`idPseller`, `idProduct`, `ProdQuantity`) VALUES
(1, 1, 5),
(2, 2, 10),
(3, 3, 15),
(4, 4, 20),
(5, 5, 8);

-- --------------------------------------------------------

--
-- Estrutura para tabela `productstorage`
--

CREATE TABLE `productstorage` (
  `idProdStorage` int(11) NOT NULL,
  `StorageLocation` varchar(255) DEFAULT NULL,
  `Quantity` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `productstorage`
--

INSERT INTO `productstorage` (`idProdStorage`, `StorageLocation`, `Quantity`) VALUES
(1, 'Prateleira 1', 50),
(2, 'Prateleira 2', 30),
(3, 'Estoque 1', 100),
(4, 'Estoque 2', 75),
(5, 'Depósito', 200);

-- --------------------------------------------------------

--
-- Estrutura para tabela `seller`
--

CREATE TABLE `seller` (
  `idSeller` int(11) NOT NULL,
  `SocialName` varchar(255) NOT NULL,
  `AbstlName` varchar(255) NOT NULL,
  `CNPJ` char(15) NOT NULL,
  `CPF` char(9) NOT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `Contact` char(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `seller`
--

INSERT INTO `seller` (`idSeller`, `SocialName`, `AbstlName`, `CNPJ`, `CPF`, `Location`, `Contact`) VALUES
(1, 'Vendedor X', 'VendX', '12345678901', '123456789', 'Loja 1', '66666666666'),
(2, 'Vendedor Y', 'VendY', '23456789012', '234567890', 'Loja 2', '77777777777'),
(3, 'Vendedor Z', 'VendZ', '34567890123', '345678901', 'Loja 3', '88888888888'),
(4, 'Vendedor W', 'VendW', '45678901234', '456789012', 'Loja 4', '99999999999'),
(5, 'Vendedor K', 'VendK', '56789012345', '567890123', 'Loja 5', '10101010101');

-- --------------------------------------------------------

--
-- Estrutura para tabela `storagelocation`
--

CREATE TABLE `storagelocation` (
  `idLproduct` int(11) NOT NULL,
  `idLstorage` int(11) NOT NULL,
  `Location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `supplier`
--

CREATE TABLE `supplier` (
  `idSupplier` int(11) NOT NULL,
  `SocialName` varchar(255) NOT NULL,
  `CNPJ` char(15) NOT NULL,
  `Contact` char(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `supplier`
--

INSERT INTO `supplier` (`idSupplier`, `SocialName`, `CNPJ`, `Contact`) VALUES
(1, 'Fornecedor A', '12345678901', '11111111111'),
(2, 'Fornecedor B', '23456789012', '22222222222'),
(3, 'Fornecedor C', '34567890123', '33333333333'),
(4, 'Fornecedor D', '45678901234', '44444444444'),
(5, 'Fornecedor E', '56789012345', '55555555555');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`idClient`),
  ADD UNIQUE KEY `uniqur_cpf_client` (`CPF`);

--
-- Índices de tabela `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`idOrder`),
  ADD KEY `fk_orders_client` (`idOrderClient`);

--
-- Índices de tabela `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`idPayment`),
  ADD KEY `idClient` (`idClient`);

--
-- Índices de tabela `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`idProduct`);

--
-- Índices de tabela `productorder`
--
ALTER TABLE `productorder`
  ADD PRIMARY KEY (`idPOproduct`,`idPOorder`),
  ADD KEY `idPOorder` (`idPOorder`);

--
-- Índices de tabela `productseller`
--
ALTER TABLE `productseller`
  ADD PRIMARY KEY (`idPseller`),
  ADD KEY `idProduct` (`idProduct`);

--
-- Índices de tabela `productstorage`
--
ALTER TABLE `productstorage`
  ADD PRIMARY KEY (`idProdStorage`);

--
-- Índices de tabela `seller`
--
ALTER TABLE `seller`
  ADD PRIMARY KEY (`idSeller`),
  ADD UNIQUE KEY `unique_cnpj_seller` (`CNPJ`),
  ADD UNIQUE KEY `unique_cpf_seller` (`CPF`);

--
-- Índices de tabela `storagelocation`
--
ALTER TABLE `storagelocation`
  ADD PRIMARY KEY (`idLproduct`,`idLstorage`),
  ADD KEY `idLstorage` (`idLstorage`);

--
-- Índices de tabela `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`idSupplier`),
  ADD UNIQUE KEY `unique_supplier` (`CNPJ`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `client`
--
ALTER TABLE `client`
  MODIFY `idClient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `orders`
--
ALTER TABLE `orders`
  MODIFY `idOrder` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `product`
--
ALTER TABLE `product`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `productstorage`
--
ALTER TABLE `productstorage`
  MODIFY `idProdStorage` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `seller`
--
ALTER TABLE `seller`
  MODIFY `idSeller` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `supplier`
--
ALTER TABLE `supplier`
  MODIFY `idSupplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_client` FOREIGN KEY (`idOrderClient`) REFERENCES `client` (`idClient`);

--
-- Restrições para tabelas `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`idClient`) REFERENCES `client` (`idClient`);

--
-- Restrições para tabelas `productorder`
--
ALTER TABLE `productorder`
  ADD CONSTRAINT `productorder_ibfk_1` FOREIGN KEY (`idPOproduct`) REFERENCES `seller` (`idSeller`),
  ADD CONSTRAINT `productorder_ibfk_2` FOREIGN KEY (`idPOorder`) REFERENCES `orders` (`idOrder`);

--
-- Restrições para tabelas `productseller`
--
ALTER TABLE `productseller`
  ADD CONSTRAINT `productseller_ibfk_1` FOREIGN KEY (`idPseller`) REFERENCES `seller` (`idSeller`),
  ADD CONSTRAINT `productseller_ibfk_2` FOREIGN KEY (`idProduct`) REFERENCES `product` (`idProduct`);

--
-- Restrições para tabelas `storagelocation`
--
ALTER TABLE `storagelocation`
  ADD CONSTRAINT `storagelocation_ibfk_1` FOREIGN KEY (`idLproduct`) REFERENCES `product` (`idProduct`),
  ADD CONSTRAINT `storagelocation_ibfk_2` FOREIGN KEY (`idLstorage`) REFERENCES `productstorage` (`idProdStorage`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
