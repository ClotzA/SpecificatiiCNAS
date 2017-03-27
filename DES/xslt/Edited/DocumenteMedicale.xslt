<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:cda="urn:hl7-org:v3">

	<xsl:template match="/*">
		<html>
			<head>
				<title>Eroare</title>
			</head>
			<body>
				<h1>Eroare</h1>
				<p>Nu este document mdical in format CDA.</p>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="/cda:ClinicalDocument">
		<html>
			<head>
				<title>
					<xsl:value-of select="cda:title" />
				</title>
				<meta name="viewport" content="width=device-width, initial-scale=1.0"></meta>
				<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"></link>
				<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css"></link>

			</head>
			<body>
				<xsl:call-template name="DocumentHeader" />

				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.8']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.176']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.178']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.190']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.3']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.11']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.100']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.45']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.61']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.80']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.51']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.123']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.119']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.171']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.63']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.43']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.160']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.144']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.155']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.157']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.87']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.114']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.111']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.47']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.125']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.192']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.5']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.75']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.115']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.91']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.197']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.201']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.199']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.203']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.205']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.23']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.164']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.44']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.181']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.117']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.151']"/>
				<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.105']"/>
				
				<xsl:call-template name="Scripts" />
				
			</body>
		</html>
	</xsl:template>

	<xsl:template name="DocumentHeader">
		<div class="jumbotron">
			<h1>
				<xsl:value-of select="cda:title" />
			</h1>
			<p>
				<xsl:for-each select="cda:componentOf">
					<xsl:text> </xsl:text>
					<xsl:value-of select="cda:encompassingEncounter/cda:id[@root='Serie']/@extension"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="cda:encompassingEncounter/cda:id[@root='Numar']/@extension"/>
				</xsl:for-each>
				<xsl:for-each select="cda:versionNumber">
					<small>
						<xsl:text> V. </xsl:text>
						<xsl:value-of select="@value" />
					</small>
				</xsl:for-each>
                <xsl:for-each select="cda:relatedDocument">
                    <emp style="color:red"> (acest document a suferit modificari)</emp>
                </xsl:for-each>
			</p>
			<!-- <p>Dosarul Electronic de Sănătate</p> -->
			<p>
				<span class="author">
					<xsl:apply-templates select="cda:author/cda:time" />
				</span>
				|
				<span class="author">
					<xsl:text>dr. </xsl:text>
					<xsl:apply-templates select="cda:author/cda:assignedAuthor/cda:assignedPerson/cda:name"/>
				</span>
				|
 				<span class="custodian ON">
					<xsl:apply-templates
						select="cda:custodian/cda:assignedCustodian/cda:representedCustodianOrganization/cda:name"/>
				</span>
			</p>
		</div>
		
		<div class="well">
			<xsl:call-template name="Row2">
				<xsl:with-param name="label1">Întocmit de</xsl:with-param>
				<xsl:with-param name="value1">
					<xsl:apply-templates select="cda:author/cda:assignedAuthor/cda:assignedPerson/cda:name"/>
				</xsl:with-param>
				<xsl:with-param name="label2">Cod parafă</xsl:with-param>
				<xsl:with-param name="value2"><xsl:apply-templates select="cda:author/cda:assignedAuthor/cda:id"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="Row1">
				<xsl:with-param name="label1">Specializarea</xsl:with-param>
				<xsl:with-param name="value1">
					<xsl:apply-templates select="cda:author/cda:assignedAuthor/cda:code"/>
				</xsl:with-param>
			</xsl:call-template>
		</div>
		<xsl:apply-templates select="cda:recordTarget"/>
	</xsl:template>

	<xsl:template match="cda:recordTarget">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title">Date identificare pacient</h1>
			</div>
			<div class="panel-body">
				<xsl:call-template name="Row2">
					<xsl:with-param name="label1">Nume</xsl:with-param>
					<xsl:with-param name="value1">
						<xsl:apply-templates select="cda:patientRole/cda:patient/cda:name" />
					</xsl:with-param>
					<xsl:with-param name="label2">CID</xsl:with-param>
					<xsl:with-param name="value2">
						<xsl:apply-templates select="cda:patientRole/cda:id" />
					</xsl:with-param>
				</xsl:call-template>

				<xsl:for-each select="cda:patientRole/cda:addr">
					<xsl:call-template name="Row1">
						<xsl:with-param name="label1">Adresa</xsl:with-param>
						<xsl:with-param name="value1">
							<xsl:call-template name="AD"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="HospitalAdmissionDiagnosisSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.176']" priority="1024">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<div class="panel-body">
				<xsl:apply-templates select="cda:entry/cda:observation"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="HospitalAdmissionSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.8']" priority="1024">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<div class="panel-body">
				<xsl:apply-templates select="cda:entry/cda:act"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="ReceivedClinicalReferralSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.190']" priority="1024">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<xsl:apply-templates select="cda:entry/cda:act"/>
		</div>
	</xsl:template>
	
	<xsl:template name="AdultPhysiologicalHistorySection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.45']" priority="1024">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<div class="list-group">
				<xsl:for-each select="cda:entry/cda:observation">
					<div class="list-group-item">
						<xsl:apply-templates select="current()"/>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="AdmissionEvaluationSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.3']" priority="1024">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<div class="panel-body">
				<xsl:apply-templates select="cda:entry/cda:observation"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="AllergiesSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.51']" priority="1024">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<div class="list-group">
				<xsl:for-each select="cda:entry/cda:observation">
					<div class="list-group-item">
						<xsl:apply-templates select="current()">
							<xsl:with-param name="dateLabel">Data diagnosticare alergie</xsl:with-param>
						</xsl:apply-templates>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="BirthSummarySection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.119']" priority="1024">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<div class="list-group">
				<xsl:for-each select="cda:entry/cda:observation">
					<div class="list-group-item">
						<xsl:apply-templates select="current()"/>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="ChildPhysiologicalHistorySection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.61']" priority="1024">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<div class="list-group">
				<xsl:for-each select="cda:entry/cda:observation">
					<div class="list-group-item">
						<xsl:apply-templates select="current()"/>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="ChronicDiseasesSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.10.63']" priority="1024">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<div class="list-group">
				<xsl:for-each select="cda:entry/cda:observation">
					<div class="list-group-item">
						<xsl:apply-templates select="current()"/>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="ObservationSections" match="cda:section[cda:entry/cda:observation]" priority="512">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<div class="list-group">
				<xsl:for-each select="cda:entry/cda:observation">
					<div class="list-group-item">
						<xsl:apply-templates select="current()"/>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="ActSections" match="cda:section[cda:entry/cda:act]" priority="512">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<div class="panel-body">
				<xsl:apply-templates select="cda:entry/cda:act"/>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="DefaultSections" match="cda:section" priority="256">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h1 class="panel-title"><xsl:apply-templates select="cda:code"/></h1>
			</div>
			<div class="list-group">
				<xsl:for-each select="cda:entry">
					<div class="list-group-item">
						<xsl:apply-templates select="current()"/>
					</div>
				</xsl:for-each>
			</div>
		</div>
	</xsl:template>

	
	<xsl:template match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.10.31']" priority="1024">
		<div class="list-group">
			<div class="list-group-item"><xsl:apply-templates select="cda:entryRelationship/cda:encounter"/></div>
			<div class="list-group-item">
				<xsl:call-template name="Row1">
					<xsl:with-param name="label1">Data trimitere</xsl:with-param>
					<xsl:with-param name="value1"><xsl:apply-templates select="cda:effectiveTime"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="serie-numar"/>
				<xsl:call-template name="Row1">
					<xsl:with-param name="label1">Motiv trimitere</xsl:with-param>
					<xsl:with-param name="value1"><xsl:apply-templates select="cda:text"/></xsl:with-param>
				</xsl:call-template>
			</div>
			<xsl:for-each select="current()//cda:observation">
				<div class="list-group-item"><xsl:apply-templates select="current()"/></div>
			</xsl:for-each>
		</div>
	</xsl:template>

	<xsl:template match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.10.9']" priority="1024">
		<xsl:call-template name="Row2">
			<xsl:with-param name="label1">Tip internare</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:priorityCode"/></xsl:with-param>
			<xsl:with-param name="label2">Nastere</xsl:with-param>
			<xsl:with-param name="value2"><xsl:apply-templates select="cda:entryRelationship/cda:observation/cda:value"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="IssuedClinicalReferralAct" match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.10.198' 
															or cda:templateId/@root='2.16.840.1.113883.3.3368.10.202'
															or cda:templateId/@root='2.16.840.1.113883.3.3368.10.200'
															or cda:templateId/@root='2.16.840.1.113883.3.3368.10.204'
															or cda:templateId/@root='2.16.840.1.113883.3.3368.10.206'
															or cda:templateId/@root='2.16.840.1.113883.3.3368.10.32'
															or cda:templateId/@root='2.16.840.1.113883.3.3368.10.33'
															or cda:templateId/@root='2.16.840.1.113883.3.3368.10.34'
															or cda:templateId/@root='2.16.840.1.113883.3.3368.10.183']" priority="1024">
		<xsl:call-template name="Row1">
			<xsl:with-param name="label1">Data trimiterii</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:effectiveTime"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="serie-numar"/>
		<xsl:call-template name="ObservationChildren"/>
		
	</xsl:template>
	
	<xsl:template match="cda:act">
		<xsl:apply-templates select="*[not(self::cda:code)]"/>
	</xsl:template>
	
	<xsl:template match="cda:observation[child::cda:value and child::cda:code]" priority="1024">
		<xsl:call-template name="Row1">
			<xsl:with-param name="label1"><xsl:apply-templates select="cda:code"/></xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:value"/></xsl:with-param>
		</xsl:call-template>
		<xsl:for-each select="cda:text">
			<xsl:call-template name="Row1">
				<xsl:with-param name="label1">Descriere</xsl:with-param>
				<xsl:with-param name="value1"><xsl:apply-templates select="current()"/></xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:call-template name="ObservationChildren"/>
	</xsl:template>

	<xsl:template match="cda:observation[child::cda:text and child::cda:text]" priority="512">
		<xsl:call-template name="Row1">
			<xsl:with-param name="label1"><xsl:apply-templates select="cda:code"/></xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:text"/></xsl:with-param>
		</xsl:call-template>
		<xsl:apply-templates select="cda:entryRelationship/cda:observation | cda:participant"/>
		<xsl:call-template name="ObservationChildren"/>
	</xsl:template>

	<xsl:template match="cda:observation[cda:effectiveTime]" priority="2048">
		<xsl:param name="dateLabel">Data</xsl:param>
		<xsl:choose>
			<xsl:when test="cda:value">
				<xsl:call-template name="Row2">
					<xsl:with-param name="label1"><xsl:apply-templates select="cda:code"/></xsl:with-param>
					<xsl:with-param name="value1"><xsl:apply-templates select="cda:value"/></xsl:with-param>
					<xsl:with-param name="label2"><xsl:value-of select="$dateLabel"/></xsl:with-param>
					<xsl:with-param name="value2"><xsl:apply-templates select="cda:effectiveTime"/></xsl:with-param>
				</xsl:call-template>
				<xsl:for-each select="cda:text">
					<xsl:call-template name="Row1">
						<xsl:with-param name="label1">Descriere</xsl:with-param>
						<xsl:with-param name="value1"><xsl:apply-templates select="current()"/></xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Row2">
					<xsl:with-param name="label1"><xsl:apply-templates select="cda:code"/></xsl:with-param>
					<xsl:with-param name="value1"><xsl:apply-templates select="cda:text"/></xsl:with-param>
					<xsl:with-param name="label2"><xsl:value-of select="$dateLabel"/></xsl:with-param>
					<xsl:with-param name="value2"><xsl:apply-templates select="cda:effectiveTime"/></xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name="ObservationChildren"/>
	</xsl:template>
	
	<xsl:template name="ObservationChildren">
		<xsl:variable name="children" select="cda:entryRelationship/cda:observation | 
												cda:participant | 
												cda:subject | 
												cda:entryRelationship/cda:encounter | 
												cda:entryRelationship/cda:organizer | 
												cda:entryRelationship/cda:substanceAdministration"/>
		<xsl:if test="count($children) &gt; 0">
			<div class="list-group">
				<xsl:for-each select="$children">
					<div class="list-group-item"> 
						<xsl:apply-templates select="current()"/>
					</div>
				</xsl:for-each>
			</div>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="ReferralEncounter" match="cda:encounter[cda:templateId/@root='2.16.840.1.113883.3.3368.10.27'
																or cda:templateId/@root='2.16.840.1.113883.3.3368.10.139']" priority="1024">
		<xsl:call-template name="Row2">
			<xsl:with-param name="label1">Data registru consultatii</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:effectiveTime"/></xsl:with-param>
			<xsl:with-param name="label2">Numar registru consultatii</xsl:with-param>
			<xsl:with-param name="value2"><xsl:apply-templates select="cda:id"/></xsl:with-param>
		</xsl:call-template>
		<xsl:apply-templates select="cda:participant"/>
	</xsl:template>

	<xsl:template name="OutpatientEncounter" match="cda:encounter[cda:templateId/@root='2.16.840.1.113883.3.3368.10.118']" priority="1024">
		<xsl:call-template name="Row2">
			<xsl:with-param name="label1">Data vizitei</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:effectiveTime"/></xsl:with-param>
			<xsl:with-param name="label2">Numarul vizitei</xsl:with-param>
			<xsl:with-param name="value2"><xsl:apply-templates select="cda:id"/></xsl:with-param>
		</xsl:call-template>
		<xsl:apply-templates select="cda:participant"/>
	</xsl:template>
	
	<xsl:template match="cda:participantRole">
		<xsl:call-template name="Row2">
			<xsl:with-param name="label1">Medic</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:playingEntity"/></xsl:with-param>
			<xsl:with-param name="label2">Cod parafa</xsl:with-param>
			<xsl:with-param name="value2"><xsl:apply-templates select="cda:id"/></xsl:with-param>
		</xsl:call-template>
		<xsl:apply-templates select="cda:scopingEntity"/>
	</xsl:template>
	
	<xsl:template match="cda:scopingEntity">
		<xsl:call-template name="Row2">
			<xsl:with-param name="label1">Furnizor servicii medicale</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:desc"/></xsl:with-param>
			<xsl:with-param name="label2">CUI</xsl:with-param>
			<xsl:with-param name="value2"><xsl:apply-templates select="cda:id"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="cda:subject/cda:relatedSubject">
		<xsl:call-template name="Row1">
			<xsl:with-param name="label1">Relatie</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="cda:substanceAdministration">
		<xsl:call-template name="Row1">
			<xsl:with-param name="label1">Medicament</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:consumable"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="Row2">
			<xsl:with-param name="label1">Data administrarii</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:effectiveTime"/></xsl:with-param>
			<xsl:with-param name="label2">Administrare</xsl:with-param>
			<xsl:with-param name="value2"><xsl:apply-templates select="cda:text"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ObservationChildren"/>
	</xsl:template>
	
	<xsl:template name="MedicalProcedure" match="cda:procedure">
		<xsl:call-template name="Row2">
			<xsl:with-param name="label1">Procedura</xsl:with-param>
			<xsl:with-param name="value1">
				<xsl:apply-templates select="cda:code"/>
			</xsl:with-param>
			<xsl:with-param name="label2">Data efectuarii</xsl:with-param>
			<xsl:with-param name="value2"><xsl:apply-templates select="cda:effectiveTime"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="Row1">
			<xsl:with-param name="label1">Descriere</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:text"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="SourcePhysicianParticipant" match="cda:participant[cda:templateId/@root='2.16.840.1.113883.3.3368.10.28']">
		<xsl:call-template name="Row1">
			<xsl:with-param name="label1">Medic</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:participantRole/cda:playingEntity/cda:name"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="Row2">
			<xsl:with-param name="label1">Specialitate medicala</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:participantRole/cda:code"/></xsl:with-param>
			<xsl:with-param name="label2">Cod parafa</xsl:with-param>
			<xsl:with-param name="value2"><xsl:apply-templates select="cda:participantRole/cda:id"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="PhysicianAssignedEntity" match="cda:assignedEntity">
		<xsl:call-template name="Row2">
			<xsl:with-param name="label1">Medic</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:assignedPerson"/></xsl:with-param>
			<xsl:with-param name="label2">Cod parafa</xsl:with-param>
			<xsl:with-param name="value2"><xsl:apply-templates select="cda:id"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="serie-numar">
		<xsl:call-template name="Row2">
			<xsl:with-param name="label1">Serie</xsl:with-param>
			<xsl:with-param name="value1"><xsl:apply-templates select="cda:id[@root='Serie']"></xsl:apply-templates></xsl:with-param>
			<xsl:with-param name="label2">Numar</xsl:with-param>
			<xsl:with-param name="value2"><xsl:apply-templates select="cda:id[@root='Numar']"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="qualifier" match="cda:qualifier">
		<xsl:for-each select="cda:value">- <xsl:call-template name="CD"/></xsl:for-each>
	</xsl:template>

	<xsl:template name="value" match="cda:*[@xsi:type]" priority="512">
		<xsl:value-of select="@value"></xsl:value-of>
	</xsl:template>
	
	<xsl:template name="PQ" match="cda:*[@xsi:type='PQ']" priority="1024">
		<xsl:value-of select="@value"/>
		<xsl:text> </xsl:text>
		<xsl:choose>
			<xsl:when test="@unit='an' and @value = 1">an</xsl:when>
			<xsl:when test="@unit='ln' and @value = 1">luna</xsl:when>
			<xsl:when test="@unit='z' and @value = 1">zi</xsl:when>
			<xsl:when test="@unit='an' and @value != 1">ani</xsl:when>
			<xsl:when test="@unit='ln' and @value != 1">luni</xsl:when>
			<xsl:when test="@unit='z' and @value != 1">zile</xsl:when>
			<xsl:otherwise><xsl:value-of select="@unit"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="BL" match="cda:*[@xsi:type='BL']" priority="1024">
		<xsl:choose>
			<xsl:when test="@value = 'true'">Da</xsl:when>
			<xsl:otherwise>Nu</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="CD" match="cda:*[@xsi:type='CD']" priority="1024">
		<span class="CD">
			<xsl:value-of select="@code"/>
			<xsl:text> (</xsl:text><xsl:value-of select="@displayName"/><xsl:text>)</xsl:text>
		</span>
	</xsl:template>
	
	<xsl:template name="ED" match="cda:*[@xsi:type='ED']" priority="1024">
		<span class="ED"><xsl:value-of select="current()"/></span>
	</xsl:template>
	
	<xsl:template match="cda:addr" name="AD">
		<span class="AD">
			<span class="ADXP"><xsl:value-of select="cda:city"/></span>
			<xsl:text>, </xsl:text>
			<span class="ADXP"><xsl:value-of select="cda:county"/></span>
		</span>
	</xsl:template>
	
	<xsl:template name="PN" match="cda:name[child::cda:given and child::cda:family]">
		<span class="PN">
			<xsl:value-of select="cda:given" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="cda:family" />
		</span>
	</xsl:template>

  	<xsl:template name="ON" match="cda:name">
		<span class="custodian ON">
			<xsl:value-of select="current()" />
		</span>
	</xsl:template>
	
	<xsl:template name="TS" match="cda:time | cda:effectiveTime">
		<span class="TS">
			<xsl:value-of select="current()//@value" />
		</span>
	</xsl:template>

	<xsl:template name="IVL_TS" match="cda:effectiveTime[cda:low or cda:high]">
		<xsl:if test="cda:low">
			<xsl:text>din </xsl:text><xsl:call-template name="TS" select="cda:low"/>
		</xsl:if>
		<xsl:if test="cda:high">
			<xsl:text> pana la </xsl:text><xsl:call-template name="TS" select="cda:high"/>
		</xsl:if>
		<xsl:for-each select="cda:width">
			timp de <xsl:call-template name="PQ"/>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="CE" match="cda:*[@displayName]">
		<span class="CE"><xsl:value-of select="@displayName"/></span>
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template name="II" match="cda:id">
		<span class="II"><xsl:value-of select="@extension"/></span>
	</xsl:template>
	
	<xsl:template name="Field1">
		<xsl:param name="label" />
		<xsl:param name="value" />
		<div class="row">
			<div class="col-sm-2">
				<strong>
					<xsl:value-of select="$label" />
					<xsl:text>:</xsl:text>
				</strong>
			</div>
			<div class="col-sm-10">
				<xsl:copy-of select="$value" />
			</div>
		</div>
	</xsl:template>
	<xsl:template name="Field2">
		<xsl:param name="label" />
		<xsl:param name="value" />
		<div class="row">
			<div class="col-sm-4">
				<strong>
					<xsl:value-of select="$label" />
					<xsl:text>:</xsl:text>
				</strong>
			</div>
			<div class="col-sm-8">
				<xsl:copy-of select="$value" />
			</div>
		</div>
	</xsl:template>

	<xsl:template name="Row2">
		<xsl:param name="label1" />
		<xsl:param name="value1" />
		<xsl:param name="value2" />
		<xsl:param name="label2" />
		<div class="row">
			<div class="col-sm-6">
				<xsl:call-template name="Field2">
					<xsl:with-param name="label">
						<xsl:value-of select="$label1" />
					</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:copy-of select="$value1" />
					</xsl:with-param>
				</xsl:call-template>
			</div>
			<div class="col-sm-6">
				<xsl:call-template name="Field2">
					<xsl:with-param name="label">
						<xsl:value-of select="$label2" />
					</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:copy-of select="$value2" />
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="Row1">
		<xsl:param name="label1" />
		<xsl:param name="value1" />
		<div class="row">
			<div class="col-sm-12">
				<xsl:call-template name="Field1">
					<xsl:with-param name="label">
						<xsl:value-of select="$label1" />
					</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:copy-of select="$value1" />
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="Scripts">
		<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
		<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
		<script><![CDATA[
		$(function () {
			$(".TS").text(function (index, theValue) {
				return theValue.substring(6, 8) + "." + theValue.substring(4, 6) + "." + theValue.substring(0,4);
			});
		});	
		]]></script>
	</xsl:template>
</xsl:stylesheet>