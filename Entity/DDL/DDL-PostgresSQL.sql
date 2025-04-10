-- PostgreSQL DDL

-- Tabla Form
CREATE TABLE Form (
    Id INTEGER PRIMARY KEY,
    NameForm VARCHAR(255),
    Description TEXT,
    Status BOOLEAN
);

-- Tabla Module
CREATE TABLE Module (
    Id INTEGER PRIMARY KEY,
    NameModule VARCHAR(255),
    Status BOOLEAN
);

-- Tabla FormModule (tabla puente entre Form y Module)
CREATE TABLE FormModule (
    Id INTEGER PRIMARY KEY,
    Status VARCHAR(100),
    IdForm INTEGER,
    IdModule INTEGER,
    CONSTRAINT FK_FormModule_Form FOREIGN KEY (IdForm) REFERENCES Form(Id),
    CONSTRAINT FK_FormModule_Module FOREIGN KEY (IdModule) REFERENCES Module(Id)
);

-- Tabla RolForm (tabla puente entre Rol y Form)
CREATE TABLE RolForm (
    Id INTEGER PRIMARY KEY,
    -- Otras propiedades de RolForm
    IdForm INTEGER,
    IdRol INTEGER,
    CONSTRAINT FK_RolForm_Form FOREIGN KEY (IdForm) REFERENCES Form(Id)
    -- La relación con Rol se define en FK_RolForm_Rol
);

-- Tabla User
CREATE TABLE "User" (
    Id INTEGER PRIMARY KEY,
    -- Otras propiedades de User
    IdPerson INTEGER,  -- Para relación UserPerson
    IdInventory INTEGER  -- Para relación UserInventory, si se desea
);

-- Tabla Rol
CREATE TABLE Rol (
    Id INTEGER PRIMARY KEY
    -- Otras propiedades de Rol
);

-- Asociación UserRol (uno a uno)
ALTER TABLE "User"
ADD COLUMN IdRol INTEGER;
ALTER TABLE "User"
ADD CONSTRAINT FK_User_Rol FOREIGN KEY (IdRol) REFERENCES Rol(Id);

-- Tabla Person
CREATE TABLE Person (
    Id INTEGER PRIMARY KEY
    -- Otras propiedades de Person
);

-- Relación UserPerson (uno a uno)
ALTER TABLE "User"
ADD CONSTRAINT FK_User_Person FOREIGN KEY (IdPerson) REFERENCES Person(Id);

-- Tabla Company
CREATE TABLE Company (
    Id INTEGER PRIMARY KEY
    -- Otras propiedades de Company
);

-- Tabla Sede
CREATE TABLE Sede (
    Id INTEGER PRIMARY KEY,
    IdCompany INTEGER,
    -- Otras propiedades de Sede
    CONSTRAINT FK_Sede_Company FOREIGN KEY (IdCompany) REFERENCES Company(Id)
);

-- Tabla ImageItem
CREATE TABLE ImageItem (
    Id INTEGER PRIMARY KEY
    -- Otras propiedades de ImageItem
);

-- Tabla Category
CREATE TABLE Category (
    Id INTEGER PRIMARY KEY
    -- Otras propiedades de Category
);

-- Tabla Item
CREATE TABLE Item (
    Id INTEGER PRIMARY KEY,
    -- Otras propiedades de Item
    IdImageItem INTEGER,
    IdCategory INTEGER,
    CONSTRAINT FK_Item_ImageItem FOREIGN KEY (IdImageItem) REFERENCES ImageItem(Id),
    CONSTRAINT FK_Item_Category FOREIGN KEY (IdCategory) REFERENCES Category(Id)
);

-- Tabla MovimientoItemInventory
CREATE TABLE MovimientoItemInventory (
    Id INTEGER PRIMARY KEY,
    IdItem INTEGER,
    IdInventory INTEGER,
    IdMoviemiento INTEGER,
    -- Otras propiedades de MovimientoItemInventory
    CONSTRAINT FK_MovInv_Item FOREIGN KEY (IdItem) REFERENCES Item(Id),
    CONSTRAINT FK_MovInv_Inventory FOREIGN KEY (IdInventory) REFERENCES Inventory(Id),
    CONSTRAINT FK_MovInv_Moviemiento FOREIGN KEY (IdMoviemiento) REFERENCES Moviemiento(Id)
);

-- Tabla Inventory
CREATE TABLE Inventory (
    Id INTEGER PRIMARY KEY,
    -- Otras propiedades de Inventory
    IdUser INTEGER, -- Para relación UserInventory
    CONSTRAINT FK_Inventory_User FOREIGN KEY (IdUser) REFERENCES "User"(Id)
);

-- Tabla Moviemiento
CREATE TABLE Moviemiento (
    Id INTEGER PRIMARY KEY
    -- Otras propiedades de Moviemiento
);

-- Relaciones adicionales

-- Asociación FormRolForm: Se asume que en RolForm se relaciona con Form
ALTER TABLE RolForm
ADD CONSTRAINT FK_RolForm_Rol FOREIGN KEY (IdRol) REFERENCES Rol(Id);

-- Tabla InventoryItem (tabla puente para Inventory e Item)
CREATE TABLE InventoryItem (
    Id SERIAL PRIMARY KEY,
    IdInventory INTEGER,
    IdItem INTEGER,
    CONSTRAINT FK_InventoryItem_Inventory FOREIGN KEY (IdInventory) REFERENCES Inventory(Id),
    CONSTRAINT FK_InventoryItem_Item FOREIGN KEY (IdItem) REFERENCES Item(Id)
);
