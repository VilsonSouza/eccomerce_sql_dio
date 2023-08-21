
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `oficina`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `IDCliente` int(11) NOT NULL,
  `Nome` varchar(50) DEFAULT NULL,
  `Telefone` varchar(15) DEFAULT NULL,
  `Endereço` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`IDCliente`, `Nome`, `Telefone`, `Endereço`) VALUES
(1, 'João Silva', '(11) 1234-5678', 'Rua A, 123'),
(2, 'Maria Souza', '(22) 9876-5432', 'Av. B, 456'),
(3, 'Carlos Santos', '(33) 4567-8901', 'Rua C, 789'),
(4, 'Ana Oliveira', '(44) 2345-6789', 'Rua D, 101'),
(5, 'Pedro Lima', '(55) 3456-7890', 'Av. E, 111');

-- --------------------------------------------------------

--
-- Estrutura para tabela `peça`
--

CREATE TABLE `peça` (
  `IDPeça` int(11) NOT NULL,
  `Descrição` varchar(100) DEFAULT NULL,
  `Preço` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `peça`
--

INSERT INTO `peça` (`IDPeça`, `Descrição`, `Preço`) VALUES
(201, 'Óleo de motor', 30.00),
(202, 'Filtro de óleo', 10.00),
(203, 'Pneu aro 15', 80.00),
(204, 'Correia dentada', 60.00),
(205, 'Pastilhas de freio', 40.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `serviço`
--

CREATE TABLE `serviço` (
  `IDServiço` int(11) NOT NULL,
  `Descrição` varchar(100) DEFAULT NULL,
  `Data` date DEFAULT NULL,
  `Valor` decimal(10,2) DEFAULT NULL,
  `IDVeículo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `serviço`
--

INSERT INTO `serviço` (`IDServiço`, `Descrição`, `Data`, `Valor`, `IDVeículo`) VALUES
(101, 'Troca de óleo', '2023-08-15', 100.00, 1),
(102, 'Revisão completa', '2023-07-25', 350.00, 3),
(103, 'Troca de pneus', '2023-08-10', 220.00, 2),
(104, 'Alinhamento e balanceamento', '2023-08-05', 80.00, 4),
(105, 'Substituição de correia dentada', '2023-07-28', 180.00, 5);

-- --------------------------------------------------------

--
-- Estrutura para tabela `serviço_peça`
--

CREATE TABLE `serviço_peça` (
  `IDServiço` int(11) NOT NULL,
  `IDPeça` int(11) NOT NULL,
  `Quantidade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `serviço_peça`
--

INSERT INTO `serviço_peça` (`IDServiço`, `IDPeça`, `Quantidade`) VALUES
(101, 201, 1),
(101, 202, 1),
(103, 203, 2),
(105, 204, 1),
(105, 205, 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `veículo`
--

CREATE TABLE `veículo` (
  `IDVeículo` int(11) NOT NULL,
  `IDCliente` int(11) DEFAULT NULL,
  `Marca` varchar(50) DEFAULT NULL,
  `Modelo` varchar(50) DEFAULT NULL,
  `Ano` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `veículo`
--

INSERT INTO `veículo` (`IDVeículo`, `IDCliente`, `Marca`, `Modelo`, `Ano`) VALUES
(1, 1, 'Ford', 'Fiesta', 2015),
(2, 1, 'Chevrolet', 'Onix', 2019),
(3, 2, 'Volkswagen', 'Gol', 2018),
(4, 3, 'Toyota', 'Corolla', 2020),
(5, 4, 'Honda', 'Civic', 2017);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`IDCliente`);

--
-- Índices de tabela `peça`
--
ALTER TABLE `peça`
  ADD PRIMARY KEY (`IDPeça`);

--
-- Índices de tabela `serviço`
--
ALTER TABLE `serviço`
  ADD PRIMARY KEY (`IDServiço`),
  ADD KEY `IDVeículo` (`IDVeículo`);

--
-- Índices de tabela `serviço_peça`
--
ALTER TABLE `serviço_peça`
  ADD PRIMARY KEY (`IDServiço`,`IDPeça`),
  ADD KEY `IDPeça` (`IDPeça`);

--
-- Índices de tabela `veículo`
--
ALTER TABLE `veículo`
  ADD PRIMARY KEY (`IDVeículo`),
  ADD KEY `IDCliente` (`IDCliente`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `serviço`
--
ALTER TABLE `serviço`
  ADD CONSTRAINT `serviço_ibfk_1` FOREIGN KEY (`IDVeículo`) REFERENCES `veículo` (`IDVeículo`);

--
-- Restrições para tabelas `serviço_peça`
--
ALTER TABLE `serviço_peça`
  ADD CONSTRAINT `serviço_peça_ibfk_1` FOREIGN KEY (`IDServiço`) REFERENCES `serviço` (`IDServiço`),
  ADD CONSTRAINT `serviço_peça_ibfk_2` FOREIGN KEY (`IDPeça`) REFERENCES `peça` (`IDPeça`);

--
-- Restrições para tabelas `veículo`
--
ALTER TABLE `veículo`
  ADD CONSTRAINT `veículo_ibfk_1` FOREIGN KEY (`IDCliente`) REFERENCES `cliente` (`IDCliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
