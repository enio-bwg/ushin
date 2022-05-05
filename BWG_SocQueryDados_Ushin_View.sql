USE [BWG_GA_MT]
GO

/****** Object:  View [ApTenantUser].[BWG_SocQueryDados_Ushin_View]    Script Date: 05/05/2022 14:47:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE OR ALTER     View [ApTenantUser].[BWG_SocQueryDados_Ushin_View] As (

/* Alteracao da Data de Admissao através do objeto 1106 nas transacoes especiais 15950, 15956, 15979 */

	Select
	'ALT DATA ADMISSAO' As Tipo,
	LTR_CdiLogTransacao As LOG,
	LTR_DtdDataHoraTransacaoInicio,
	CdiContratado,
    CAST(DtdAdmissao As DATE) As DtdAdmissao,
	CdiSituacao,
	CdiVinculo,
	SITUACAO_FUNCIONARIO


	From BWG_SocQueryBase_Ushin_View
		Inner Join ContratadosGrades		ON (CRS_CdiContratado = CdiContratado)
		Inner Join LogsTransacoesCampos		ON (LTC_CdiCampo = 29240 And CAST(LTC_DssCampoConteudo As Int) = CRS_CdiContratadoGrade )
		Inner Join LogsTransacoes			ON (LTR_CdiLogTransacao = LTC_CdiLogTransacao)
	Where	LTR_CdiTransacao IN (15950, 15956, 15979)
	And		LTC_CdiCampo = 29240 -- CGC_CdiContratadoGrade

	And     DtdAdmissao >= GETDATE()-5

	And LTR_CdiLogTransacao Not In (
									Select BCO_NuiConteudo_Inteiro From LogsIntegracoes
										Inner Join LogsIntegracoesCampos On (BCO_CdiLogIntegracao = BCG_CdiLogIntegracao)
									Where BCO_DssCampo = 'LOG'
									)

UNION ALL

/* Admissao */

Select
	'ADMISSAO' As Tipo,
	LTR_CdiLogTransacao As LOG,
	LTR_DtdDataHoraTransacaoInicio,
	CdiContratado,
    CAST(DtdAdmissao As DATE) As DtdAdmissao,
	CdiSituacao,
	CdiVinculo,
	SITUACAO_FUNCIONARIO

	From BWG_SocQueryBase_Ushin_View
		Inner Join LogsTransacoesCampos On (LTC_CdiCampo = 9740 And LTC_DssCampoConteudo = CON_NUSCICNUMERO)
		Inner Join LogsTransacoes On (LTR_CdiLogTransacao = LTC_CdiLogTransacao)

			Where LTR_CdiTransacao = 15952
			And LTC_CdiCampo = 9740
			And DtdAdmissao >= GETDATE()-5


	And LTR_CdiLogTransacao Not In (
									Select BCO_NuiConteudo_Inteiro From LogsIntegracoes
										Inner Join LogsIntegracoesCampos On (BCO_CdiLogIntegracao = BCG_CdiLogIntegracao)
									Where BCO_DssCampo = 'LOG'
									)


UNION ALL

/* Alteracao de Dados Pessoais*/

Select
	'ALT DADOS PESSOAIS' As Tipo,
	LTR_CdiLogTransacao As LOG,
	LTR_DtdDataHoraTransacaoInicio,
	CdiContratado,
    CAST(DtdAdmissao As DATE) As DtdAdmissao,
	CdiSituacao,
	CdiVinculo,
	SITUACAO_FUNCIONARIO

	From BWG_SocQueryBase_Ushin_View
		Inner Join LogsTransacoesRegistros on (LTE_CdiCampo_Base = 10430 And LTE_CdiConteudo_Base = CdiContratado)
		Inner Join LogsTransacoesCampos    on (LTC_CdiLogTransacao = LTE_CdiLogTransacao)
		Inner Join LogsTransacoes          on (LTR_CdiLogTransacao = LTC_CdiLogTransacao)
	Where CdiSituacao Not In (0,99) And CdiVinculo In (1,5,9)
	And LTR_CdiTransacao in (15953)
	and ( LTC_CdiCampo = 9398 or LTC_CdiCampo = 9420 or LTC_CdiCampo = 9430 or LTC_CdiCampo = 9444 or LTC_CdiCampo = 9448 or LTC_CdiCampo = 9450 or LTC_CdiCampo = 9460
	or LTC_CdiCampo = 9470 or LTC_CdiCampo = 9490 or LTC_CdiCampo = 9500 or  LTC_CdiCampo = 9520 or LTC_CdiCampo = 9620 or LTC_CdiCampo = 9630 or LTC_CdiCampo = 9640
	or LTC_CdiCampo = 9650 or LTC_CdiCampo = 9740 or LTC_CdiCampo = 9830 or LTC_CdiCampo = 9890 or LTC_CdiCampo = 9900 or LTC_CdiCampo = 9910 or LTC_CdiCampo = 9930
	or LTC_CdiCampo = 10025 or LTC_CdiCampo = 10460 or LTC_CdiCampo = 10500 or LTC_CdiCampo = 10580 or LTC_CdiCampo = 10590 or LTC_CdiCampo = 10600 or LTC_CdiCampo = 10610
	or LTC_CdiCampo = 10957 or LTC_CdiCampo = 91403 or LTC_CdiCampo = 94243 or LTC_CdiCampo = 103540 or LTC_CdiCampo = 127880 or LTC_CdiCampo = 9530)

	And LTR_DtdDataHoraTransacaoInicio >= GETDATE()-5

	And LTR_CdiLogTransacao Not In (
									Select BCO_NuiConteudo_Inteiro From LogsIntegracoes
										Inner Join LogsIntegracoesCampos On (BCO_CdiLogIntegracao = BCG_CdiLogIntegracao)
									Where BCO_DssCampo = 'LOG'
									)


UNION ALL

/* Alteracao de Grades */
Select
	'ALT GRADE' As Tipo,
	LTR_CdiLogTransacao As LOG,
	LTR_DtdDataHoraTransacaoInicio,
	CdiContratado,
    CAST(DtdAdmissao As DATE) As DtdAdmissao,
	CdiSituacao,
	CdiVinculo,
	SITUACAO_FUNCIONARIO

	From BWG_SocQueryBase_Ushin_View
		Inner Join ContratadosGrades On (CRS_CdiContratado = CdiContratado)
		Inner Join ConGradesCargosSalarios On (CRS_CdiContratadoGrade = CGC_CdiContratadoGrade)
		Inner Join LogsTransacoesRegistros on (LTE_CdiCampo_Base = 29230 And LTE_CdiConteudo_Base = CGC_CdiConGradeCargoSalario)
		Inner Join LogsTransacoesCampos    on (LTC_CdiLogTransacao = LTE_CdiLogTransacao)
		Inner Join LogsTransacoes          on (LTR_CdiLogTransacao = LTC_CdiLogTransacao)

	Where LTE_CdiCampo_Base = 29230 And LTE_CdiTabela = 4510
	And LTR_CdiTransacao In (19092, 16201, 23412, 23411, 46732)
	And CdiSituacao Not In (0,2,99)
	And (CGC_OplAltCentroCusto = 1 or CGC_OplAltCargo = 1)

And LTR_DtdDataHoraTransacaoInicio >= GetDate()-5

And LTR_CdiLogTransacao Not In (
								Select BCO_NuiConteudo_Inteiro From LogsIntegracoes
									Inner Join LogsIntegracoesCampos On (BCO_CdiLogIntegracao = BCG_CdiLogIntegracao)
								Where BCO_DssCampo = 'LOG'
								)

UNION ALL

/* Rescisao, Afastamento e Retorno */

Select
	'RESCISAO AFASTAMENTO E RETORNO' As Tipo,
	CST_CdiConSituacao  As LOG,
	CST_DtdSituacaoInicio As 'LTR_DtdDataHoraTransacaoInicio',
	CdiContratado,
    CAST(DtdAdmissao As DATE) As DtdAdmissao,
	CdiSituacao,
	CdiVinculo,
	Case	When CST_CdiSituacao = 1		Then 'ATIVO'
			When CST_CdiSituacao = 9		Then 'FERIAS'
			When CST_CdiSituacao In (0,2,3,99) Then 'INATIVO' Else 'AFASTADO'
	End As SITUACAO_FUNCIONARIO

	From BWG_SocQueryBase_Ushin_View
		Inner Join ConSituacoes On (CST_CdiContratado = CdiContratado)
	Where CST_DtdSituacaoInicio Between GETDATE()-6 and GETDATE()
	And DtdAdmissao <> CST_DtdSituacaoInicio			
	And CST_CdiConSituacao  Not In (
									Select BCO_NuiConteudo_Inteiro From LogsIntegracoes
										Inner Join LogsIntegracoesCampos On (BCO_CdiLogIntegracao = BCG_CdiLogIntegracao)
									Where BCO_DssCampo = 'LOG'
									)


UNION ALL

/* Cancelamento de Afastamento, Rescisao e Retorno */

Select
	'CANCELAMENTO AFAST, RESC E RETORNO' As Tipo,
	LTR_CdiLogTransacao As LOG,
	LTR_DtdDataHoraTransacaoInicio,
	CdiContratado,
    CAST(DtdAdmissao As DATE) As DtdAdmissao,
	CdiSituacao,
	CdiVinculo,
	SITUACAO_FUNCIONARIO

	From BWG_SocQueryBase_Ushin_View
		INNER JOIN (
					Select LTR_CdiLogTransacao, LTR_DtdDataHoraTransacaoInicio, AXP_NuiChaveEscopo
						From LogsTransacoes
						Inner Join LogsTransacoesPrsAgsxEscs on (LTR_CdiLogTransacao = AXP_CdiLogTransacao)
					Where LTR_CdiTransacao in (36801, 36941, 36969, 17704, 15311,24264, 24392)
					And LTR_DtdDataHoraTransacaoInicio >= getdate()-5
					) Logs ON (AXP_NuiChaveEscopo = CdiContratado)

	And LTR_CdiLogTransacao Not In (
									Select BCO_NuiConteudo_Inteiro From LogsIntegracoes
										Inner Join LogsIntegracoesCampos On (BCO_CdiLogIntegracao = BCG_CdiLogIntegracao)
									Where BCO_DssCampo = 'LOG'
									)


UNION ALL
/* Reintegracao */

Select
	'REINTEGRACAO' As Tipo,
	LTR_CdiLogTransacao As LOG,
	LTR_DtdDataHoraTransacaoInicio,
	CdiContratado,
    CAST(DtdAdmissao As DATE) As DtdAdmissao,
	CdiSituacao,
	CdiVinculo,
	SITUACAO_FUNCIONARIO

		From BWG_SocQueryBase_Ushin_View
			Inner Join ContratadosExtras On (COE_CdiContratado = CdiContratado)
			INNER JOIN (
						Select LTR_CdiLogTransacao, LTR_DtdDataHoraTransacaoInicio, LTE_CdiConteudo_Base
							From LogsTransacoes
							Inner Join LogsTransacoesRegistros on (LTR_CdiLogTransacao = LTE_CdiLogTransacao)
						Where LTE_CdiCampo_Base = 15960
					) Logs On (LTE_CdiConteudo_Base = CdiContratado)
		Where CdiSituacao = 1
		AND (CAST(COE_DTDEFETRETTRABALHOREINTEGR as date) = cast(GETDATE() as date))
			OR ( CONVERT(date,COE_DTDEFETRETTRABALHOREINTEGR, 121) < CONVERT(date, GETDATE(), 121)
			AND cast(LTR_DTDDATAHORATRANSACAOINICIO as date) = cast(GETDATE() as date))

		And LTR_CdiLogTransacao Not In (
									Select BCO_NuiConteudo_Inteiro From LogsIntegracoes
										Inner Join LogsIntegracoesCampos On (BCO_CdiLogIntegracao = BCG_CdiLogIntegracao)
									Where BCO_DssCampo = 'LOG'
									)

)
GO


