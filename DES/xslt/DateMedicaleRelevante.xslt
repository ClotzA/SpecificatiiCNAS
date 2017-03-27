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
		<!--[if lt IE 7 ]>
		<html lang="ro" class="no-js ie6"> <![endif]-->
		<!--[if IE 7 ]>
		<html lang="ro" class="no-js ie7"> <![endif]-->
		<!--[if IE 8 ]>
		<html lang="ro" class="no-js ie8"> <![endif]-->
		<!--[if IE 9 ]>
		<html lang="ro" class="no-js ie9"> <![endif]-->
		<!--[if (gt IE 9)|!(IE)]><!-->
		<html lang="ro" class="no-js"> <!--<![endif]-->
			<head>
			    <!--[if lte IE 7]>
			    <script src="components/ie7/warning.js"></script>
			    <script>window.onload = function () {
			        e("components/ie7/")
			    }</script><![endif]-->
			    <meta charset="utf-8"></meta>
			    <meta name="viewport" content="width=device-width"></meta>
			
			    <title>Dosarul Electronic de Sanatate</title>
				<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"></link>
				<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css"></link>
				<link rel="stylesheet" href="des-app.css"></link>
			
			    <!--[if gte IE 9]>
			    <style type="text/css">
			        .gradient {
			            filter: none;
			        }
			    </style>
			    <![endif]-->
			
			</head>
			<body class="cf">
				<xsl:call-template name="DocumentHeader" />
				<div class="tables">
					<xsl:apply-templates select="cda:component/cda:structuredBody/cda:component/cda:section"/>
				</div>				
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
			</p>
			
			<div id="TOP-USER" ng-if="userData.desPerson" class="ng-scope">
	           <ul>
	               <li>
	                   <div style="color: #008000" class="user-name">Pacient
	                       <xsl:apply-templates select="cda:recordTarget/cda:patientRole/cda:patient/cda:name" />,<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
	                   </div>
	               </li>
	               <li>
	                   <div>
	                       <div>
	                           <div style="display: inline">
	                               <div class="user-name">Dosar de sănătate
	                                   <xsl:apply-templates select="cda:recordTarget/cda:patientRole/cda:patient/cda:name" /><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
	                               </div>
	                           </div>
	                       </div>
	                   </div>
	               </li>
	           </ul>
	       </div>
		</div>		
	</xsl:template>
	
	
	
	<!-- Section templates -->	
	<xsl:template name="BloodTypeOutSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.11.39']">
	</xsl:template>
	
	<xsl:template name="PatientConsentOutSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.11.2']">
	</xsl:template>

	<xsl:template name="EmergencyInformationOutSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.11.16']">
		<xsl:apply-templates select="cda:entry/cda:act"/>
	</xsl:template>

	<xsl:template name="AllergiesOutSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.11.158']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title alergii-intolerante">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
			
	        <xsl:call-template name="Section1"/>
	    </div>		
	</xsl:template>

	<xsl:template name="ChronicDiseaseDetailsOutSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.11.165']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title boli-cronice">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
			
	        <xsl:call-template name="Section2"/>
	    </div>		
	</xsl:template>
			
	<xsl:template name="ClinicalTrialOutSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.11.161']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title boli-cronice">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
			
	        <xsl:call-template name="Section2"/>
	    </div>		
	</xsl:template>

	<xsl:template name="DiseaseOutSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.11.157']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title boli-cronice">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
			
	        <xsl:call-template name="Section3"/>
	    </div>		
	</xsl:template>

	<xsl:template name="MedicalServicesOutSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.11.160']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title servicii-medicale">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
			
	        <xsl:call-template name="Section3"/>
	    </div>		
	</xsl:template>

	<xsl:template name="ProceduresOutSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.11.159']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title proceduri">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
			
	        <xsl:call-template name="Section1"/>
	    </div>		
	</xsl:template>

	<xsl:template name="ImmunizationsOutSection" match="cda:section[cda:templateId/@root='2.16.840.1.113883.3.3368.11.139']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title imunizari">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
			
			<table class="des-section">
	            <thead>
	            <tr>
	                <td style="width: 25%">Data</td>
	                <td style="width: 25%">Vaccin</td>
	                <td style="width: 25%">Varsta</td>
	                <td style="width: 25%">Sursa informaţiei</td>
	            </tr>
	            </thead>
	            <tbody>
	            	<xsl:apply-templates select="cda:entry/cda:substanceAdministration"/>
	            </tbody>
	        </table>
			
	    </div>		
	</xsl:template>

	<xsl:template name="ReportedMedicalHistoryOutDocumentSections" match="cda:section[../../../../cda:templateId/@root='2.16.840.1.113883.3.3368.8.3']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title antecedente">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
	        <table class="des-section">
	            <thead>
	            <tr>
	                <td style="width: 33%">Denumire</td>
	                <td style="width: 33%">Descriere</td>
	                <td style="width: 34%">Sursa informaţiei</td>
	            </tr>
	            </thead>
	            <tbody>
	            	<xsl:apply-templates select="cda:entry/cda:act/cda:entryRelationship/cda:organizer/cda:component/cda:observation"/>
	            </tbody>
	        </table>
	    </div>
	</xsl:template>

	<xsl:template name="ReportedMedicalHistoryOutObservation" match="cda:observation[ancestor::cda:ClinicalDocument[cda:templateId/@root='2.16.840.1.113883.3.3368.8.3']]" priority="2048">
		<xsl:call-template name="CommonObservation3"/>
	</xsl:template>
	
	
	<!-- Act templates -->
	<xsl:template name="AllergiesAllOutAct" match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.11.17']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title alergii-intolerante">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
			
	        <xsl:call-template name="Act1"/>
	    </div>		
	</xsl:template>
	
	<xsl:template name="ArteriovenousFistulaAllOutAct" match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.11.219']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title fistula-arterio-venoasa">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
			
	        <xsl:call-template name="Act1"/>
	    </div>		
	</xsl:template>
	
	<xsl:template name="ChronicDiseasesOutAct" match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.11.27']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title boli-cronice">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
			
	        <xsl:call-template name="Act1"/>
	    </div>		
	</xsl:template>	

	<xsl:template name="CurrentMedicationOutAct" match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.11.32']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title treatment">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
			
        <table class="des-section">
            <thead>
            <tr>
                <td style="width: 50%">Tratament</td>
                <td style="width: 50%">Sursa informaţiei</td>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table class="des-section">
            <thead>
            <tr>
                <td style="width: 50%">Medicamente administrate</td>
                <td style="width: 50%"><div></div></td>
            </tr>
            </thead>
            <tbody>
            	<xsl:apply-templates select="cda:entryRelationship/cda:organizer/cda:component/cda:substanceAdministration"/>
            </tbody>
        </table>
	    </div>		
	</xsl:template>	

	<xsl:template name="HematologicDiseasesAllOutAct" match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.11.215']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title boli-hematologice">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
	        <xsl:call-template name="Act1"/>
	    </div>		
	</xsl:template>	
	
	<xsl:template name="HospitalAdmissionOutAct" match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.11.207']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title boli-hematologice">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
	        <table class="des-section">
	            <thead>
	            <tr>
	                <td style="width: 33%">Internare</td>
	                <td style="width: 33%">Externare</td>
	                <td style="width: 34%">Sursa informaţiei</td>
	            </tr>
	            </thead>
	            <tbody>
	            	<xsl:apply-templates select="cda:entryRelationship/cda:organizer/cda:component/cda:observation"/>
	            </tbody>
	        </table>
	    </div>		
	</xsl:template>	

	<xsl:template name="ProstheticsOutAct" match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.11.19']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title proteze-dispozitive">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
	        <xsl:call-template name="Act1"/>
	    </div>		
	</xsl:template>	

	<xsl:template name="SurgicalProceduresOutAct" match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.11.37']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title proceduri-medicale">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
	        <xsl:call-template name="Act1"/>
	    </div>		
	</xsl:template>	

	<xsl:template name="TransmissibleDiseasesAllOutAct" match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.11.217']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title boli-trans">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
	        <xsl:call-template name="Act1"/>
	    </div>		
	</xsl:template>	

	<xsl:template name="TransplantationOutAct" match="cda:act[cda:templateId/@root='2.16.840.1.113883.3.3368.11.23']">
		<div class="table-row blue-circle">
			<h3 tabindex="0" class="table-row-title transplanturi">
        		<xsl:apply-templates select="cda:code"/>
        	</h3>
	        <xsl:call-template name="Act1"/>
	    </div>		
	</xsl:template>	

	<!-- Generic templates -->
	<xsl:template name="Act1">
        <table class="des-section">
            <thead>
            <tr>
                <td style="width: 33%">Denumire</td>
                <td style="width: 33%">Descriere</td>
                <td style="width: 34%">Sursa informaţiei</td>
            </tr>
            </thead>
            <tbody>
            	<xsl:apply-templates select="cda:entryRelationship/cda:organizer/cda:component/cda:procedure"/>
            	<xsl:apply-templates select="cda:entryRelationship/cda:organizer/cda:component/cda:observation"/>
            </tbody>
        </table>
	</xsl:template>
	
	<xsl:template name="Section1">
        <table class="des-section">
            <thead>
            <tr>
                <td style="width: 33%">Denumire</td>
                <td style="width: 33%">Descriere</td>
                <td style="width: 34%">Sursa informaţiei</td>
            </tr>
            </thead>
            <tbody>
            	<xsl:apply-templates select="cda:entry/cda:procedure"/>
            	<xsl:apply-templates select="cda:entry/cda:observation"/>
            </tbody>
        </table>
	</xsl:template>

	<xsl:template name="Section2">
        <table class="des-section">
            <thead>
            <tr>
            	<td>Data</td>
                <td style="width: 33%">Denumire</td>
                <td style="width: 33%">Descriere</td>
                <td style="width: 34%">Sursa informaţiei</td>
            </tr>
            </thead>
            <tbody>
            	<xsl:apply-templates select="cda:entry/cda:procedure"/>
            	<xsl:apply-templates select="cda:entry/cda:observation"/>
            	<xsl:apply-templates select="cda:entry/cda:organizer/cda:component/cda:observation"/>
            </tbody>
        </table>
	</xsl:template>
	
	<xsl:template name="Section3">
        <table class="des-section">
            <thead>
            <tr>
            	<td>Data</td>
                <td style="width: 50%">Denumire</td>
                <td style="width: 50%">Sursa informaţiei</td>
            </tr>
            </thead>
            <tbody>
            	<xsl:apply-templates select="cda:entry/cda:procedure"/>
            	<xsl:apply-templates select="cda:entry/cda:observation"/>
            	<xsl:apply-templates select="cda:entry/cda:organizer/cda:component/cda:observation"/>
            </tbody>
        </table>
	</xsl:template>
	
	<!-- Observation templates -->
	
	<!-- Cu 3 coloane -->
	<xsl:template name="CommonObservation3" 
					match="cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.11.9'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.11.8'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.11.88'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.11.30'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.11.28'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.11.188'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.11.79'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.11.21'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.11.82'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.11.24']"
					priority="1024"> <!-- priority este pentru diagnosticul de la SubstanceAdministrationObservation -->
		<tr>
	        <td><xsl:value-of select="cda:code/@displayName"/>: 
	        	<xsl:apply-templates select="cda:value"/></td>
	        <td>
	            <div class=""><xsl:value-of select="cda:text"/></div>
	        </td>
	        <td class="not-important">
	        	<xsl:value-of select="cda:entryRelationship/cda:observation/cda:text"/>
	        </td>
		</tr>
	</xsl:template>
	
	<!-- Cu 4 coloane -->
	<xsl:template name="CommonObservation4" 
					match="cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.11.162'
											or cda:templateId/@root='2.16.840.1.113883.3.3368.11.148'
											or cda:templateId/@root='2.16.840.1.113883.3.3368.11.151']"
					priority="1024">
		<tr>
			<td><xsl:call-template name="TS" select="cda:effectiveTime/cda:low"/></td>
	        <td><xsl:apply-templates select="cda:value"/></td>
	        <td>
	            <div class="more-less">
	            	<div class="more-block"><xsl:value-of select="cda:text"/></div>
	            </div>
	        </td>
	        <td class="not-important">
	        	<xsl:value-of select="cda:entryRelationship/cda:observation/cda:text"/>
	        </td>
		</tr>
	</xsl:template>
	
	<!-- fara descriere -->
	<xsl:template name="CommonObservationFaraDescriere" 
					match="cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.11.151'
											or cda:templateId/@root='2.16.840.1.113883.3.3368.11.143'
											or cda:templateId/@root='2.16.840.1.113883.3.3368.11.222'
											or cda:templateId/@root='2.16.840.1.113883.3.3368.11.145']"
					priority="1024">
		<tr>
			<td><xsl:call-template name="TS" select="cda:effectiveTime/cda:low"/></td>
	        <td><xsl:apply-templates select="cda:value"/></td>
	        <td class="not-important">
	        	<xsl:value-of select="cda:entryRelationship/cda:observation/cda:text"/>
	        </td>
		</tr>
	</xsl:template>
	
	<!-- proceduri medicale [cda:templateId/@root='2.16.840.1.113883.3.3368.11.18'] -->
	<xsl:template name="MedicalOutProcedure" match="cda:procedure">
		<tr>
	        <td><xsl:value-of select="cda:code/@displayName"/></td>
	        <td>
	            <div><xsl:value-of select="cda:text"/></div>
	        </td>
	        <td class="not-important">
	        	<xsl:value-of select="cda:entryRelationship/cda:observation/cda:text"/>
	        </td>
		</tr>
	</xsl:template>
	
	<xsl:template name="ContextObservation" match="cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.11.5']">
		<div class="ContextObservation"><xsl:value-of select="cda:text"/></div>
	</xsl:template>
	
	<xsl:template name="HospitalAdmissionOutObservation" 
					match="cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.11.205']">
		<tr>
	        <td>
				<table class="table-v1 w-100">
				     <tbody>
					    <tr>
					         <td class="w-30">Data internarii</td>
					         <td class="w-70"><xsl:call-template name="TS" select="cda:effectiveTime/cda:high"/></td>
					    </tr>
						<xsl:apply-templates select="cda:entryRelationship/cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.11.208']"/>
				 	</tbody>
				</table>
	        </td>
	        <td>
				<table class="table-v1 w-100">
				     <tbody>
					    <tr>
					         <td class="w-30">Data externarii</td>
					         <td class="w-70"><xsl:call-template name="TS" select="cda:effectiveTime/cda:low"/></td>
					    </tr>
						<xsl:apply-templates select="cda:entryRelationship/cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.11.209']"/>
				 	</tbody>
				</table>
	        </td>
	        <td class="not-important">
	        	<xsl:apply-templates select="cda:entryRelationship/cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.11.5']"/>
	        </td>
		</tr>
	</xsl:template>
	
	<xsl:template name="AdmissionDiagnosisOutObservation" match="cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.11.208'
																					or cda:templateId/@root='2.16.840.1.113883.3.3368.11.209']">
	     <tr>
	         <td class="w-30"><xsl:value-of select="cda:code/@displayName"/></td>
	         <td class="w-70">
	             <div><xsl:apply-templates select="cda:value"/></div>
	         </td>
	     </tr>
	</xsl:template>
	
	<xsl:template name="ImmunizationOutAdministration" match="cda:substanceAdministration[cda:templateId/@root='2.16.840.1.113883.3.3368.11.136']">
		<tr>
			<td><xsl:apply-templates select="cda:effectiveTime"/></td>
			<td><xsl:value-of select="cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:name"/></td>
			<td><xsl:apply-templates select="cda:entryRelationship/cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.10.48']/cda:value"/></td>
			<td class="not-important"><xsl:value-of select="cda:entryRelationship/cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.11.5']/cda:text"/></td>
		</tr>
	</xsl:template>
	
	<xsl:template name="SubstanceAdministration" match="cda:substanceAdministration">
		<tr>
	        <td><xsl:apply-templates select="cda:entryRelationship/cda:observation[cda:templateId/@root!='2.16.840.1.113883.3.3368.11.5']"/></td>
	        <td class="not-important">
	        	<xsl:value-of select="cda:entryRelationship/cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.11.5']/cda:text"/>
	        </td>
		</tr>
	</xsl:template>
	
	<xsl:template name="SubstanceAdministrationObservation"
					match="cda:observation[cda:templateId/@root='2.16.840.1.113883.3.3368.10.122'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.10.143'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.10.180'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.10.142'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.10.141'
							or cda:templateId/@root='2.16.840.1.113883.3.3368.10.137']"
					priority="512">
		<div>
			<xsl:value-of select="cda:code/@displayName"/>:
			<xsl:apply-templates select="cda:value"/>
		</div>
	</xsl:template>
	
	
	<xsl:template match="playingEntity">
		<div><xsl:value-of select="code/@displayName"/>, 
			<xsl:apply-templates select="name"/>
		</div>
	</xsl:template>
	
	<xsl:template match="scopingEntity">
		<div><xsl:value-of select="desc"/></div>
	</xsl:template>
	
	<!-- Common templates -->
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

	<xsl:template name="IVL_TS" match="cda:effectiveTime[cda:low]">
		<xsl:if test="cda:low">
			<xsl:text>din </xsl:text><xsl:call-template name="TS"/>
		</xsl:if>
		<xsl:if test="cda:high">
			<xsl:text> pana la </xsl:text><xsl:call-template name="TS"/>
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
		<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
		<script><![CDATA[
		$(function () {
			$(".TS").text(function (index, theValue) {
				return theValue.substring(6, 8) + "." + theValue.substring(4, 6) + "." + theValue.substring(0,4);
			});
			
			// The height of the content block when it's not expanded
			var adjustheight = 80;
			// The "more" link text
			var moreText = "+  More";
			// The "less" link text
			var lessText = "- Less";
			
			// Sets the .more-block div to the specified height and hides any content that overflows
			$(".more-less .more-block").css('height', adjustheight).css('overflow', 'hidden');
			
			// The section added to the bottom of the "more-less" div
			$(".more-less").append('
			[…]
			
			');
			// Set the "More" text
			$("a.adjust").text(moreText);
			
			$(".adjust").toggle(function() {
					$(this).parents("div:first").find(".more-block").css('height', 'auto').css('overflow', 'visible');
					// Hide the [...] when expanded
					$(this).parents("div:first").find("p.continued").css('display', 'none');
					$(this).text(lessText);
				}, function() {
					$(this).parents("div:first").find(".more-block").css('height', adjustheight).css('overflow', 'hidden');
					$(this).parents("div:first").find("p.continued").css('display', 'block');
					$(this).text(moreText);
			});		
		});	
		]]></script>
	</xsl:template>
	
</xsl:stylesheet>