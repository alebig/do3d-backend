 CREATE DATABASE DO3D
    CHARACTER SET UTF8;
--
USE DO3D;
--
CREATE TABLE usuarios (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    username VARCHAR(16) NOT NULL,
    pwd VARCHAR(64) NOT NULL,
    nombre VARCHAR(24) NOT NULL,
    apellido VARCHAR(24),
    email VARCHAR(64) NOT NULL,
    perfil VARCHAR(3) NOT NULL DEFAULT 'USR',
    alta DATETIME NOT NULL,
    ult_ing DATETIME,
    aut_acc SMALLINT UNSIGNED NOT NULL DEFAULT 5,
    PRIMARY KEY(id)
)   ENGINE=INNODB;
--
CREATE TABLE objetos (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    denom VARCHAR(32),
    desc_sint VARCHAR(32),
    desc_extensa VARCHAR(256),
    alta DATE NOT NULL,
    usr_origen SMALLINT UNSIGNED,
    usr_design SMALLINT UNSIGNED,
    sw_design VARCHAR(24),
    fork_de SMALLINT UNSIGNED,
    mostrar BOOLEAN DEFAULT TRUE,
    precio DECIMAL(8,2),
    moneda CHARACTER(2) DEFAULT "AR",
    PRIMARY KEY(id),
    FOREIGN KEY usuario (usr_origen)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY modelador (usr_design)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,    
    FOREIGN KEY obj_base (fork_de)
        REFERENCES objetos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)   ENGINE=INNODB;
--
CREATE TABLE imagenes (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    obj_id SMALLINT UNSIGNED NOT NULL,
    nro_orden TINYINT(3),
    ruta VARCHAR(128) NOT NULL,
    nomarch VARCHAR(64) NOT NULL,
    publicar BOOLEAN DEFAULT 1,
    alta DATE,
    PRIMARY KEY(id),
    FOREIGN KEY objeto (obj_id)
        REFERENCES objetos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)   ENGINE=INNODB;
--
CREATE TABLE pedidos (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    usr_id SMALLINT UNSIGNED NOT NULL,
    ingreso DATETIME NOT NULL,
    descripcion VARCHAR(256),
    observ VARCHAR(256),
    designer SMALLINT UNSIGNED,
    cotizacion DECIMAL(10,2),
    fecha_cot DATETIME,
    fecha_acept DATETIME,
    obj_id SMALLINT UNSIGNED,
    PRIMARY KEY(id),
    FOREIGN KEY (usr_id)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (designer)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (obj_id)
        REFERENCES objetos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)   ENGINE=INNODB;
--
CREATE TABLE facturacion (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    usr_id SMALLINT UNSIGNED NOT NULL,
    obj_id SMALLINT UNSIGNED not NULL,
    emision DATETIME NOT NULL,
    num_fact INTEGER(12),
    importe DECIMAL(10,2),
    PRIMARY KEY(id),
    FOREIGN KEY (usr_id)
        REFERENCES usuarios(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (obj_id)
        REFERENCES objetos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)   ENGINE=INNODB;
--
CREATE TABLE undo (
id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
usr_id SMALLINT UNSIGNED NOT NULL,
tbl_afect VARCHAR(64) not NULL,
id_afect SMALLINT UNSIGNED NOT NULL,
campo_afect VARCHAR(64) not NULL,
valor_anter VARCHAR(256),
valor_nuevo VARCHAR(256),
momento TIMESTAMP,
num_fact INTEGER(12),
importe DECIMAL(10,2),
PRIMARY KEY(id),
FOREIGN KEY (usr_id)
REFERENCES usuarios(id)
ON UPDATE CASCADE
ON DELETE RESTRICT,
) ENGINE=INNODB;
--
ALTER TABLE usuarios ADD COLUMN estado SMALLINT UNSIGNED DEFAULT 1 AFTER aut_acc;
ALTER TABLE usuarios MODIFY COLUMN estado SMALLINT UNSIGNED NOT NULL DEFAULT 1 AFTER aut_acc;
ALTER TABLE usuarios MODIFY COLUMN alta DATETIME;
ALTER TABLE objetos MODIFY COLUMN alta DATETIME;
ALTER TABLE imagenes MODIFY COLUMN alta DATETIME;