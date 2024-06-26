
create table AJUSTES (
   AJUCODIGO            int4              not null,
   EMPCODIGO            CHAR(7)              not null,
   AJUDESCRIPCION       CHAR(60)             not null,
   AJUFECHA             DATE                 not null,
   AJUCANTIDADTOTAL     NUMERIC(9,2)         null,
   constraint PK_AJUSTES primary key (AJUCODIGO)
);

create table BONIFICACIONES (
   BONCODIGO            CHAR(5)              not null,
   BONDESCRIPCION       CHAR(30)             not null,
   BONVALOR             DECIMAL(7,2)         not null,
   constraint PK_BONIFICACIONES primary key (BONCODIGO)
);

create table BXN (
   BONCODIGO            CHAR(5)              not null,
   NOMCODIGO            CHAR(7)              not null,
   BXNVALOR             DECIMAL(7,2)         not null,
   BXNSTATUS            CHAR(3)              not null,
   constraint PK_BXN primary key (BONCODIGO, NOMCODIGO)
);

CREATE TABLE CLIENTES (
   CLICODIGO            CHAR(7)              NOT NULL,
   CLINOMBRE            CHAR(60)             NOT NULL,
   CLIIDENTIFICACION    CHAR(13)             NOT NULL,
   CLIDIRECCION         CHAR(60)             NOT NULL,
   CLITELEFONO          CHAR(10)             NOT NULL,
   CLICELULAR           CHAR(10)             NOT NULL,
   CLIEMAIL             CHAR(60),
   CLITIPO              CHAR(3)              NOT NULL,
   CLISTATUS            CHAR(3)              NOT NULL,
   CONSTRAINT PK_CLIENTES PRIMARY KEY (CLICODIGO),
   CONSTRAINT CK_EMPPRIMER_APELLIDO CHECK (UPPER(CLINOMBRE) ~ '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$'),
   CONSTRAINT CK_EMPSTATUS_VALIDO CHECK (UPPER(CLISTATUS) IN ('INA', 'ACT')),
   CONSTRAINT CK_EMPIDENTIFICACION_LENGTH CHECK (LENGTH(CLIIDENTIFICACION) = 10),
   CONSTRAINT CK_EMPTELEFONO_LENGTH CHECK (LENGTH(CLITELEFONO) = 7),
   CONSTRAINT CK_EMPELULAR_LENGTH CHECK (LENGTH(CLICELULAR) = 10),
   CONSTRAINT CK_EMPTIPO_VALIDO CHECK (UPPER(CLITIPO) IN ('NAT', 'JUR'))
);

create table COMPRAS (
   OCNUMERO             CHAR(9)              not null,
   PRVCODIGO            CHAR(7)              not null,
   OCFECHA              DATE                 not null,
   OCSUBTOTAL           NUMERIC(9,2)         not null,
   OCDESCUENTO          NUMERIC(9,2)         null,
   OCVALOR_IVA          NUMERIC(9,2)         null,
   OCVALOR_ICE          NUMERIC(9,2)         null,
   OCFORMAPAGO          CHAR(5)              not null,
   OCFACTURA_ASOCIADA   CHAR(30)             not null,
   OCSTATUS             CHAR(3)              null,
   constraint PK_COMPRAS primary key (OCNUMERO)
);

create table DESCUENTOS (
   DESCODIGO            CHAR(5)              not null,
   DESDESCRIPCION       CHAR(30)             not null,
   DESVALOR             DECIMAL(7,2)         not null,
   constraint PK_DESCUENTOS primary key (DESCODIGO)
);

create table DXN (
   NOMCODIGO            CHAR(7)              not null,
   DESCODIGO            CHAR(5)              not null,
   DXNVALOR             DECIMAL(7,2)         not null,
   DXNSTATUS            CHAR(3)              not null,
   constraint PK_DXN primary key (NOMCODIGO, DESCODIGO)
);

create table EMPLEADOS (
   EMPCODIGO            CHAR(7)              not null,
   EMPAPELLIDO1         CHAR(30)             not null,
   EMPAPELLIDO2         CHAR(30)             null,
   EMPNOMBRE1           CHAR(30)             not null,
   EMPNOMBRE2           CHAR(30)             null,
   EMPFECHANACIMIENTO   DATE                 not null,
   EMPSEXO              CHAR(1)              not null,
   EMPEMAIL             CHAR(60)             not null,
   EMPDIRECCION         CHAR(60)             not null,
   EMPTIPOSANGRE        CHAR(3)              not null,
   EMPSUELDO            NUMERIC(7,2)         not null,
   EMPBANCO             CHAR(30)             not null,
   EMPCUENTA            CHAR(20)             not null,
   EMPSTATUS            CHAR(3)              not null,
   constraint PK_EMPLEADOS primary key (EMPCODIGO)
);

CREATE TABLE FACTURAS (
   FACNUMERO            CHAR(9)              NOT NULL,
   CLICODIGO            CHAR(7)              NOT NULL,
   FACFECHA             DATE                 NOT NULL,
   FACSUBTOTAL          NUMERIC(9,2)         NOT NULL,
   FACDESCUENTO         NUMERIC(9,2)         NULL,
   FACIVA               NUMERIC(9,2)         NULL,
   FACICE               NUMERIC(9,2)         NULL,
   FACFORMAPAGO         CHAR(5)              NOT NULL,
   FACSTATUS            CHAR(3)              NOT NULL,
   CONSTRAINT PK_FACTURAS PRIMARY KEY (FACNUMERO),
   CONSTRAINT CK_FACSUBTOTAL_POSITIVE CHECK (FACSUBTOTAL >= 0),
   CONSTRAINT CK_FACDESCUENTO_POSITIVE CHECK (FACDESCUENTO >= 0 OR FACDESCUENTO IS NULL),
   CONSTRAINT CK_FACIVA_VALUES CHECK (FACIVA IN (8, 12, 15) OR FACIVA IS NULL),
   CONSTRAINT CK_FACFORMAPAGO_VALUES CHECK (FACFORMAPAGO IN ('EFECT', 'TARCR', 'TARDB', 'TRANS', 'CHEQ')),
   CONSTRAINT CK_FACSTATUS_VALUES CHECK (FACSTATUS IN ('ACT', 'INA'))
);

create table INGRESOS (
   INGCODIGO            int4              not null,
   EMPCODIGO            CHAR(7)              not null,
   INGDESCRIPCION       CHAR(30)             not null,
   INGFECHA             DATE                 not null,
   INGCANTIDADTOTAL     NUMERIC(9,2)         null,
   INGREFERENCIA        CHAR(60)             null,
   constraint PK_INGRESOS primary key (INGCODIGO)
);

create table NOMINAS (
   NOMCODIGO            CHAR(7)              not null,
   EMPCODIGO            CHAR(7)              not null,
   NOMANIO              CHAR(4)              not null,
   NOMMES               CHAR(2)              not null,
   NOMFECHAINICIAL      DATE                 not null,
   NOMFECHAFINAL        DATE                 not null,
   NOMSTATUS            CHAR(3)              not null,
   constraint PK_NOMINAS primary key (NOMCODIGO)
);

create table PRODUCTOS (
   PROCODIGO            CHAR(9)              not null,
   PRODESCRIPCION       CHAR(50)             not null,
   PROUNIDADMEDIDA      CHAR(3)              not null,
   PROSALDOINICIAL      DECIMAL(9,2)         not null,
   PROINGRESOS          DECIMAL(9,2)         not null,
   PROEGRESOS           NUMERIC(9,2)         not null,
   PROAJUSTES           NUMERIC(9,2)         not null,
   PROSALDOFINAL        NUMERIC(9,2)         not null,
   PROCOSTOUM           NUMERIC(7,2)         not null,
   PROPRECIOUM          NUMERIC(7,2)         not null,
   PROSTATUS            CHAR(3)              not null,
   constraint PK_PRODUCTOS primary key (PROCODIGO)
);
ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PRODESCRIPCION_FORMAT CHECK (PRODESCRIPCION ~ '^[A-Za-zÑñÁÉÍÓÚáéíóú ]+$');

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROUNIDADMEDIDA CHECK (PROUNIDADMEDIDA IN ('QQ', 'CAJ', 'KG', 'PAQ', 'LIT', 'UNI'));

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROSALDOINICIAL CHECK (PROSALDOINICIAL >= 0);

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROINGRESOS CHECK (PROINGRESOS >= 0);

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROINGRESOS_VALID CHECK (PROINGRESOS <= (PROSALDOFINAL + PROEGRESOS + PROAJUSTES));

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROEGRESOS CHECK (PROEGRESOS >= 0);

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROEGRESOS_VALID CHECK (PROEGRESOS <= (PROSALDOINICIAL + PROINGRESOS + PROAJUSTES));

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROAJUSTES CHECK (PROAJUSTES >= 0);

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROSALDOFINAL CHECK (PROSALDOFINAL >= 0);

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROSALDOFINAL_VALID CHECK (PROSALDOFINAL = (PROSALDOINICIAL + PROINGRESOS + PROAJUSTES - PROEGRESOS));

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROCOSTOUM CHECK (PROCOSTOUM >= 0);

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROPRECIOUM CHECK (PROPRECIOUM >= 0);

ALTER TABLE PRODUCTOS
ADD CONSTRAINT CHK_PROSTATUS CHECK (PROSTATUS IN ('ACT', 'INA'));

create table PROVEEDORES (
   PRVCODIGO            CHAR(7)              not null,
   PRVNOMBRE            CHAR(30)             not null,
   PRVIDENTIFICACION    CHAR(10)             not null,
   PRVDIRECCION         CHAR(60)             not null,
   PRVTELEFONO          CHAR(10)             null,
   PRVCELULAR           CHAR(10)             null,
   PRVEMAIL             CHAR(60)             null,
   PRVTIPO              CHAR(3)              not null,
   PRVSTATUS            CHAR(3)              not null,
   constraint PK_PROVEEDORES primary key (PRVCODIGO)
);

create table PXA (
   AJUCODIGO            INT4                 not null,
   PROCODIGO            CHAR(9)              not null,
   PXACANTIDAD          NUMERIC(9,2)         not null,
   constraint PK_PXA primary key (AJUCODIGO, PROCODIGO)
);

create table PXF (
   FACNUMERO            CHAR(9)              not null,
   PROCODIGO            CHAR(9)              not null,
   PXFCANTIDAD          NUMERIC(9,2)         not null,
   PXFVALOR             NUMERIC(7,2)         not null,
   PXFSUBTOTAL          NUMERIC(9,2)         not null,
   PXFSTATUS            CHAR(3)              not null,
   constraint PK_PXF primary key (FACNUMERO, PROCODIGO)
);

create table PXI (
   INGCODIGO            INT4                 not null,
   PROCODIGO            CHAR(9)              not null,
   PXICANTIDAD          NUMERIC(9,2)         not null,
   constraint PK_PXI primary key (INGCODIGO, PROCODIGO)
);

create table PXO (
   OCNUMERO             CHAR(9)              not null,
   PROCODIGO            CHAR(9)              not null,
   PXCCANTIDAD          NUMERIC(9,2)         not null,
   PXCVALOR             NUMERIC(7,2)         not null,
   PXCSUBTOTAL          NUMERIC(9,2)         not null,
   PXCSTATUS            CHAR(3)              not null,
   constraint PK_PXO primary key (OCNUMERO, PROCODIGO)
);

create table PXS (
   SALCODIGO            INT4                 not null,
   PROCODIGO            CHAR(9)              not null,
   PXSCANTIDAD          NUMERIC(9,2)         not null,
   constraint PK_PXS primary key (SALCODIGO, PROCODIGO)
);

create table SALIDAS (
   SALCODIGO           int4             not null,
   EMPCODIGO            CHAR(7)              not null,
   SALDESCRIPCION       CHAR(30)             not null,
   SALFECHA             DATE                 not null,
   SALCANTIDADTOTAL     NUMERIC(9,2)         null,
   SALREFERENCIA        CHAR(60)             null,
   constraint PK_SALIDAS primary key (SALCODIGO)
);


alter table AJUSTES
   add constraint FK_AJUSTES_AUTORIZA_EMPLEADO foreign key (EMPCODIGO)
      references EMPLEADOS (EMPCODIGO)
      on delete restrict on update restrict;

alter table BXN
   add constraint FK_BXN_BXN_NOMINAS foreign key (NOMCODIGO)
      references NOMINAS (NOMCODIGO)
      on delete restrict on update restrict;

alter table BXN
   add constraint FK_BXN_BXN2_BONIFICA foreign key (BONCODIGO)
      references BONIFICACIONES (BONCODIGO)
      on delete restrict on update restrict;

alter table COMPRAS
   add constraint FK_COMPRAS_PROVEE_PROVEEDO foreign key (PRVCODIGO)
      references PROVEEDORES (PRVCODIGO)
      on delete restrict on update restrict;

alter table DXN
   add constraint FK_DXN_DXN_DESCUENT foreign key (DESCODIGO)
      references DESCUENTOS (DESCODIGO)
      on delete restrict on update restrict;

alter table DXN
   add constraint FK_DXN_DXN2_NOMINAS foreign key (NOMCODIGO)
      references NOMINAS (NOMCODIGO)
      on delete restrict on update restrict;

alter table FACTURAS
   add constraint FK_FACTURAS_ADQUIERE_CLIENTES foreign key (CLICODIGO)
      references CLIENTES (CLICODIGO)
      on delete restrict on update restrict;

alter table INGRESOS
   add constraint FK_INGRESOS_RESPONDEX_EMPLEADO foreign key (EMPCODIGO)
      references EMPLEADOS (EMPCODIGO)
      on delete restrict on update restrict;

alter table NOMINAS
   add constraint FK_NOMINAS_MANTIENE_EMPLEADO foreign key (EMPCODIGO)
      references EMPLEADOS (EMPCODIGO)
      on delete restrict on update restrict;

alter table PXA
   add constraint FK_PXA_PXA_PRODUCTO foreign key (PROCODIGO)
      references PRODUCTOS (PROCODIGO)
      on delete restrict on update restrict;

alter table PXA
   add constraint FK_PXA_PXA2_AJUSTES foreign key (AJUCODIGO)
      references AJUSTES (AJUCODIGO)
      on delete restrict on update restrict;

alter table PXF
   add constraint FK_PXF_PXF_PRODUCTO foreign key (PROCODIGO)
      references PRODUCTOS (PROCODIGO)
      on delete restrict on update restrict;

alter table PXF
   add constraint FK_PXF_PXF2_FACTURAS foreign key (FACNUMERO)
      references FACTURAS (FACNUMERO)
      on delete restrict on update restrict;

alter table PXI
   add constraint FK_PXI_PXI_PRODUCTO foreign key (PROCODIGO)
      references PRODUCTOS (PROCODIGO)
      on delete restrict on update restrict;

alter table PXI
   add constraint FK_PXI_PXI2_INGRESOS foreign key (INGCODIGO)
      references INGRESOS (INGCODIGO)
      on delete restrict on update restrict;

alter table PXO
   add constraint FK_PXO_PXO_PRODUCTO foreign key (PROCODIGO)
      references PRODUCTOS (PROCODIGO)
      on delete restrict on update restrict;

alter table PXO
   add constraint FK_PXO_PXO2_COMPRAS foreign key (OCNUMERO)
      references COMPRAS (OCNUMERO)
      on delete restrict on update restrict;

alter table PXS
   add constraint FK_PXS_PXS_PRODUCTO foreign key (PROCODIGO)
      references PRODUCTOS (PROCODIGO)
      on delete restrict on update restrict;

alter table PXS
   add constraint FK_PXS_PXS2_SALIDAS foreign key (SALCODIGO)
      references SALIDAS (SALCODIGO)
      on delete restrict on update restrict;

alter table SALIDAS
   add constraint FK_SALIDAS_DISPONE_EMPLEADO foreign key (EMPCODIGO)
      references EMPLEADOS (EMPCODIGO)
      on delete restrict on update restrict;

create unique index AJUSTES_PK on AJUSTES (AJUCODIGO);
create unique index SALIDAS_PK on SALIDAS (SALCODIGO);
create unique index PXS_PK on PXS (SALCODIGO, PROCODIGO);
create unique index PXO_PK on PXO (OCNUMERO, PROCODIGO);
create unique index PXI_PK on PXI (INGCODIGO,PROCODIGO);
create unique index PXF_PK on PXF (FACNUMERO,PROCODIGO);
create unique index BONIFICACIONES_PK on BONIFICACIONES (BONCODIGO);
create unique index PXA_PK on PXA (AJUCODIGO,PROCODIGO);
create unique index PROVEEDORES_PK on PROVEEDORES (PRVCODIGO);
create unique index PRODUCTOS_PK on PRODUCTOS (PROCODIGO);
create unique index NOMINAS_PK on NOMINAS (NOMCODIGO);
create unique index INGRESOS_PK on INGRESOS (INGCODIGO);
create unique index FACTURAS_PK on FACTURAS (FACNUMERO);
create unique index EMPLEADOS_PK on EMPLEADOS (EMPCODIGO);
create unique index BXN_PK on BXN (BONCODIGO,NOMCODIGO);
create unique index CLIENTES_PK on CLIENTES (CLICODIGO);
create unique index COMPRAS_PK on COMPRAS (OCNUMERO);
create unique index DESCUENTOS_PK on DESCUENTOS (DESCODIGO);
create unique index DXN_PK on DXN (NOMCODIGO,DESCODIGO);

create  index AUTORIZA_FK on AJUSTES (EMPCODIGO);
create  index DISPONE_FK on SALIDAS (EMPCODIGO);
create  index PXS2_FK on PXS (SALCODIGO);
create  index PXS_FK on PXS (PROCODIGO);
create  index PXO2_FK on PXO (OCNUMERO);
create  index PXO_FK on PXO (PROCODIGO);
create  index PXI2_FK on PXI (INGCODIGO);
create  index PXI_FK on PXI (PROCODIGO);
create  index PXF2_FK on PXF (FACNUMERO);
create  index PXF_FK on PXF (PROCODIGO);
create  index PXA2_FK on PXA (AJUCODIGO);
create  index PXA_FK on PXA (PROCODIGO);
create  index MANTIENE_FK on NOMINAS (EMPCODIGO);
create  index RESPONDEX_FK on INGRESOS (EMPCODIGO);
create  index ADQUIERE_FK on FACTURAS (CLICODIGO);
create  index BXN2_FK on BXN (BONCODIGO);
create  index BXN_FK on BXN (NOMCODIGO);
create  index PROVEE_FK on COMPRAS (PRVCODIGO);
create  index DXN2_FK on DXN (NOMCODIGO);
create  index DXN_FK on DXN (DESCODIGO);

insert into PRODUCTOS values ('P-0001', 'CEREAL TRIGO ENTERO',        'QQ ', 0, 0, 0, 0, 0, 1, 2.75, 'ACT');
insert into PRODUCTOS values ('P-0002', 'MORA FRUTO COMPLETO',        'CAJ', 0, 0, 0, 0, 0, 1, 0.85, 'ACT');
insert into PRODUCTOS values ('P-0003', 'CARNE DE CERDO CON HUESO',   'KG ', 0, 0, 0, 0, 0, 1, 3.50, 'ACT');
insert into PRODUCTOS values ('P-0004', 'SARDINAS EN CONSERVA',       'PAQ', 0, 0, 0, 0, 0, 1, 1.75, 'ACT');
insert into PRODUCTOS values ('P-0005', 'LECHE LÍQUIDA PASTEURIZADA', 'LIT', 0, 0, 0, 0, 0, 1, 0.90, 'ACT');
insert into PRODUCTOS values ('P-0006', 'ATÚN EN CONSERVA ',          'UNI', 0, 0, 0, 0, 0, 1, 2.00, 'ACT');

insert into EMPLEADOS  values ('EMP-111', 'CONDOR', 'CRUZ', 'JAVIER', 'WILFRIDO',      '1965-09-04', 'H', 'jwcondor@puce.edu.ec',   'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT');
insert into EMPLEADOS  values ('EMP-222', 'ARCOS', 'VILLAGOMEZ', 'SUYANA', 'FABIOLA',  '1975-06-14', 'M', 'sarcos@puce.edu.ec',     'Quito, Monteserrin, Francisco Arevalo', 'RH-', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT');
insert into EMPLEADOS  values ('EMP-333', 'CASTRO', 'DE LA CRUZ', 'FABIAN', 'IGNACIO', '1985-03-24', 'H', 'fcastro@puce.edu.ec',    'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT');
insert into EMPLEADOS  values ('EMP-444', 'MASAPANTA', 'LIZ', 'SUSANA', 'MARGARITA',   '1995-12-14', 'M', 'smasapanta@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH-', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT');
insert into EMPLEADOS  values ('EMP-555', 'CANDO', 'CANDO', 'WILSON', 'ALFREDO',       '2005-09-04', 'H', 'wcando@puce.edu.ec',     'Quito, Monteserrin, Francisco Arevalo', 'RH+', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT');
insert into EMPLEADOS  values ('EMP-666', 'CHICAIZA', 'VALLADARES', 'ROSA', 'ELVIA',   '2015-06-14', 'M', 'rechicaiza@puce.edu.ec', 'Quito, Monteserrin, Francisco Arevalo', 'RH-', 1250, 'BANCO INTERNACIONAL', 'CTA 0610704663', 'ACT');

insert into PROVEEDORES  values ('PRV-010', 'CORPORACION FAVORITA C.A.', '1702996501', 'Sangolquí Av. 6 de Diciembre y Julio Moreno Quito - Ecuador', '02-2996500', '0992996500', 'ventas@favorita.com.ec'      , 'JUR', 'ACT');
insert into PROVEEDORES  values ('PRV-020', 'CORPORACION EL ROSADO SA.', '0702996502', 'Centro Av. 9 De Octubre 729 y Boyacá Guayaquil - Ecuador'   , '02-2980980', '0992996500', 'ventas@elrosado.com.ec'      , 'JUR', 'ACT');
insert into PROVEEDORES  values ('PRV-030', 'INDUSTRIAL PESQUERA SANTA', '1402996503', 'Vía Daule Km 5 1/2 y Calle Sèptima Guayaquil - Ecuador'     , '04-2322000', '0992996500', 'ventas@santa_priscila.com.ec', 'JUR', 'ACT');
insert into PROVEEDORES  values ('PRV-040', 'ECUACORRIENTE S. A.'     , '0602996504', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales'   , '04-6005238', '0992996500', 'ventas@ecuacorriente.ec'     , 'JUR', 'ACT');
insert into PROVEEDORES  values ('PRV-050', 'DINADEC S.A.'            , '1902996505', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales'   , '04-5004040', '0992996500', 'ventas@danec.ec'             , 'JUR', 'ACT');
insert into PROVEEDORES  values ('PRV-060', 'DISTRIBUIDORA FARMACEUTI', '2102996506', 'Cdla. Santa Leonor, Mz. 6, solar 17 Guayaquil - Ecuador'    , '04-5004040', '0992996500', 'ventas@difare.com.ec'        , 'JUR', 'ACT');

INSERT INTO CLIENTES VALUES ('CLI-001', 'CORPORACION FAVORITA', '1702996501', 'Sangolquí Av. 6 de Diciembre y Julio Moreno Quito - Ecuador', '0229967', '0992996500', 'ventas@favorita.com.ec', 'JUR', 'ACT');
INSERT INTO CLIENTES VALUES ('CLI-002', 'CÓNDOR JAVIER', '0702996502', 'Centro Av. 9 De Octubre 729 y Boyacá Guayaquil - Ecuador', '0229809', '0992996500', 'ventas@elrosado.com.ec', 'NAT', 'ACT');
INSERT INTO CLIENTES VALUES ('CLI-003', 'INDUSTRIAL PESQUERA SANTA', '1402996503', 'Vía Daule Km 5 1/2 y Calle Sèptima Guayaquil - Ecuador', '0423220', '0992996500', 'ventas@santa_priscila.com.ec', 'JUR', 'ACT');
INSERT INTO CLIENTES VALUES ('CLI-004', 'PAMELA CORTEZ', '0602996504', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales', '0460052', '0992996500', 'ventas@ecuacorriente.ec', 'NAT', 'ACT');
INSERT INTO CLIENTES VALUES ('CLI-005', 'DINADEC', '1902996505', 'Norte Km. 16 1/2, vía a Daule, calle Cobre por Pascuales', '0450040', '0992996500', 'ventas@danec.ec', 'JUR', 'ACT');
INSERT INTO CLIENTES VALUES ('CLI-006', 'VERONICA ANTONELA FRITZ', '2102996506', 'Cdla. Santa Leonor, Mz. 6, solar 17 Guayaquil - Ecuador', '0450040', '0992996500', 'ventas@difare.com.ec', 'NAT', 'ACT');
INSERT INTO CLIENTES VALUES ('CLI-007', 'CARLOS SAAVEDRA', '1726350364', 'Av. equinoccial y Pucara', '2395258', '0979598649', 'cfsaavedra@puce.edu.ec', 'NAT', 'ACT');

insert into NOMINAS  values ('NOM0001', 'EMP-111', '   4', ' 2', '1-1-1', '1017-9-6', '  0');
insert into NOMINAS  values ('NOM0002', 'EMP-555', '    ', ' 3', '927-10-8', '1376-11-7', '  1');
insert into NOMINAS  values ('NOM0003', 'EMP-111', '   0', ' 4', '1556-7-23', '1-1-1', '  2');
insert into NOMINAS  values ('NOM0004', 'EMP-333', '   1', '  ', '448-7-4', '1571-7-11', '  3');
insert into NOMINAS  values ('NOM0005', 'EMP-555', '   2', ' 0', '1945-8-8', '341-4-12', '  4');
insert into NOMINAS  values ('NOM0006', 'EMP-222', '   3', ' 1', '1105-7-15', '613-10-29', '   ');

insert into BONIFICACIONES  values ('B1010', 'Fondo de Reserva Mensualizado', 145);
insert into BONIFICACIONES  values ('B1020', 'Bono 20 anios de servicio', 200);
insert into BONIFICACIONES  values ('B1030', 'Bono 25 anios de servicio', 250);
insert into BONIFICACIONES  values ('B1040', 'Bono 30 anios de servicio', 300);
insert into BONIFICACIONES  values ('B1050', 'Bono publicación scopus', 500);
insert into BONIFICACIONES  values ('B1060', 'Bono horas extra', 100);

insert into DESCUENTOS  values ('D2010', 'Aporte Personal IESS', 333);
insert into DESCUENTOS  values ('D2020', 'Aporte Personal FIDEICOMISO', 555);
insert into DESCUENTOS  values ('D2030', 'Aporte Personal Seguro Cancer', 444);
insert into DESCUENTOS  values ('D2040', 'Aporte Personal Seguro Medico', 111);
insert into DESCUENTOS  values ('D2050', 'Aporte Personal Seguro de Vida', 10);
insert into DESCUENTOS  values ('D2060', 'Aporte APPUCE', 28);

insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1010', 'NOM0001', 1, '  4');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1020', 'NOM0002', 5, '   ');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1030', 'NOM0003', 2, '  0');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1040', 'NOM0004', 3, '  1');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1050', 'NOM0005', 4, '  2');
insert into BXN (BONCODIGO, NOMCODIGO, BXNVALOR, BXNSTATUS) values ('B1060', 'NOM0006', 0, '  3');

insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0001', 'D2010', 2, '   ');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0002', 'D2020', 4, '  0');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0003', 'D2030', 3, '  1');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0004', 'D2040', 1, '  2');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0005', 'D2050', 0, '  3');
insert into DXN (NOMCODIGO, DESCODIGO, DXNVALOR, DXNSTATUS) values ('NOM0006', 'D2060', 5, '  4');

insert into INGRESOS values (5, 'EMP-111', '398CROUREDDM115PH16M43TRJ2 75B', '443-11-28', 0, '31W4IIA74J4LBI91QPLUG YCIJGAWBEPFNYY5TRPUH8BTUAELI1315RX93 4');
insert into INGRESOS values (1, 'EMP-222', '0DWW3OW5DAP7T3KM 1XQI1MOECRCU ', '1-1-1', 1, 'AY33I3UUN1OWWROWT44GERG5WA6YVRIMUG59BY5KT6O7QKWM2YPT40MW0X2 ');
insert into INGRESOS values (0, 'EMP-555', 'H9ME19XKLDMS6WFSKF73Y39W0PIP7R', '759-10-13', 2, '71M69ONKVN8L7YDQIKNQ0V2E LLCRPL4CQI66RGN9L6VBHKO00SHA64M G I');
insert into INGRESOS values (4, 'EMP-222', '8K 51430R3OQ7GHAQDHURKQHI KXAW', '273-10-28', 5, 'SYLW2RC11IF57P2BF2CG0YGIIOGYFDT6BAP99 V9H1CQN8838LXUU8KLDU1 ');
insert into INGRESOS values (3, 'EMP-222', 'QKY59G9J44QONMLEHNWEX8YIRUV22I', '1504-9-26', 3, 'Y03J5RN029EGTYUP3LE5ERDR0JDJNBUM  4WAO26AH5UET8Q XD7T2 7O5I ');
insert into INGRESOS values (2, 'EMP-222', 'MWL4O8DAOABWE DX4KUV76FVD7X9VT', '1171-9-6', 4, 'OQ07W3MS14IMX9FORD3X1HRH7O6IGES RQF2YUJYW0D84HYQBUQ726WO8HF3');

insert into COMPRAS values ('OC202301', 'PRV-010', '685-2-9', 2, 5, 5, 1, 'VYG4G', 'LGV724R 2E2RSIU  1PI1GM7PIPGVG', '  2');
insert into COMPRAS values ('OC0002', 'PRV-030', '337-12-24', 3, 4, 3, 5, 'Y65KI', 'E11J4M5B9M6FJLWM0LBCS4NW20 0JU', '  4');
insert into COMPRAS values ('OC-003', 'PRV-030', '1603-7-22', 0, 0, 2, 0, 'RDUJA', 'A7Y7WJSN1S15RNBUO0990W57UQWBLP', '  0');

INSERT INTO FACTURAS VALUES ('FAC-001', 'CLI-001', CURRENT_DATE, 100.00, 10.00, 12, 0, 'EFECT', 'ACT');
INSERT INTO FACTURAS VALUES ('FAC-002', 'CLI-002', CURRENT_DATE, 150.50, 0, 8, 0, 'TARCR', 'ACT');
INSERT INTO FACTURAS VALUES ('FAC-003', 'CLI-003', CURRENT_DATE, 200.00, 20.00, 15, 0, 'TRANS', 'ACT');


insert into PXF values ('FAC-001', 'P-0001', 2, 3, 4, '  1');
insert into PXF values ('FAC-001', 'P-0002', 0, 4, 5, '  2');
insert into PXF values ('FAC-002', 'P-0003', 1, 5, 2, '  3');
insert into PXF values ('FAC-002', 'P-0004', 3, 1, 0, '  4');
insert into PXF values ('FAC-003', 'P-0005', 4, 0, 3, '   ');
insert into PXF values ('FAC-003', 'P-0006', 5, 2, 1, '  0');

insert into PXO values ('OC202301', 'P-0001', 5, 5, 4, '  2');
insert into PXO values ('OC202301', 'P-0002', 0, 3, 2, '  3');
insert into PXO values ('OC0002', 'P-0003', 4, 4, 5, '  4');
insert into PXO values ('OC0002', 'P-0004', 1, 1, 0, '   ');
insert into PXO values ('OC-003', 'P-0005', 2, 0, 3, '  0');
insert into PXO values ('OC-003', 'P-0006', 3, 2, 1, '  1');

insert into PXI values (5, 'P-0001', 1);
insert into PXI values (1, 'P-0002', 5);
insert into PXI values (0, 'P-0003', 4);
insert into PXI values (4, 'P-0004', 3);
insert into PXI values (3, 'P-0005', 2);
insert into PXI values (2, 'P-0006', 0);

insert into SALIDAS values (2, 'EMP-111', 'PDYXLBATFWT3P1VDAHXPET3E8SCF8X', '1507-12-12', 5, 'AC21NWQ HYLII0VU7 RKWDPTB3JG5PL4PQTXW3DFEU1C5TD42C0C2TQ6M82S');
insert into SALIDAS values (1, 'EMP-333', 'GT19G  JJ3LG1L72BP3KQ4LOT5I945', '1809-6-21', 0, '8HNRJV2W1LX5ANE6LC0HLN HC8OUIE6LECCN9M90IRJT6SBSEW51JGUHX8JG');
insert into SALIDAS values (5, 'EMP-555', '61MEW45WVMHK7PGEOTA I91QM49664', '1-1-1', 1, 'FAN6111THO52B6OHLLUA7SS85J NPSK255MTQNTWNI41C2VXFHGB7MD 6GSS');
insert into SALIDAS values (4, 'EMP-111', 'EWNWLG3KBVLPGO5F 55UOUQRPX8VW3', '413-4-7', 2, '8 LBA3UYFRKCF21WEWXWJ814687VYU95TUU WPI0SOFUOE4QJF8O5QJYFC2H');
insert into SALIDAS values (0, 'EMP-444', 'VE AQ XHJXCLPQMV1K 7G8JMD4P676', '881-4-21', 3, 'V9WO17NODPYLA3439 VBQ7S6LWO2P7HKROR7AT05KHBHWBBB 6VYX LXDH9 ');
insert into SALIDAS values (3, 'EMP-444', '1E7YE9QCLJY3BK607U7HU6FKR6K3SP', '1115-12-29', 4, 'NWRL3MG88F4YVN0RYOXH3NHM0 E9VK7P15MVI206CK5H3UXJTMA3MCT7E9O1');

insert into AJUSTES values (1, 'EMP-111', 'Ajuste por inundación 01', '867-4-25', 3);
insert into AJUSTES values (2, 'EMP-444', 'Ajuste por inundación 02', '1-1-1', 2);
insert into AJUSTES values (3, 'EMP-222', 'Ajuste por inundación 03', '473-2-27', 5);

insert into PXA values (1, 'P-0001', 4);
insert into PXA values (1, 'P-0002', 0);
insert into PXA values (1, 'P-0003', 3);
insert into PXA values (2, 'P-0004', 1);
insert into PXA values (2, 'P-0005', 5);
insert into PXA values (2, 'P-0006', 2);

insert into PXS values (2, 'P-0001', 4);
insert into PXS values (1, 'P-0002', 1);
insert into PXS values (5, 'P-0003', 2);
insert into PXS values (4, 'P-0004', 0);
insert into PXS values (0, 'P-0005', 5);
insert into PXS values (3, 'P-0006', 3);
