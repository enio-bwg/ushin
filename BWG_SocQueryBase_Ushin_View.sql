USE [BWG_GA_MT]
GO

/****** Object:  View [ApTenantUser].[BWG_SocQueryBase_Ushin_View]    Script Date: 05/05/2022 13:25:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE OR ALTER     View [ApTenantUser].[BWG_SocQueryBase_Ushin_View] As (

Select Distinct
CON_CdiContratado As 'CdiContratado',
CON_CdiSituacao As 'CdiSituacao',
CON_DtdAdmissao As 'DtdAdmissao',
CON_CdiVinculo  As 'CdiVinculo',

EMP_CDIEMPRESA,
CON_DSSBAIRRO COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS CON_DSSBAIRRO,
CON_DssNomePai,

Case When REPLACE(CON_COSCARTAONACIONALSAUDE, ' ', '') Is Null 
	Then '' 
	Else REPLACE(CON_COSCARTAONACIONALSAUDE, ' ', '') 
End As CON_COSCARTAONACIONALSAUDE,

Case When CON_CDICATEGORIA = 1 
	Then 'CONTRIB_INDIVIDUAL_AUTONOMO_CONTRATADO_EMPRESAS_GERAL' 
	Else 'CONTRIB_INDIVIDUAL_AUTONOMO_CONTRATADO_EMPRESAS_GERAL' 
End CON_CDICATEGORIA,

Case When REPLACE(REPLACE(CON_NUSCEP, '.', ''), '-', '') Is Null Then '' Else REPLACE(REPLACE(CON_NUSCEP, '.', ''), '-', '') End As CON_NUSCEP,
Case When CON_DSSMUNICIPIO COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS Is Null Then '' Else CON_DSSMUNICIPIO COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS End AS CON_DSSMUNICIPIO,

'' AS CODIGO,

Case When CON_DSSENDERECOCOMPLTO COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS Is Null Then '' Else CON_DSSENDERECOCOMPLTO COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS End As CON_DSSENDERECOCOMPLTO,

UPPER(CPL_D1sCorPele COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS) as CON_CdiCorPele,
REPLACE(REPLACE(CON_NUSCICNUMERO, '.', ''), '-', '') AS CON_NUSCICNUMERO,
CONVERT(varchar(10), CON_DTDADMISSAO, 103) AS CON_DTDADMISSAO,
CASE
	WHEN CON_DTDEMISSAOCARPROF = NULL THEN ''	
	ELSE CONVERT(varchar(10), CON_DTDEMISSAOCARPROF, 103)
END CON_DTDEMISSAOCARPROF,

CONVERT(varchar(10), CON_DTDNASCIMENTODATA, 103) AS CON_DTDNASCIMENTODATA,
CONVERT(varchar(10), GETDATE(), 103) AS DATAULTIMAMOVIMENTACAO,

CON_COSEMAIL,
(ENDCON.TEN_D1STIPOENDERECO + ' ' +  CON_DSSENDERECOBASE) COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS CON_DSSENDERECOBASE,
upper(GIN_D1sGrauInstrucao COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS) as CON_CDIGRAUINSTRUCAO,

RES.EST_CdsSiglaEstado AS CON_CDIESTADO_RESID,
upper(ETC_D1sEstadoCivil COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS) as CON_CDIESTADOCIVIL,
COE_NusMatriculaeSocial AS MATRICULA,

CON_DSSNASCIMENTOLOCAL COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS CON_DSSNASCIMENTOLOCAL,
CON_DSSNOMECOMPLETO COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS CON_DSSNOMECOMPLETO,
CON_DSSNOMEMAE COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS CON_DSSNOMEMAE,
CON_NUSNUMEROCARPROF,
CON_DSSENDERECONUMERO,
Case When REPLACE(REPLACE(CON_NUSNUMEROPIS, '.', ''), '-', '') Is Null Then '' Else REPLACE(REPLACE(CON_NUSNUMEROPIS, '.', ''), '-', '') End As CON_NUSNUMEROPIS,
CON_COSTELEFONERAMAL,
CON_COSNUMERORG,
CASE
	WHEN CON_DTDEMISSAORG = NULL THEN ''
	ELSE CONVERT(varchar(10), CON_DTDEMISSAORG, 103)
END CON_DTDEMISSAORG,

CON_COSORGAORG,
RG.EST_CdsSiglaEstado CON_CDIESTADO_ORGAORG,
CON_NUSSERIECARPROF,
upper(sex_d1ssexo) as CON_CDISEXO,
REPLACE(REPLACE(COE_NUSTELEFONECELULAR, '.', ''), '-', '') AS COE_NUSTELEFONECELULAR,
REPLACE(REPLACE(CON_NUSTELEFONENUMERO_RESID, '.', ''), '-', '') AS CON_NUSTELEFONENUMERO_RESID,
CASE
	When CON_CDIVINCULO = 1 THEN 'CLT'
	When CON_CDIVINCULO = 9 THEN 'ESTAGIARIO'
	When CON_CdiVinculo = 5 Then 'MENOR_APRENDIZ'
End AS CON_CDIVINCULO,
CP.EST_CdsSiglaEstado CON_CDIESTADO_CARPROF,

'475009' AS CODIGOEMPRESA,
'1278313' AS CODIGOUSUARIO, 
'61624d8714ac916' AS CHAVEACESSO,
'475009' AS CODIGOEMPRESAPRINCIPAL,
'239116' AS CODIGORESPONSAVEL,

'ATIVO' AS SITUACAO_CARGO,
SUBSTRING(CODBRASILEIROOCUPACOES.CBO_COSCODBRASILEIROOCUPACAO, 1, 4)
+ '.'
+ SUBSTRING(CODBRASILEIROOCUPACOES.CBO_COSCODBRASILEIROOCUPACAO, 6, 2) AS CBO,
CAR_CosCodigoSST,
CARGOS.CAR_D1SCARGO AS NOMECARGO,
'ATIVO' AS SITUACAO_SETOR,
CCU_CosCodigoSST ,
CCU_D1SCENTROCUSTO COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS NOMESETOR,

CCU_CosCodigoSST AS CodigoCCU,
CCU_D1SCENTROCUSTO COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS NOMECCU,

'ATIVO' AS SITUACAO_UNIDADE,

LOC_DSSBAIRRO COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS BAIRROUNIDADE,
REPLACE(LOC_NUSCEP, '-', '') AS CEPUNIDADE,
LOC_DSSMUNICIPIO COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS CIDADEUNIDADE,
EMP_NUSCNPJPREFIXO + '/' + LOC_NUSCNPJSUFIXO AS CODIGOCNPJCEI,
LOC_CDILOCAL,
TP.TEN_D1STIPOENDERECO + ' ' + LOC_DSSENDERECOBASE COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS ENDERECOUNIDADE,
ELO.EST_CdsSiglaEstado AS ESTADOUNIDADE,
LOC_COSINSCRESTADUAL AS INSCRICAOESTADUAL,
LOC_D1SLOCAL COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS NOMEUNIDADE,
LOC_DSSENDERECONUMERO AS NUMEROUNIDADE,
EMP_DSSEMPRESA COLLATE SQL_LATIN1_GENERAL_CP1251_CI_AS AS RAZAOSOCIAL,
SUBSTRING(DEFLOCSEFIP.DLS_COSCNAEFISCAL, 1, 4) +
'-' +
SUBSTRING(DEFLOCSEFIP.DLS_COSCNAEFISCAL, 5, 1) +
'/' +
SUBSTRING(DEFLOCSEFIP.DLS_COSCNAEFISCAL, 6, 2) AS CNAE_7,
VIN_CDICATEGTRABESOC

FROM CONTRATADOS 
INNER JOIN CONTRATADOSEXTRAS  ON (CONTRATADOS.CON_CDICONTRATADO = COE_CDICONTRATADO)
INNER JOIN VINCULOS  ON (VIN_CDIVINCULO = CONTRATADOS.CON_CDIVINCULO)
INNER JOIN FOLHAS  ON (CONTRATADOS.CON_CDIFOLHA = FOL_CDIFOLHA)
INNER JOIN LOCAIS  ON (FOL_CDILOCAL = LOC_CDILOCAL)
INNER JOIN EMPRESAS  ON (LOC_CDIEMPRESA = EMP_CDIEMPRESA)
INNER JOIN CORESPELE  ON (CPL_CDICORPELE = CONTRATADOS.CON_CDICORPELE)
INNER JOIN GRAUSINSTRUCOES  ON (CONTRATADOS.CON_CDIGRAUINSTRUCAO = GIN_CDIGRAUINSTRUCAO)
INNER JOIN ESTADOSCIVIS  ON (CONTRATADOS.CON_CDIESTADOCIVIL = ETC_CDIESTADOCIVIL)
INNER JOIN SEXOS  ON (CONTRATADOS.CON_CDISEXO = SEX_CDISEXO)
INNER JOIN CARGOS  ON (CONTRATADOS.CON_CDICARGO = CAR_CDICARGO)
INNER JOIN CODBRASILEIROOCUPACOES  ON (CAR_CDICODBRASILEIROOCUPACAO = CBO_CDICODBRASILEIROOCUPACAO)
INNER JOIN CENTROSCUSTOS  ON (CONTRATADOS.CON_CDICENTROCUSTO = CCU_CDICENTROCUSTO)
INNER JOIN TIPOSENDERECOS TP  ON (LOC_CDITIPOENDERECO = TP.TEN_CDITIPOENDERECO)
INNER JOIN TIPOSENDERECOS ENDCON ON (CON_CdiTipoEndereco = ENDCON.TEN_CDITIPOENDERECO)
INNER JOIN ESTADOS RES ON (RES.EST_CDIESTADO = CONTRATADOS.CON_CDIESTADO_RESID)
INNER JOIN ESTADOS RG ON (RG.EST_CDIESTADO = CONTRATADOS.CON_CDIESTADO_ORGAORG)
INNER JOIN ESTADOS CP ON (CP.EST_CDIESTADO = CONTRATADOS.CON_CDIESTADO_CARPROF)
INNER JOIN ESTADOS ELO ON (ELO.EST_CDIESTADO = LOCAIS.LOC_CDIESTADO)
LEFT JOIN DEFLOCSEFIP DEFLOCSEFIP  ON (LOCAIS.LOC_CDILOCAL = DEFLOCSEFIP.DLS_CDILOCAL)

/*
LEFT JOIN LogsIntegracoesCampos On (BCO_CdiLogIntegracaoCampo = (
															Select Max(A.BCO_CdiLogIntegracaoCampo) From LogsIntegracoesCampos A
																Inner Join LogsIntegracoesCampos B On (A.BCO_CdiLogIntegracao = B.BCO_CdiLogIntegracao)
															Where A.BCO_DssCampo = 'DATA_HORA_CARGA_INICIAL'
															And (B.BCO_DssCampo = 'CON_NUSCICNUMERO' And B.BCO_DssConteudo_String = ApTenantUser.fncFormataCPF(CON_NusCICNumero))
															)
									)
*/
															

WHERE CON_CDIVINCULO IN (1,5,9)	

AND CON_CdiSituacao Not In (0,99)

)

GO


