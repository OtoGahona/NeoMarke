-- SQL Server DDL

-- Tabla Form
CREATE TABLE Form (
    Id INT PRIMARY KEY,
    NameForm NVARCHAR(255),
    Description NVARCHAR(MAX),
    Status BIT
);

-- Tabla Module
CREATE TABLE Module (
    Id INT PRIMARY KEY,
    NameModule NVARCHAR(255),
    Status BIT
);

-- Tabla FormModule (tabla puente entre Form y Module)
CREATE TABLE FormModule (
    Id INT PRIMARY KEY,
    Status NVARCHAR(100),
    IdForm INT,
    IdModule INT,
    CONSTRAINT FK_FormModule_Form FOREIGN KEY (IdForm) REFERENCES Form(Id),
    CONSTRAINT FK_FormModule_Module FOREIGN KEY (IdModule) REFERENCES Module(Id)
);

-- Tabla RolForm (tabla puente entre Rol y Form)
CREATE TABLE RolForm (
    Id INT PRIMARY KEY,
    -- Otras propiedades de RolForm pueden definirse aquí
    IdForm INT,
    IdRol INT,
    CONSTRAINT FK_RolForm_Form FOREIGN KEY (IdForm) REFERENCES Form(Id)
    -- La relación con Rol se define en RolRolForm
);

-- Tabla User
CREATE TABLE [User] (
    Id INT PRIMARY KEY,
    -- Otras propiedades de User
    IdPerson INT,         -- Para relación UserPerson
    IdInventory INT       -- Para relación UserInventory (si aplica)
);

-- Tabla Rol
CREATE TABLE Rol (
    Id INT PRIMARY KEY
    -- Otras propiedades de Rol
);

-- Asociación UserRol (uno a uno)
ALTER TABLE [User]
ADD IdRol INT;
ALTER TABLE [User]
ADD CONSTRAINT FK_User_Rol FOREIGN KEY (IdRol) REFERENCES Rol(Id);

-- Tabla Person
CREATE TABLE Person (
    Id INT PRIMARY KEY
    -- Otras propiedades de Person
);

-- Relación UserPerson (uno a uno)
ALTER TABLE [User]
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
    IdImageItem INT,   -- Para relación ItemImageItem
    IdCategory INT,    -- Para relación ItemCategory
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
    CONSTRAINT FK_Inventory_User FOREIGN KEY (IdUser) REFERENCES [User](Id)
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

-- Asociación RolRolForm: Relación de Rol con RolForm ya cubierta con FK_RolForm_Rol

-- Asociación ItemMovimientoItemInventory ya implementada en MovimientoItemInventory
-- Asociación InventoryItem: Si se requiere modelar que un inventario tiene muchos items, se puede crear una tabla puente:
CREATE TABLE InventoryItem (
    Id INT PRIMARY KEY,
    IdInventory INT,
    IdItem INT,
    CONSTRAINT FK_InventoryItem_Inventory FOREIGN KEY (IdInventory) REFERENCES Inventory(Id),
    CONSTRAINT FK_InventoryItem_Item FOREIGN KEY (IdItem) REFERENCES Item(Id)
);
