-- MySQL DDL

-- Tabla Form
CREATE TABLE Form (
    Id INT PRIMARY KEY,
    NameForm VARCHAR(255),
    Description TEXT,
    Status BOOLEAN
);

-- Tabla Module
CREATE TABLE Module (
    Id INT PRIMARY KEY,
    NameModule VARCHAR(255),
    Status BOOLEAN
);

-- Tabla FormModule (tabla puente entre Form y Module)
CREATE TABLE FormModule (
    Id INT PRIMARY KEY,
    Status VARCHAR(100),
    IdForm INT,
    IdModule INT,
    CONSTRAINT FK_FormModule_Form FOREIGN KEY (IdForm) REFERENCES Form(Id),
    CONSTRAINT FK_FormModule_Module FOREIGN KEY (IdModule) REFERENCES Module(Id)
);

-- Tabla RolForm (tabla puente entre Rol y Form)
CREATE TABLE RolForm (
    Id INT PRIMARY KEY,
    -- Otras propiedades de RolForm
    IdForm INT,
    IdRol INT,
    CONSTRAINT FK_RolForm_Form FOREIGN KEY (IdForm) REFERENCES Form(Id)
    -- Se define la relación con Rol en FK_RolForm_Rol
);

-- Tabla User
CREATE TABLE UserTable (
    Id INT PRIMARY KEY,
    -- Otras propiedades de User
    IdPerson INT,   -- Para relación UserPerson
    IdInventory INT -- Para relación UserInventory, si se requiere
);

-- Tabla Rol
CREATE TABLE Rol (
    Id INT PRIMARY KEY
    -- Otras propiedades de Rol
);

-- Asociación UserRol (uno a uno)
ALTER TABLE UserTable
ADD COLUMN IdRol INT;
ALTER TABLE UserTable
ADD CONSTRAINT FK_User_Rol FOREIGN KEY (IdRol) REFERENCES Rol(Id);

-- Tabla Person
CREATE TABLE Person (
    Id INT PRIMARY KEY
    -- Otras propiedades de Person
);

-- Relación UserPerson (uno a uno)
ALTER TABLE UserTable
ADD CONSTRAINT FK_User_Person FOREIGN KEY (IdPerson) REFERENCES Person(Id);

-- Tabla Company
CREATE TABLE Company (
    Id INT PRIMARY KEY
    -- Otras propiedades de Company
);

-- Tabla Sede
CREATE TABLE Sede (
    Id INT PRIMARY KEY,
    IdCompany INT,
    -- Otras propiedades de Sede
    CONSTRAINT FK_Sede_Company FOREIGN KEY (IdCompany) REFERENCES Company(Id)
);

-- Tabla ImageItem
CREATE TABLE ImageItem (
    Id INT PRIMARY KEY
    -- Otras propiedades de ImageItem
);

-- Tabla Category
CREATE TABLE Category (
    Id INT PRIMARY KEY
    -- Otras propiedades de Category
);

-- Tabla Item
CREATE TABLE Item (
    Id INT PRIMARY KEY,
    -- Otras propiedades de Item
    IdImageItem INT,
    IdCategory INT,
    CONSTRAINT FK_Item_ImageItem FOREIGN KEY (IdImageItem) REFERENCES ImageItem(Id),
    CONSTRAINT FK_Item_Category FOREIGN KEY (IdCategory) REFERENCES Category(Id)
);

-- Tabla MovimientoItemInventory
CREATE TABLE MovimientoItemInventory (
    Id INT PRIMARY KEY,
    IdItem INT,
    IdInventory INT,
    IdMoviemiento INT,
    -- Otras propiedades de MovimientoItemInventory
    CONSTRAINT FK_MovInv_Item FOREIGN KEY (IdItem) REFERENCES Item(Id),
    CONSTRAINT FK_MovInv_Inventory FOREIGN KEY (IdInventory) REFERENCES Inventory(Id),
    CONSTRAINT FK_MovInv_Moviemiento FOREIGN KEY (IdMoviemiento) REFERENCES Moviemiento(Id)
);

-- Tabla Inventory
CREATE TABLE Inventory (
    Id INT PRIMARY KEY,
    -- Otras propiedades de Inventory
    IdUser INT, -- Para relación UserInventory
    CONSTRAINT FK_Inventory_User FOREIGN KEY (IdUser) REFERENCES UserTable(Id)
);

-- Tabla Moviemiento
CREATE TABLE Moviemiento (
    Id INT PRIMARY KEY
    -- Otras propiedades de Moviemiento
);

-- Relaciones adicionales

-- Asociación FormRolForm: Se asume que en RolForm se relaciona con Form
ALTER TABLE RolForm
ADD CONSTRAINT FK_RolForm_Rol FOREIGN KEY (IdRol) REFERENCES Rol(Id);

-- Tabla InventoryItem (tabla puente para Inventory e Item)
CREATE TABLE InventoryItem (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    IdInventory INT,
    IdItem INT,
    CONSTRAINT FK_InventoryItem_Inventory FOREIGN KEY (IdInventory) REFERENCES Inventory(Id),
    CONSTRAINT FK_InventoryItem_Item FOREIGN KEY (IdItem) REFERENCES Item(Id)
);
