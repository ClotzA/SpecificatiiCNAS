<?xml version="1.0" encoding="utf-8"?>
<!--
  Title: CDA XSL StyleSheet
  Original Filename: cda.xsl
  Version: 3.0.1
  Revision History: 08/12/08 Jingdong Li updated
  Revision History: 12/11/09 KH updated
  Revision History: 03/30/10 Jingdong Li updated
  Revision History: 08/25/10 Jingdong Li updated
  Revision History: 09/17/10 Jingdong Li updated
  Revision History: 01/05/11 Jingdong Li updated
  Revision History: 26/02/14 Bogdan Marin updated
  Revision History: 12/03/14 Cristi Potlog updated
  Specification: ANSI/HL7 CDAR2
  The current version and documentation are available at http://www.lantanagroup.com/resources/tools/.
  We welcome feedback and contributions to tools@lantanagroup.com
  The stylesheet is the cumulative work of several developers; the most significant prior milestones were the foundation work from HL7
  Germany and Finland (Tyylitiedosto) and HL7 US (Calvin Beebe), and the presentation approach from Tony Schaller, medshare GmbH provided at IHIC 2009.
  The stylesheet is addapted and localized to Romanian National EHR System - DES of CNAS (http://des.cnas.ro).
-->
<!-- LICENSE INFORMATION
  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
  You may obtain a copy of the License at  http://www.apache.org/licenses/LICENSE-2.0
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:n1="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output method="html" indent="yes" version="4.01" encoding="ISO-8859-1" doctype-system="http://www.w3.org/TR/html4/strict.dtd" doctype-public="-//W3C//DTD HTML 4.01//EN"/>
	<!-- global variable title -->
	<xsl:variable name="title">
		<xsl:choose>
			<xsl:when test="string-length(/n1:ClinicalDocument/n1:title)  &gt;= 1">
				<xsl:value-of select="/n1:ClinicalDocument/n1:title"/>
			</xsl:when>
			<xsl:when test="/n1:ClinicalDocument/n1:code/@displayName">
				<xsl:value-of select="/n1:ClinicalDocument/n1:code/@displayName"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Document clinic</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- Main -->
	<xsl:template match="/">
		<xsl:apply-templates select="n1:ClinicalDocument"/>
	</xsl:template>
	<!-- produce browser rendered, human readable clinical document -->
	<xsl:template match="n1:ClinicalDocument">
		<html>
			<head>
				<xsl:comment> Do NOT edit this HTML directly: it was generated via an XSLT transformation from a CDA Release 2 XML document. </xsl:comment>
				<title>
					<xsl:value-of select="$title"/>
				</title>
				<xsl:call-template name="addCSS"/>
			</head>
			<body>
				<h1 class="title">
					<xsl:value-of select="$title"/>
				</h1>
				<!-- START display top portion of clinical document -->
				<xsl:call-template name="recordTarget"/>
				<xsl:call-template name="documentGeneral"/>
				<xsl:call-template name="documentationOf"/>
				<xsl:call-template name="author"/>
				<xsl:call-template name="componentof"/>
				<xsl:call-template name="participant"/>
				<xsl:call-template name="dataEnterer"/>
				<xsl:call-template name="authenticator"/>
				<xsl:call-template name="informant"/>
				<xsl:call-template name="informationRecipient"/>
				<xsl:call-template name="legalAuthenticator"/>
				<xsl:call-template name="custodian"/>
				<!-- END display top portion of clinical document -->
				<!-- produce table of contents -->
				<!-- HIDE ToC
				<xsl:if test="not(//n1:nonXMLBody)">
					<xsl:if test="count(/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[n1:section]) &gt; 1">
						<xsl:call-template name="make-tableofcontents"/>
					</xsl:if>
				</xsl:if>
				<hr align="left" size="2"/>
				-->
				<!-- produce human readable document content -->
				<xsl:apply-templates select="n1:component/n1:structuredBody|n1:component/n1:nonXMLBody"/>
				<br/>
				<br/>
			</body>
		</html>
	</xsl:template>
	<!-- generate table of contents -->
	<xsl:template name="make-tableofcontents">
		<h2 class="toc">
			<a name="toc">Cuprins</a>
		</h2>
		<ul>
			<xsl:for-each select="n1:component/n1:structuredBody/n1:component/n1:section/n1:title">
				<li>
					<a href="#{generate-id(.)}">
						<xsl:value-of select="."/>
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	<!-- header elements -->
	<xsl:template name="documentGeneral">
		<table class="header_table">
			<tbody>
				<tr>
					<th width="20%">
						<xsl:text>UUID document</xsl:text>
					</th>
					<td width="80%">
						<xsl:call-template name="show-id">
							<xsl:with-param name="id" select="n1:id"/>
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<th width="20%">
						<xsl:text>Creat pe</xsl:text>
					</th>
					<td width="80%">
						<xsl:call-template name="show-time">
							<xsl:with-param name="datetime" select="n1:effectiveTime"/>
						</xsl:call-template>
					</td>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<!-- confidentiality -->
	<xsl:template name="confidentiality">
		<table class="header_table">
			<tbody>
				<th width="20%">
					<xsl:text>Confidenţialitate</xsl:text>
				</th>
				<td width="80%">
					<xsl:choose>
						<xsl:when test="n1:confidentialityCode/@code  = &apos;N&apos;">
							<xsl:text>Normal</xsl:text>
						</xsl:when>
						<xsl:when test="n1:confidentialityCode/@code  = &apos;R&apos;">
							<xsl:text>Restricted</xsl:text>
						</xsl:when>
						<xsl:when test="n1:confidentialityCode/@code  = &apos;V&apos;">
							<xsl:text>Very restricted</xsl:text>
						</xsl:when>
					</xsl:choose>
					<xsl:if test="n1:confidentialityCode/n1:originalText">
						<xsl:text>&#160;</xsl:text>
						<xsl:value-of select="n1:confidentialityCode/n1:originalText"/>
					</xsl:if>
				</td>
			</tbody>
		</table>
	</xsl:template>
	<!-- author -->
	<xsl:template name="author">
		<xsl:if test="n1:author">
			<table class="header_table">
				<tbody>
					<xsl:for-each select="n1:author/n1:assignedAuthor">
						<tr>
							<th width="20%">
								<xsl:text>Creat de</xsl:text>
							</th>
							<td width="80%">
								<xsl:choose>
									<xsl:when test="n1:assignedPerson/n1:name">
										<xsl:call-template name="show-name">
											<xsl:with-param name="name" select="n1:assignedPerson/n1:name"/>
										</xsl:call-template>
										<xsl:if test="n1:id">
											<xsl:text>&#160;(</xsl:text>
											<xsl:call-template name="show-id">
												<xsl:with-param name="id" select="n1:id"/>
											</xsl:call-template>
											<xsl:text>)</xsl:text>
										</xsl:if>
										<xsl:if test="n1:representedOrganization">
											<xsl:text>,&#160;</xsl:text>
											<xsl:call-template name="show-name">
												<xsl:with-param name="name" select="n1:representedOrganization/n1:name"/>
											</xsl:call-template>
										</xsl:if>
									</xsl:when>
									<xsl:when test="n1:assignedAuthoringDevice/n1:softwareName">
										<xsl:value-of select="n1:assignedAuthoringDevice/n1:softwareName"/>
									</xsl:when>
									<xsl:when test="n1:representedOrganization">
										<xsl:call-template name="show-name">
											<xsl:with-param name="name" select="n1:representedOrganization/n1:name"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="n1:id">
											<xsl:call-template name="show-id"/>
											<br/>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<xsl:if test="n1:addr | n1:telecom">
							<tr>
								<th>
									<xsl:text>Date contact</xsl:text>
								</th>
								<td>
									<xsl:call-template name="show-contactInfo">
										<xsl:with-param name="contact" select="."/>
									</xsl:call-template>
								</td>
							</tr>
						</xsl:if>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!--  authenticator -->
	<xsl:template name="authenticator">
		<xsl:if test="n1:authenticator">
			<table class="header_table">
				<tbody>
					<tr>
						<xsl:for-each select="n1:authenticator">
							<tr>
								<th width="20%">
									<xsl:text>Semnatar digital</xsl:text>
								</th>
								<td width="80%">
									<xsl:call-template name="show-name">
										<xsl:with-param name="name" select="n1:assignedEntity/n1:assignedPerson/n1:name"/>
									</xsl:call-template>
									<xsl:if test="n1:assignedEntity/n1:id">
										<xsl:text>&#160;(</xsl:text>
										<xsl:call-template name="show-id">
											<xsl:with-param name="id" select="n1:assignedEntity/n1:id"/>
										</xsl:call-template>
										<xsl:text>)</xsl:text>
									</xsl:if>
									<xsl:text>&#160;la&#160;</xsl:text>
									<xsl:call-template name="show-time">
										<xsl:with-param name="datetime" select="n1:time"/>
									</xsl:call-template>
								</td>
							</tr>
							<xsl:if test="n1:assignedEntity/n1:addr | n1:assignedEntity/n1:telecom">
								<tr>
									<th>
										<xsl:text>Date contact</xsl:text>
									</th>
									<td width="80%">
										<xsl:call-template name="show-contactInfo">
											<xsl:with-param name="contact" select="n1:assignedEntity"/>
										</xsl:call-template>
									</td>
								</tr>
							</xsl:if>
						</xsl:for-each>
					</tr>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- legalAuthenticator -->
	<xsl:template name="legalAuthenticator">
		<xsl:if test="n1:legalAuthenticator">
			<table class="header_table">
				<tbody>
					<tr>
						<th width="20%">
							<xsl:text>Semnatar legal</xsl:text>
						</th>
						<td width="80%">
							<xsl:call-template name="show-assignedEntity">
								<xsl:with-param name="asgnEntity" select="n1:legalAuthenticator/n1:assignedEntity"/>
							</xsl:call-template>
							<xsl:text>&#160;</xsl:text>
							<xsl:call-template name="show-sig">
								<xsl:with-param name="sig" select="n1:legalAuthenticator/n1:signatureCode"/>
							</xsl:call-template>
							<xsl:if test="n1:legalAuthenticator/n1:time/@value">
								<xsl:text>&#160;la&#160;</xsl:text>
								<xsl:call-template name="show-time">
									<xsl:with-param name="datetime" select="n1:legalAuthenticator/n1:time"/>
								</xsl:call-template>
							</xsl:if>
						</td>
					</tr>
					<xsl:if test="n1:legalAuthenticator/n1:assignedEntity/n1:addr | n1:legalAuthenticator/n1:assignedEntity/n1:telecom">
						<tr>
							<th>
								<xsl:text>Date contact</xsl:text>
							</th>
							<td>
								<xsl:call-template name="show-contactInfo">
									<xsl:with-param name="contact" select="n1:legalAuthenticator/n1:assignedEntity"/>
								</xsl:call-template>
							</td>
						</tr>
					</xsl:if>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- dataEnterer -->
	<xsl:template name="dataEnterer">
		<xsl:if test="n1:dataEnterer">
			<table class="header_table">
				<tbody>
					<tr>
						<th width="20%">
							<xsl:text>Completat de</xsl:text>
						</th>
						<td width="80%">
							<xsl:call-template name="show-assignedEntity">
								<xsl:with-param name="asgnEntity" select="n1:dataEnterer/n1:assignedEntity"/>
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="n1:dataEnterer/n1:assignedEntity/n1:addr | n1:dataEnterer/n1:assignedEntity/n1:telecom">
						<tr>
							<th>
								<xsl:text>Date contact</xsl:text>
							</th>
							<td>
								<xsl:call-template name="show-contactInfo">
									<xsl:with-param name="contact" select="n1:dataEnterer/n1:assignedEntity"/>
								</xsl:call-template>
							</td>
						</tr>
					</xsl:if>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- componentOf -->
	<xsl:template name="componentof">
		<xsl:if test="n1:componentOf">
			<table class="header_table">
				<tbody>
					<xsl:for-each select="n1:componentOf/n1:encompassingEncounter">
						<xsl:if test="n1:id">
							<tr>
								<xsl:choose>
									<xsl:when test="n1:code">
										<th width="20%">
											<xsl:text>ID episod</xsl:text>
										</th>
										<td width="30%">
											<xsl:call-template name="show-id">
												<xsl:with-param name="id" select="n1:id"/>
											</xsl:call-template>
										</td>
										<th width="15%">
											<xsl:text>Tip episod</xsl:text>
										</th>
										<td>
											<xsl:call-template name="show-code">
												<xsl:with-param name="code" select="n1:code"/>
											</xsl:call-template>
										</td>
									</xsl:when>
									<xsl:otherwise>
										<th width="20%">
											<xsl:text>ID episod</xsl:text>
										</th>
										<td>
											<xsl:call-template name="show-id">
												<xsl:with-param name="id" select="n1:id"/>
											</xsl:call-template>
										</td>
									</xsl:otherwise>
								</xsl:choose>
							</tr>
						</xsl:if>
						<tr>
							<th width="20%">
								<xsl:text>Data episod</xsl:text>
							</th>
							<td colspan="3">
								<xsl:if test="n1:effectiveTime">
									<xsl:choose>
										<xsl:when test="n1:effectiveTime/@value">
											<xsl:text>&#160;la&#160;</xsl:text>
											<xsl:call-template name="show-time">
												<xsl:with-param name="datetime" select="n1:effectiveTime"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:when test="n1:effectiveTime/n1:low">
											<xsl:text>&#160;de la&#160;</xsl:text>
											<xsl:call-template name="show-time">
												<xsl:with-param name="datetime" select="n1:effectiveTime/n1:low"/>
											</xsl:call-template>
											<xsl:if test="n1:effectiveTime/n1:high">
												<xsl:text>&#160;până la&#160;</xsl:text>
												<xsl:call-template name="show-time">
													<xsl:with-param name="datetime" select="n1:effectiveTime/n1:high"/>
												</xsl:call-template>
											</xsl:if>
										</xsl:when>
									</xsl:choose>
								</xsl:if>
							</td>
						</tr>
						<xsl:if test="n1:location/n1:healthCareFacility">
							<tr>
								<th width="20%">
									<xsl:text>Loc episod</xsl:text>
								</th>
								<td colspan="3">
									<xsl:choose>
										<xsl:when test="n1:location/n1:healthCareFacility/n1:location/n1:name">
											<xsl:call-template name="show-name">
												<xsl:with-param name="name" select="n1:location/n1:healthCareFacility/n1:location/n1:name"/>
											</xsl:call-template>
											<xsl:for-each select="n1:location/n1:healthCareFacility/n1:serviceProviderOrganization/n1:name">
												<xsl:text>&#160;al&#160;</xsl:text>
												<xsl:call-template name="show-name">
													<xsl:with-param name="name" select="n1:location/n1:healthCareFacility/n1:serviceProviderOrganization/n1:name"/>
												</xsl:call-template>
											</xsl:for-each>
										</xsl:when>
										<xsl:when test="n1:location/n1:healthCareFacility/n1:code">
											<xsl:call-template name="show-code">
												<xsl:with-param name="code" select="n1:location/n1:healthCareFacility/n1:code"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:if test="n1:location/n1:healthCareFacility/n1:id">
												<xsl:text>id:&#160;</xsl:text>
												<xsl:for-each select="n1:location/n1:healthCareFacility/n1:id">
													<xsl:call-template name="show-id">
														<xsl:with-param name="id" select="."/>
													</xsl:call-template>
												</xsl:for-each>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="n1:responsibleParty">
							<tr>
								<th width="20%">
									<xsl:text>Responsabil</xsl:text>
								</th>
								<td colspan="3">
									<xsl:call-template name="show-assignedEntity">
										<xsl:with-param name="asgnEntity" select="n1:responsibleParty/n1:assignedEntity"/>
									</xsl:call-template>
								</td>
							</tr>
						</xsl:if>
						<xsl:if test="n1:responsibleParty/n1:assignedEntity/n1:addr | n1:responsibleParty/n1:assignedEntity/n1:telecom">
							<tr>
								<th width="20%">
									<xsl:text>Date contact</xsl:text>
								</th>
								<td colspan="3">
									<xsl:call-template name="show-contactInfo">
										<xsl:with-param name="contact" select="n1:responsibleParty/n1:assignedEntity"/>
									</xsl:call-template>
								</td>
							</tr>
						</xsl:if>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- custodian -->
	<xsl:template name="custodian">
		<xsl:if test="n1:custodian">
			<table class="header_table">
				<tbody>
					<tr>
						<th width="20%">
							<xsl:text>Unitate medicala</xsl:text>
						</th>
						<td width="80%">
							<xsl:choose>
								<xsl:when test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name">
									<xsl:call-template name="show-name">
										<xsl:with-param name="name" select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:name"/>
									</xsl:call-template>
									<xsl:if test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:id">
										<xsl:text>&#160;(</xsl:text>
										<xsl:call-template name="show-id">
											<xsl:with-param name="id" select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:id"/>
										</xsl:call-template>
										<xsl:text>)</xsl:text>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:for-each select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:id">
										<xsl:call-template name="show-id"/>
										<xsl:if test="position()!=last()">
											<br/>
										</xsl:if>
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<xsl:if test="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:addr |             n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization/n1:telecom">
						<tr>
							<th>
								<xsl:text>Date contact</xsl:text>
							</th>
							<td width="80%">
								<xsl:call-template name="show-contactInfo">
									<xsl:with-param name="contact" select="n1:custodian/n1:assignedCustodian/n1:representedCustodianOrganization"/>
								</xsl:call-template>
							</td>
						</tr>
					</xsl:if>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- documentationOf -->
	<xsl:template name="documentationOf">
		<xsl:if test="n1:documentationOf">
			<table class="header_table">
				<tbody>
					<xsl:for-each select="n1:documentationOf">
						<xsl:if test="n1:serviceEvent/@classCode and n1:serviceEvent/n1:code">
							<xsl:variable name="displayName">
								<xsl:call-template name="show-actClassCode">
									<xsl:with-param name="clsCode" select="n1:serviceEvent/@classCode"/>
								</xsl:call-template>
							</xsl:variable>
							<xsl:if test="$displayName">
								<tr>
									<th width="20%">
										<xsl:call-template name="firstCharCaseUp">
											<xsl:with-param name="data" select="$displayName"/>
										</xsl:call-template>
									</th>
									<td width="80%" colspan="3">
										<xsl:call-template name="show-code">
											<xsl:with-param name="code" select="n1:serviceEvent/n1:code"/>
										</xsl:call-template>
										<xsl:if test="n1:serviceEvent/n1:effectiveTime">
											<xsl:choose>
												<xsl:when test="n1:serviceEvent/n1:effectiveTime/@value">
													<xsl:text>&#160;la&#160;</xsl:text>
													<xsl:call-template name="show-time">
														<xsl:with-param name="datetime" select="n1:serviceEvent/n1:effectiveTime"/>
													</xsl:call-template>
												</xsl:when>
												<xsl:when test="n1:serviceEvent/n1:effectiveTime/n1:low">
													<xsl:text>&#160;de la&#160;</xsl:text>
													<xsl:call-template name="show-time">
														<xsl:with-param name="datetime" select="n1:serviceEvent/n1:effectiveTime/n1:low"/>
													</xsl:call-template>
													<xsl:if test="n1:serviceEvent/n1:effectiveTime/n1:high">
														<xsl:text>&#160;până la&#160;</xsl:text>
														<xsl:call-template name="show-time">
															<xsl:with-param name="datetime" select="n1:serviceEvent/n1:effectiveTime/n1:high"/>
														</xsl:call-template>
													</xsl:if>
												</xsl:when>
											</xsl:choose>
										</xsl:if>
									</td>
								</tr>
							</xsl:if>
						</xsl:if>
						<xsl:for-each select="n1:serviceEvent/n1:performer">
							<xsl:variable name="displayName">
								<xsl:call-template name="show-participationType">
									<xsl:with-param name="ptype" select="@typeCode"/>
								</xsl:call-template>
								<xsl:text>&#160;</xsl:text>
								<xsl:if test="n1:functionCode/@code">
									<xsl:call-template name="show-participationFunction">
										<xsl:with-param name="pFunction" select="n1:functionCode/@code"/>
									</xsl:call-template>
								</xsl:if>
							</xsl:variable>
							<tr>
								<th width="20%">
									<xsl:call-template name="firstCharCaseUp">
										<xsl:with-param name="data" select="$displayName"/>
									</xsl:call-template>
								</th>
								<td width="80%" colspan="3">
									<xsl:call-template name="show-assignedEntity">
										<xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
									</xsl:call-template>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- inFulfillmentOf -->
	<xsl:template name="inFulfillmentOf">
		<xsl:if test="n1:infulfillmentOf">
			<table class="header_table">
				<tbody>
					<xsl:for-each select="n1:inFulfillmentOf">
						<tr>
							<th width="20%">
								<xsl:text>Cu respectarea</xsl:text>
							</th>
							<td width="80%">
								<xsl:for-each select="n1:order">
									<xsl:for-each select="n1:id">
										<xsl:call-template name="show-id"/>
									</xsl:for-each>
									<xsl:for-each select="n1:code">
										<xsl:text>&#160;</xsl:text>
										<xsl:call-template name="show-code">
											<xsl:with-param name="code" select="."/>
										</xsl:call-template>
									</xsl:for-each>
									<xsl:for-each select="n1:priorityCode">
										<xsl:text>&#160;</xsl:text>
										<xsl:call-template name="show-code">
											<xsl:with-param name="code" select="."/>
										</xsl:call-template>
									</xsl:for-each>
								</xsl:for-each>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- informant -->
	<xsl:template name="informant">
		<xsl:if test="n1:informant">
			<table class="header_table">
				<tbody>
					<xsl:for-each select="n1:informant">
						<tr>
							<th width="20%">
								<xsl:text>Sursă informaţie</xsl:text>
							</th>
							<td width="80%">
								<xsl:if test="n1:assignedEntity">
									<xsl:call-template name="show-assignedEntity">
										<xsl:with-param name="asgnEntity" select="n1:assignedEntity"/>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="n1:relatedEntity">
									<xsl:call-template name="show-relatedEntity">
										<xsl:with-param name="relatedEntity" select="n1:relatedEntity"/>
									</xsl:call-template>
								</xsl:if>
							</td>
						</tr>
						<xsl:choose>
							<xsl:when test="n1:assignedEntity/n1:addr | n1:assignedEntity/n1:telecom">
								<tr>
									<th>
										<xsl:text>Date contact</xsl:text>
									</th>
									<td>
										<xsl:if test="n1:assignedEntity">
											<xsl:call-template name="show-contactInfo">
												<xsl:with-param name="contact" select="n1:assignedEntity"/>
											</xsl:call-template>
										</xsl:if>
									</td>
								</tr>
							</xsl:when>
							<xsl:when test="n1:relatedEntity/n1:addr | n1:relatedEntity/n1:telecom">
								<tr>
									<th>
										<xsl:text>Date contact</xsl:text>
									</th>
									<td>
										<xsl:if test="n1:relatedEntity">
											<xsl:call-template name="show-contactInfo">
												<xsl:with-param name="contact" select="n1:relatedEntity"/>
											</xsl:call-template>
										</xsl:if>
									</td>
								</tr>
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- informantionRecipient -->
	<xsl:template name="informationRecipient">
		<xsl:if test="n1:informationRecipient">
			<table class="header_table">
				<tbody>
					<xsl:for-each select="n1:informationRecipient">
						<tr>
							<th width="20%">
								<xsl:text>Destinatar</xsl:text>
							</th>
							<td width="80%">
								<xsl:choose>
									<xsl:when test="n1:intendedRecipient/n1:receivedOrganization/n1:name">
										<xsl:for-each select="n1:intendedRecipient/n1:receivedOrganization">
											<xsl:call-template name="show-name">
												<xsl:with-param name="name" select="n1:name"/>
											</xsl:call-template>
											<xsl:if test="n1:id">
												<xsl:text>&#160;(</xsl:text>
												<xsl:call-template name="show-id">
													<xsl:with-param name="id" select="n1:id"/>
												</xsl:call-template>
												<xsl:text>)</xsl:text>
											</xsl:if>
											<xsl:if test="position() != last()">
												<br/>
											</xsl:if>
										</xsl:for-each>
									</xsl:when>
									<xsl:otherwise>
										<xsl:for-each select="n1:intendedRecipient">
											<xsl:for-each select="n1:id">
												<xsl:call-template name="show-id"/>
											</xsl:for-each>
											<xsl:if test="position() != last()">
												<br/>
											</xsl:if>
											<br/>
										</xsl:for-each>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
						<xsl:if test="n1:intendedRecipient/n1:addr | n1:intendedRecipient/n1:telecom">
							<tr>
								<th>
									<xsl:text>Date contact</xsl:text>
								</th>
								<td>
									<xsl:call-template name="show-contactInfo">
										<xsl:with-param name="contact" select="n1:intendedRecipient"/>
									</xsl:call-template>
								</td>
							</tr>
						</xsl:if>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- participant -->
	<xsl:template name="participant">
		<xsl:if test="n1:participant">
			<table class="header_table">
				<tbody>
					<xsl:for-each select="n1:participant">
						<tr>
							<th width="20%">
								<xsl:variable name="participtRole">
									<xsl:call-template name="translateRoleAssoCode">
										<xsl:with-param name="classCode" select="n1:associatedEntity/@classCode"/>
										<xsl:with-param name="code" select="n1:associatedEntity/n1:code"/>
									</xsl:call-template>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="$participtRole">
										<xsl:call-template name="firstCharCaseUp">
											<xsl:with-param name="data" select="$participtRole"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>Participant</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</th>
							<td width="80%">
								<xsl:if test="n1:functionCode">
									<xsl:call-template name="show-code">
										<xsl:with-param name="code" select="n1:functionCode"/>
									</xsl:call-template>
								</xsl:if>
								<xsl:call-template name="show-associatedEntity">
									<xsl:with-param name="assoEntity" select="n1:associatedEntity"/>
								</xsl:call-template>
								<xsl:if test="n1:time">
									<xsl:if test="n1:time/n1:low">
										<xsl:text>&#160;de la&#160;</xsl:text>
										<xsl:call-template name="show-time">
											<xsl:with-param name="datetime" select="n1:time/n1:low"/>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test="n1:time/n1:high">
										<xsl:text>&#160;până la&#160;</xsl:text>
										<xsl:call-template name="show-time">
											<xsl:with-param name="datetime" select="n1:time/n1:high"/>
										</xsl:call-template>
									</xsl:if>
								</xsl:if>
								<xsl:if test="position() != last()">
									<br/>
								</xsl:if>
							</td>
						</tr>
						<xsl:if test="n1:associatedEntity/n1:addr | n1:associatedEntity/n1:telecom">
							<tr>
								<th>
									<xsl:text>Date contact</xsl:text>
								</th>
								<td>
									<xsl:call-template name="show-contactInfo">
										<xsl:with-param name="contact" select="n1:associatedEntity"/>
									</xsl:call-template>
								</td>
							</tr>
						</xsl:if>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- recordTarget -->
	<xsl:template name="recordTarget">
		<table class="header_table">
			<tbody>
				<xsl:for-each select="/n1:ClinicalDocument/n1:recordTarget/n1:patientRole">
					<xsl:if test="not(n1:id/@nullFlavor)">
						<tr>
							<th width="20%">
								<xsl:text>Pacient</xsl:text>
							</th>
							<td colspan="3">
								<xsl:call-template name="show-name">
									<xsl:with-param name="name" select="n1:patient/n1:name"/>
								</xsl:call-template>
							</td>
						</tr>
						<tr>
							<th width="20%">
								<xsl:text>Data naşterii</xsl:text>
							</th>
							<td width="30%">
								<xsl:call-template name="show-time">
									<xsl:with-param name="datetime" select="n1:patient/n1:birthTime"/>
								</xsl:call-template>
							</td>
							<th width="15%">
								<xsl:text>Sex</xsl:text>
							</th>
							<td>
								<xsl:for-each select="n1:patient/n1:administrativeGenderCode">
									<xsl:call-template name="show-gender"/>
								</xsl:for-each>
							</td>
						</tr>
						<xsl:if test="n1:patient/n1:raceCode | (n1:patient/n1:ethnicGroupCode)">
							<tr>
								<th width="20%">
									<xsl:text>Rasă</xsl:text>
								</th>
								<td width="30%">
									<xsl:choose>
										<xsl:when test="n1:patient/n1:raceCode">
											<xsl:for-each select="n1:patient/n1:raceCode">
												<xsl:call-template name="show-race-ethnicity"/>
											</xsl:for-each>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>informaţii necompletate</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<th width="15%">
									<xsl:text>Etnie</xsl:text>
								</th>
								<td>
									<xsl:choose>
										<xsl:when test="n1:patient/n1:ethnicGroupCode">
											<xsl:for-each select="n1:patient/n1:ethnicGroupCode">
												<xsl:call-template name="show-race-ethnicity"/>
											</xsl:for-each>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>informaţii necompletate</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:if>
						<tr>
							<th>
								<xsl:text>Date contact</xsl:text>
							</th>
							<td>
								<xsl:call-template name="show-contactInfo">
									<xsl:with-param name="contact" select="."/>
								</xsl:call-template>
							</td>
							<th>
								<xsl:text>ID pacient</xsl:text>
							</th>
							<td>
								<xsl:for-each select="n1:id">
									<xsl:call-template name="show-id"/>
									<br/>
								</xsl:for-each>
							</td>
						</tr>
					</xsl:if>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
	<!-- relatedDocument -->
	<xsl:template name="relatedDocument">
		<xsl:if test="n1:relatedDocument">
			<table class="header_table">
				<tbody>
					<xsl:for-each select="n1:relatedDocument">
						<tr>
							<th width="20%">
								<xsl:text>Document de legătură</xsl:text>
							</th>
							<td width="80%">
								<xsl:for-each select="n1:parentDocument">
									<xsl:for-each select="n1:id">
										<xsl:call-template name="show-id"/>
										<br/>
									</xsl:for-each>
								</xsl:for-each>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- authorization (consent) -->
	<xsl:template name="authorization">
		<xsl:if test="n1:authorization">
			<table class="header_table">
				<tbody>
					<xsl:for-each select="n1:authorization">
						<tr>
							<th width="20%">
								<xsl:text>Consimţământ</xsl:text>
							</th>
							<td width="80%">
								<xsl:choose>
									<xsl:when test="n1:consent/n1:code">
										<xsl:call-template name="show-code">
											<xsl:with-param name="code" select="n1:consent/n1:code"/>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="show-code">
											<xsl:with-param name="code" select="n1:consent/n1:statusCode"/>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
								<br/>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- setAndVersion -->
	<xsl:template name="setAndVersion">
		<xsl:if test="n1:setId and n1:versionNumber">
			<table class="header_table">
				<tbody>
					<tr>
						<td width="20%">
							<xsl:text>Dată versiune</xsl:text>
						</td>
						<td colspan="3">
							<xsl:text>ID set:&#160;</xsl:text>
							<xsl:call-template name="show-id">
								<xsl:with-param name="id" select="n1:setId"/>
							</xsl:call-template>
							<xsl:text>&#160;Versiune:&#160;</xsl:text>
							<xsl:value-of select="n1:versionNumber/@value"/>
						</td>
					</tr>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<!-- show StructuredBody  -->
	<xsl:template match="n1:component/n1:structuredBody">
		<xsl:for-each select="n1:component/n1:section">
			<xsl:call-template name="section"/>
		</xsl:for-each>
	</xsl:template>
	<!-- show nonXMLBody -->
	<xsl:template match='n1:component/n1:nonXMLBody'>
		<xsl:choose>
			<!-- if there is a reference, use that in an IFRAME -->
			<xsl:when test='n1:text/n1:reference'>
				<IFRAME name='nonXMLBody' id='nonXMLBody' WIDTH='80%' HEIGHT='600' src='{n1:text/n1:reference/@value}'/>
			</xsl:when>
			<xsl:when test='n1:text/@mediaType="text/plain"'>
				<pre>
					<xsl:value-of select='n1:text/text()'/>
				</pre>
			</xsl:when>
			<xsl:otherwise>
				<CENTER>Nu se poate afişa textul</CENTER>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- top level component/section:
		display title and text, and process any nested component/sections
		NEW: when no title found, show section code displayName 
		NEW: when no text found, generate narrative from section entries
   -->
	<xsl:template name="section">
		<xsl:choose>
			<xsl:when test="n1:title">
				<xsl:call-template name="section-title">
					<xsl:with-param name="title" select="n1:title"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="section-code">
					<xsl:with-param name="code" select="n1:code"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name="section-author"/>
		<xsl:choose>
			<xsl:when test="n1:text">
				<xsl:call-template name="section-text"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="section-entries"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="n1:component/n1:section">
			<xsl:call-template name="nestedSection">
				<xsl:with-param name="margin" select="2"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<!-- top level section title -->
	<xsl:template name="section-title">
		<xsl:param name="title"/>
		<xsl:choose>
			<xsl:when test="count(/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[n1:section]) &gt; 1">
				<h2 class="section">
					<a name="{generate-id($title)}" href="#toc">
						<xsl:value-of select="$title"/>
					</a>
				</h2>
			</xsl:when>
			<xsl:otherwise>
				<h2 class="section">
					<xsl:value-of select="$title"/>
				</h2>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- section author -->
	<xsl:template name="section-author">
		<xsl:if test="count(n1:author)&gt;0">
			<div style="margin-left : 2em;">
				<b>
					<xsl:text>Autor secţiune:&#160;</xsl:text>
				</b>
				<xsl:for-each select="n1:author/n1:assignedAuthor">
					<xsl:choose>
						<xsl:when test="n1:assignedPerson/n1:name">
							<xsl:call-template name="show-name">
								<xsl:with-param name="name" select="n1:assignedPerson/n1:name"/>
							</xsl:call-template>
							<xsl:if test="n1:representedOrganization">
								<xsl:text>,&#160;</xsl:text>
								<xsl:call-template name="show-name">
									<xsl:with-param name="name" select="n1:representedOrganization/n1:name"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:when test="n1:assignedAuthoringDevice/n1:softwareName">
							<xsl:value-of select="n1:assignedAuthoringDevice/n1:softwareName"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:for-each select="n1:id">
								<xsl:call-template name="show-id"/>
								<br/>
							</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<br/>
			</div>
		</xsl:if>
	</xsl:template>
	<!-- top level section code -->
	<xsl:template name="section-code">
		<xsl:param name="code"/>
		<xsl:choose>
			<xsl:when test="count(/n1:ClinicalDocument/n1:component/n1:structuredBody/n1:component[n1:section]) &gt; 1">
				<h2 class="section">
					<a name="{generate-id($code/@displayName)}" href="#toc">
						<xsl:value-of select="$code/@displayName"/>
					</a>
				</h2>
			</xsl:when>
			<xsl:otherwise>
				<h2 class="section">
					<xsl:value-of select="$code/@displayName"/>
				</h2>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- parse section entries -->
	<xsl:template name="section-entries">
		<ol>
			<xsl:call-template name="entry-observation"/>
			<xsl:call-template name="entry-act"/>
			<xsl:call-template name="entry-encounter"/>
			<xsl:call-template name="entry-organizer"/>
			<xsl:call-template name="entry-substanceAdministration"/>
		</ol>
	</xsl:template>
	<!-- parse section entries: act -->
	<xsl:template name="act">
		<div>
			<b>
				<xsl:value-of select="n1:code/@displayName"/>
			</b>
			<xsl:if test="n1:value/@displayName">
				<xsl:text>:&#160;</xsl:text>
				<xsl:value-of select="n1:value/@displayName"/>
			</xsl:if>
		</div>
		<xsl:for-each select="n1:id">
			<div>
				<b>
					<xsl:value-of select="@root"/>
				</b>
				<xsl:text>:&#160;</xsl:text>
				<xsl:value-of select="@extension"/>
			</div>
		</xsl:for-each>
		<xsl:if test="n1:text">
			<div>
				<xsl:value-of select="n1:text"/>
			</div>
		</xsl:if>
		<xsl:call-template name="participant-inner"/>
		<ol>
			<xsl:call-template name="entryRelationship-observation"/>
			<xsl:call-template name="entryRelationship-act"/>
			<xsl:call-template name="entryRelationship-encounter"/>
			<xsl:call-template name="entryRelationship-organizer"/>
			<xsl:call-template name="entryRelationship-substanceAdministration"/>
		</ol>
	</xsl:template>
	<!-- parse section entries: organizer -->
	<xsl:template name="organizer">
		<div>
			<b>
				<xsl:value-of select="n1:code/@displayName"/>
			</b>
		</div>
		<xsl:call-template name="participant-inner"/>
		<ol>
			<xsl:call-template name="entryRelationship-observation"/>
			<xsl:call-template name="entryRelationship-act"/>
			<xsl:call-template name="entryRelationship-encounter"/>
			<xsl:call-template name="entryRelationship-organizer"/>
			<xsl:call-template name="component-observation"/>
			<xsl:call-template name="component-substanceAdministration"/>
		</ol>
	</xsl:template>
	<!-- parse section entries: observation -->
	<xsl:template name="observation">
		<div>
			<b>
				<xsl:value-of select="n1:code/@displayName"/>
			</b>
			<xsl:if test="n1:value/@displayName">
				<xsl:text>:&#160;</xsl:text>
				<xsl:value-of select="n1:value/@displayName"/>
			</xsl:if>
		</div>
		<xsl:choose>
			<xsl:when test="n1:code/@code = 'context'">
				<!--Informatie de context-->
				<table>
					<tr>
						<td>Dată document sursă</td>
						<td>
							<xsl:call-template name="show-time">
								<xsl:with-param name="datetime" select="n1:effectiveTime"/>
							</xsl:call-template>
						</td>
					</tr>
					<xsl:if test="(n1:participant/n1:participantRole/n1:playingEntity/n1:name)">
						<tr>
							<td>Medic:&#160;</td>
							<td>
								<xsl:value-of select="n1:participant/n1:participantRole/n1:playingEntity/n1:name/n1:family"/>
								<xsl:text>&#160;</xsl:text>
								<xsl:value-of select="n1:participant/n1:participantRole/n1:playingEntity/n1:name/n1:given"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="(n1:participant/n1:participantRole/n1:id)">
						<tr>
							<td>Parafă:&#160;</td>
							<td>
								<xsl:value-of select="n1:participant/n1:participantRole/n1:id/@extension"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="(n1:participant/n1:participantRole/n1:scopingEntity)">
						<tr>
							<td>Instituţie medicală:&#160;</td>
							<td>
								<xsl:value-of select="n1:participant/n1:participantRole/n1:scopingEntity/n1:desc"/>
							</td>
						</tr>
						<tr>
							<td>CUI:&#160;</td>
							<td>
								<xsl:value-of select="n1:participant/n1:participantRole/n1:scopingEntity/n1:id/@extension"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="(n1:text)">
						<tr>
							<td colspan="2">
								<xsl:value-of select="n1:text"/>
							</td>
						</tr>
					</xsl:if>
					<xsl:if test="(n1:reference/n1:externalDocument/n1:id)">
						<tr>
							<td>UUID document extern:&#160;</td>
							<td>
								<xsl:value-of select="n1:reference/n1:externalDocument/n1:id/@extension"/>
							</td>
						</tr>
					</xsl:if>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="n1:effectiveTime">
					<div>
						<xsl:if test="n1:effectiveTime">
							<xsl:choose>
								<xsl:when test="n1:effectiveTime/@value">
									<b>
										<xsl:text>Dată:&#160;</xsl:text>
									</b>
									<xsl:call-template name="show-time">
										<xsl:with-param name="datetime" select="n1:effectiveTime"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="n1:effectiveTime/n1:low">
									<b>
										<xsl:text>De la:&#160;</xsl:text>
									</b>
									<xsl:call-template name="show-time">
										<xsl:with-param name="datetime" select="n1:effectiveTime/n1:low"/>
									</xsl:call-template>
									<xsl:if test="n1:effectiveTime/n1:high">
										<b>
											<xsl:text>Până la:&#160;</xsl:text>
										</b>
										<xsl:call-template name="show-time">
											<xsl:with-param name="datetime" select="n1:effectiveTime/n1:high"/>
										</xsl:call-template>
									</xsl:if>
								</xsl:when>
							</xsl:choose>
						</xsl:if>
					</div>
				</xsl:if>
				<xsl:call-template name="participant-inner"/>
				<xsl:if test="n1:text">
					<div>
						<xsl:value-of select="n1:text"/>
					</div>
				</xsl:if>
				<xsl:if test="n1:value/@value">
					<div>
						<xsl:value-of select="n1:value/@value"/>
						<xsl:if test="n1:value/@unit">
							<xsl:text>&#160;</xsl:text>
							<xsl:value-of select="n1:value/@unit"/>
						</xsl:if>
					</div>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<ol>
			<xsl:call-template name="entryRelationship-encounter"/>
			<xsl:call-template name="entryRelationship-observation"/>
			<xsl:call-template name="entryRelationship-act"/>
			<xsl:call-template name="entryRelationship-organizer"/>
		</ol>
	</xsl:template>
	<!-- parse section entries: encounter -->
	<xsl:template name="encounter">
		<xsl:if test="n1:code/@displayName">
			<div>
				<b>
					<xsl:value-of select="n1:code/@displayName"/>
				</b>
				<xsl:if test="n1:value/@displayName">
					<xsl:text>:&#160;</xsl:text>
					<xsl:value-of select="n1:value/@displayName"/>
				</xsl:if>
			</div>
		</xsl:if>
		<xsl:for-each select="n1:id">
			<div>
				<b>
					<xsl:value-of select="@root"/>
				</b>
				<xsl:text>:&#160;</xsl:text>
				<xsl:value-of select="@extension"/>
			</div>
		</xsl:for-each>
		<xsl:if test="n1:text">
			<div>
				<xsl:value-of select="n1:text"/>
			</div>
		</xsl:if>
	</xsl:template>
	<!-- parse section entries: substanceAdministration -->
	<xsl:template name="substanceAdministration">
		<xsl:if test="n1:effectiveTime">
			<div>
				<xsl:if test="n1:effectiveTime">
					<xsl:choose>
						<xsl:when test="n1:effectiveTime/@value">
							<b>
								<xsl:text>Data:&#160;</xsl:text>
							</b>
							<xsl:call-template name="show-time">
								<xsl:with-param name="datetime" select="n1:effectiveTime"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="n1:effectiveTime/n1:low">
							<b>
								<xsl:text>De la:&#160;</xsl:text>
							</b>
							<xsl:call-template name="show-time">
								<xsl:with-param name="datetime" select="n1:effectiveTime/n1:low"/>
							</xsl:call-template>
							<xsl:if test="n1:effectiveTime/n1:high">
								<b>
									<xsl:text>Până la:&#160;</xsl:text>
								</b>
								<xsl:call-template name="show-time">
									<xsl:with-param name="datetime" select="n1:effectiveTime/n1:high"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
			</div>
		</xsl:if>
		<xsl:if test="n1:text">
			<div>
				<xsl:value-of select="n1:text"/>
			</div>
		</xsl:if>
		<xsl:if test="n1:consumable/n1:manufacturedProduct/n1:manufacturedLabeledDrug/n1:code/@code">
			<div>
				<b>
					<xsl:text>Medicament:&#160;</xsl:text>
				</b>
				<xsl:value-of select="n1:consumable/n1:manufacturedProduct/n1:manufacturedLabeledDrug/n1:code/@code"/>
			</div>
		</xsl:if>
		<xsl:if test="n1:consumable/n1:manufacturedProduct/n1:manufacturedMaterial/n1:code/@displayName">
			<div>
				<b>
					<xsl:text>Substanţă activă:&#160;</xsl:text>
				</b>
				<xsl:value-of select="n1:consumable/n1:manufacturedProduct/n1:manufacturedMaterial/n1:code/@displayName"/>
			</div>
		</xsl:if>
		<ol>
			<xsl:call-template name="participant-inner"/>
			<xsl:call-template name="entryRelationship-observation"/>
		</ol>
	</xsl:template>
	<!-- parse section entries: entryRelationship-encounter -->
	<xsl:template name="entryRelationship-encounter">
		<xsl:for-each select="n1:entryRelationship/n1:encounter">
			<li>
				<xsl:call-template name="encounter"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: entryRelationship-observation -->
	<xsl:template name="entryRelationship-observation">
		<xsl:for-each select="n1:entryRelationship/n1:observation">
			<li>
				<xsl:call-template name="observation"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: entryRelationship-act -->
	<xsl:template name="entryRelationship-act">
		<xsl:for-each select="n1:entryRelationship/n1:act">
			<li>
				<xsl:call-template name="act"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: entryRelationship-organizer -->
	<xsl:template name="entryRelationship-organizer">
		<xsl:for-each select="n1:entryRelationship/n1:organizer">
			<li>
				<xsl:call-template name="organizer"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: entryRelationship-substanceAdministration -->
	<xsl:template name="entryRelationship-substanceAdministration">
		<xsl:for-each select="n1:entryRelationship/n1:substanceAdministration">
			<li>
				<xsl:call-template name="substanceAdministration"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: entry-encounter -->
	<xsl:template name="entry-encounter">
		<xsl:for-each select="n1:entry/n1:encounter">
			<li>
				<xsl:call-template name="encounter"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: entry-observation -->
	<xsl:template name="entry-observation">
		<xsl:for-each select="n1:entry/n1:observation">
			<li>
				<xsl:call-template name="observation"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: entry-act -->
	<xsl:template name="entry-act">
		<xsl:for-each select="n1:entry/n1:act">
			<li>
				<xsl:call-template name="act"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: entry-organizer -->
	<xsl:template name="entry-organizer">
		<xsl:for-each select="n1:entry/n1:organizer">
			<li>
				<xsl:call-template name="organizer"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: entry-substanceAdministration -->
	<xsl:template name="entry-substanceAdministration">
		<xsl:for-each select="n1:entry/n1:substanceAdministration">
			<li>
				<xsl:call-template name="substanceAdministration"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: component-observation -->
	<xsl:template name="component-observation">
		<xsl:for-each select="n1:component/n1:observation">
			<li>
				<xsl:call-template name="observation"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: component-substanceAdministration -->
	<xsl:template name="component-substanceAdministration">
		<xsl:for-each select="n1:component/n1:substanceAdministration">
			<li>
				<xsl:call-template name="substanceAdministration"/>
			</li>
		</xsl:for-each>
	</xsl:template>
	<!-- parse section entries: participant-inner -->
	<xsl:template name="participant-inner">
		<xsl:if test="(n1:participant/n1:participantRole/n1:playingEntity/n1:name)">
			<div>
				<b>
					<xsl:text>Medic:&#160;</xsl:text>
				</b>
				<xsl:value-of select="n1:participant/n1:participantRole/n1:playingEntity/n1:name/n1:family"/>
				<xsl:text>&#160;</xsl:text>
				<xsl:value-of select="n1:participant/n1:participantRole/n1:playingEntity/n1:name/n1:given"/>
			</div>
		</xsl:if>
		<xsl:if test="(n1:participant/n1:participantRole/n1:id)">
			<div>
				<b>
					<xsl:text>Parafa:&#160;</xsl:text>
				</b>
				<xsl:value-of select="n1:participant/n1:participantRole/n1:id/@extension"/>
			</div>
		</xsl:if>
	</xsl:template>
	<!-- top-level section text -->
	<xsl:template name="section-text">
		<div>
			<xsl:apply-templates select="n1:text"/>
		</div>
	</xsl:template>
	<!-- nested component/section -->
	<xsl:template name="nestedSection">
		<xsl:param name="margin"/>
		<h3 style="margin-left : {$margin}em;">
			<xsl:value-of select="n1:title"/>
		</h3>
		<div style="margin-left : {$margin}em;">
			<xsl:apply-templates select="n1:text"/>
		</div>
		<xsl:for-each select="n1:component/n1:section">
			<xsl:call-template name="nestedSection">
				<xsl:with-param name="margin" select="2*$margin"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	<!--   paragraph  -->
	<xsl:template match="n1:paragraph">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<!--   pre format  -->
	<xsl:template match="n1:pre">
		<pre>
			<xsl:apply-templates/>
		</pre>
	</xsl:template>
	<!--   Content w/ deleted text is hidden -->
	<xsl:template match="n1:content[@revised='delete']"/>
	<!--   content  -->
	<xsl:template match="n1:content">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- line break -->
	<xsl:template match="n1:br">
		<xsl:element name='br'>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<!--   list  -->
	<xsl:template match="n1:list">
		<xsl:if test="n1:caption">
			<p>
				<b>
					<xsl:apply-templates select="n1:caption"/>
				</b>
			</p>
		</xsl:if>
		<ul>
			<xsl:for-each select="n1:item">
				<li>
					<xsl:apply-templates/>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	<xsl:template match="n1:list[@listType='ordered']">
		<xsl:if test="n1:caption">
			<span style="font-weight:bold; ">
				<xsl:apply-templates select="n1:caption"/>
			</span>
		</xsl:if>
		<ol>
			<xsl:for-each select="n1:item">
				<li>
					<xsl:apply-templates/>
				</li>
			</xsl:for-each>
		</ol>
	</xsl:template>
	<!--   caption  -->
	<xsl:template match="n1:caption">
		<xsl:apply-templates/>
		<xsl:text>:&#160;</xsl:text>
	</xsl:template>
	<!--  Tables   -->
	<xsl:template match="n1:table/@*|n1:thead/@*|n1:tfoot/@*|n1:tbody/@*|n1:colgroup/@*|n1:col/@*|n1:tr/@*|n1:th/@*|n1:td/@*">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="n1:table">
		<table class="body_table">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	<xsl:template match="n1:thead">
		<thead>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</thead>
	</xsl:template>
	<xsl:template match="n1:tfoot">
		<tfoot>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</tfoot>
	</xsl:template>
	<xsl:template match="n1:tbody">
		<tbody>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</tbody>
	</xsl:template>
	<xsl:template match="n1:colgroup">
		<colgroup>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</colgroup>
	</xsl:template>
	<xsl:template match="n1:col">
		<col>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</col>
	</xsl:template>
	<xsl:template match="n1:tr">
		<tr>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</tr>
	</xsl:template>
	<xsl:template match="n1:th">
		<th>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</th>
	</xsl:template>
	<xsl:template match="n1:td">
		<td>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
		</td>
	</xsl:template>
	<xsl:template match="n1:table/n1:caption">
		<span style="font-weight:bold; ">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<!--   RenderMultiMedia
    this currently only handles GIF's and JPEG's.  It could, however,
    be extended by including other image MIME types in the predicate
    and/or by generating <object> or <applet> tag with the correct
    params depending on the media type  @ID  =$imageRef  referencedObject
    -->
	<xsl:template match="n1:renderMultiMedia">
		<xsl:variable name="imageRef" select="@referencedObject"/>
		<xsl:choose>
			<xsl:when test="//n1:regionOfInterest[@ID=$imageRef]">
				<!-- Here is where the Region of Interest image referencing goes -->
				<xsl:if test="//n1:regionOfInterest[@ID=$imageRef]//n1:observationMedia/n1:value[@mediaType='image/gif' or
 @mediaType='image/jpeg']">
					<br clear="all"/>
					<xsl:element name="img">
						<xsl:attribute name="src">
							<xsl:value-of select="//n1:regionOfInterest[@ID=$imageRef]//n1:observationMedia/n1:value/n1:reference/@value"/>
						</xsl:attribute>
					</xsl:element>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- Here is where the direct MultiMedia image referencing goes -->
				<xsl:if test="//n1:observationMedia[@ID=$imageRef]/n1:value[@mediaType='image/gif' or @mediaType='image/jpeg']">
					<br clear="all"/>
					<xsl:element name="img">
						<xsl:attribute name="src">
							<xsl:value-of select="//n1:observationMedia[@ID=$imageRef]/n1:value/n1:reference/@value"/>
						</xsl:attribute>
					</xsl:element>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--    Stylecode processing
    Supports Bold, Underline and Italics display
    -->
	<xsl:template match="//n1:*[@styleCode]">
		<xsl:if test="@styleCode='Bold'">
			<xsl:element name="b">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:if>
		<xsl:if test="@styleCode='Italics'">
			<xsl:element name="i">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:if>
		<xsl:if test="@styleCode='Underline'">
			<xsl:element name="u">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:if>
		<xsl:if test="contains(@styleCode,'Bold') and contains(@styleCode,'Italics') and not (contains(@styleCode, 'Underline'))">
			<xsl:element name="b">
				<xsl:element name="i">
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<xsl:if test="contains(@styleCode,'Bold') and contains(@styleCode,'Underline') and not (contains(@styleCode, 'Italics'))">
			<xsl:element name="b">
				<xsl:element name="u">
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<xsl:if test="contains(@styleCode,'Italics') and contains(@styleCode,'Underline') and not (contains(@styleCode, 'Bold'))">
			<xsl:element name="i">
				<xsl:element name="u">
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<xsl:if test="contains(@styleCode,'Italics') and contains(@styleCode,'Underline') and contains(@styleCode, 'Bold')">
			<xsl:element name="b">
				<xsl:element name="i">
					<xsl:element name="u">
						<xsl:apply-templates/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<xsl:if test="not (contains(@styleCode,'Italics') or contains(@styleCode,'Underline') or contains(@styleCode, 'Bold'))">
			<xsl:apply-templates/>
		</xsl:if>
	</xsl:template>
	<!--    Superscript or Subscript   -->
	<xsl:template match="n1:sup">
		<xsl:element name="sup">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="n1:sub">
		<xsl:element name="sub">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<!-- show-signature -->
	<xsl:template name="show-sig">
		<xsl:param name="sig"/>
		<xsl:choose>
			<xsl:when test="$sig/@code =&apos;S&apos;">
				<xsl:text>semnat</xsl:text>
			</xsl:when>
			<xsl:when test="$sig/@code=&apos;I&apos;">
				<xsl:text>intenţionat</xsl:text>
			</xsl:when>
			<xsl:when test="$sig/@code=&apos;X&apos;">
				<xsl:text>semnătură necesară</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--  show-id -->
	<xsl:template name="show-id">
		<xsl:param name="id"/>
		<xsl:choose>
			<xsl:when test="not($id)">
				<xsl:if test="not(@nullFlavor)">
					<xsl:choose>
						<xsl:when test=" @root = '2.16.840.1.113883.3.3368' ">
							<xsl:text>DES</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="@root"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="@extension">
						<xsl:text>:&#160;</xsl:text>
						<xsl:value-of select="@extension"/>
					</xsl:if>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not($id/@nullFlavor)">
					<xsl:choose>
						<xsl:when test=" $id/@root = '2.16.840.1.113883.3.3368' ">
							<xsl:text>DES</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$id/@root"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="$id/@extension">
						<xsl:text>:&#160;</xsl:text>
						<xsl:value-of select="$id/@extension"/>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- show-name -->
	<xsl:template name="show-name">
		<xsl:param name="name"/>
		<xsl:choose>
			<xsl:when test="$name/n1:family">
				<xsl:if test="$name/n1:prefix">
					<xsl:value-of select="$name/n1:prefix"/>
					<xsl:text>&#160;</xsl:text>
				</xsl:if>
				<xsl:value-of select="$name/n1:family"/>
				<xsl:text>&#160;</xsl:text>
				<xsl:value-of select="$name/n1:given"/>
				<xsl:if test="$name/n1:suffix">
					<xsl:text>,&#160;</xsl:text>
					<xsl:value-of select="$name/n1:suffix"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$name"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- show-gender -->
	<xsl:template name="show-gender">
		<xsl:choose>
			<xsl:when test="@code = &apos;M&apos;">
				<xsl:text>Masculin</xsl:text>
			</xsl:when>
			<xsl:when test="@code = &apos;F&apos;">
				<xsl:text>Feminin</xsl:text>
			</xsl:when>
			<xsl:when test="@code = &apos;U&apos;">
				<xsl:text>Nedefinit</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- show-race-ethnicity -->
	<xsl:template name="show-race-ethnicity">
		<xsl:choose>
			<xsl:when test="@displayName">
				<xsl:value-of select="@displayName"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@code"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- show-contactInfo -->
	<xsl:template name="show-contactInfo">
		<xsl:param name="contact"/>
		<xsl:call-template name="show-address">
			<xsl:with-param name="address" select="$contact/n1:addr"/>
		</xsl:call-template>
		<xsl:call-template name="show-telecom">
			<xsl:with-param name="telecom" select="$contact/n1:telecom"/>
		</xsl:call-template>
	</xsl:template>
	<!-- show-address -->
	<xsl:template name="show-address">
		<xsl:param name="address"/>
		<xsl:choose>
			<xsl:when test="$address">
				<xsl:if test="$address/@use">
					<xsl:call-template name="translateTelecomCode">
						<xsl:with-param name="code" select="$address/@use"/>
					</xsl:call-template>
					<xsl:text>:&#160;</xsl:text>
				</xsl:if>
				<xsl:if test="string-length($address/n1:city)>0">
					<xsl:value-of select="$address/n1:city"/>
				</xsl:if>
				<xsl:if test="string-length($address/n1:county)>0">
					<xsl:text>,&#160;</xsl:text>
					<xsl:value-of select="$address/n1:county"/>
				</xsl:if>
				<xsl:if test="string-length($address/n1:state)>0">
					<xsl:text>,&#160;</xsl:text>
					<xsl:value-of select="$address/n1:state"/>
				</xsl:if>
				<xsl:if test="string-length($address/n1:postalCode)>0">
					<xsl:text>&#160;</xsl:text>
					<xsl:value-of select="$address/n1:postalCode"/>
				</xsl:if>
				<xsl:if test="string-length($address/n1:country)>0">
					<xsl:text>,&#160;</xsl:text>
					<xsl:value-of select="$address/n1:country"/>
				</xsl:if>
				<xsl:for-each select="$address/n1:streetAddressLine">
					<br/>
					<xsl:value-of select="."/>
				</xsl:for-each>
				<xsl:if test="$address/n1:streetName">
					<br/>
					<xsl:value-of select="$address/n1:streetName"/>
					<xsl:text></xsl:text>
					<xsl:value-of select="$address/n1:houseNumber"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>adresa necompletată</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<br/>
	</xsl:template>
	<!-- show-telecom -->
	<xsl:template name="show-telecom">
		<xsl:param name="telecom"/>
		<xsl:choose>
			<xsl:when test="$telecom">
				<xsl:variable name="type" select="substring-before($telecom/@value, ':')"/>
				<xsl:variable name="value" select="substring-after($telecom/@value, ':')"/>
				<xsl:if test="$type">
					<xsl:call-template name="translateTelecomCode">
						<xsl:with-param name="code" select="$type"/>
					</xsl:call-template>
					<xsl:if test="@use">
						<xsl:text>&#160;(</xsl:text>
						<xsl:call-template name="translateTelecomCode">
							<xsl:with-param name="code" select="@use"/>
						</xsl:call-template>
						<xsl:text>)</xsl:text>
					</xsl:if>
					<xsl:text>:&#160;</xsl:text>
					<xsl:value-of select="$value"/>
					<br/>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- show-recipientType -->
	<xsl:template name="show-recipientType">
		<xsl:param name="typeCode"/>
		<xsl:choose>
			<xsl:when test="$typeCode='PRCP'">Destinatar primar</xsl:when>
			<xsl:when test="$typeCode='TRC'">Destinatar secundar</xsl:when>
			<xsl:otherwise>Destinatar</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Convert Telecom URL to display text -->
	<xsl:template name="translateTelecomCode">
		<xsl:param name="code"/>
		<!--xsl:value-of select="document('voc.xml')/systems/system[@root=$code/@codeSystem]/code[@value=$code/@code]/@displayName"/-->
		<!--xsl:value-of select="document('codes.xml')/*/code[@code=$code]/@display"/-->
		<xsl:choose>
			<!-- lookup table Telecom URI -->
			<xsl:when test="$code='tel'">
				<xsl:text>Tel</xsl:text>
			</xsl:when>
			<xsl:when test="$code='fax'">
				<xsl:text>Fax</xsl:text>
			</xsl:when>
			<xsl:when test="$code='http'">
				<xsl:text>Web</xsl:text>
			</xsl:when>
			<xsl:when test="$code='mailto'">
				<xsl:text>Mail</xsl:text>
			</xsl:when>
			<xsl:when test="$code='H'">
				<xsl:text>Adresă</xsl:text>
			</xsl:when>
			<xsl:when test="$code='HV'">
				<xsl:text>Reşedinţă</xsl:text>
			</xsl:when>
			<xsl:when test="$code='HP'">
				<xsl:text>Dominciliu</xsl:text>
			</xsl:when>
			<xsl:when test="$code='WP'">
				<xsl:text>Serviciu</xsl:text>
			</xsl:when>
			<xsl:when test="$code='PUB'">
				<xsl:text>Pub</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>{$code='</xsl:text>
				<xsl:value-of select="$code"/>
				<xsl:text>'?}</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- convert RoleClassAssociative code to display text -->
	<xsl:template name="translateRoleAssoCode">
		<xsl:param name="classCode"/>
		<xsl:param name="code"/>
		<xsl:choose>
			<xsl:when test="$classCode='AFFL'">
				<xsl:text>affiliate</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='AGNT'">
				<xsl:text>agent</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='ASSIGNED'">
				<xsl:text>assigned entity</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='COMPAR'">
				<xsl:text>commissioning party</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='CON'">
				<xsl:text>contact</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='ECON'">
				<xsl:text>emergency contact</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='NOK'">
				<xsl:text>next of kin</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='SGNOFF'">
				<xsl:text>signing authority</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='GUARD'">
				<xsl:text>guardian</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='GUAR'">
				<xsl:text>guardian</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='CIT'">
				<xsl:text>citizen</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='COVPTY'">
				<xsl:text>covered party</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='PRS'">
				<xsl:text>personal relationship</xsl:text>
			</xsl:when>
			<xsl:when test="$classCode='CAREGIVER'">
				<xsl:text>care giver</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>{$classCode='</xsl:text>
				<xsl:value-of select="$classCode"/>
				<xsl:text>'?}</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="($code/@code) and ($code/@codeSystem='2.16.840.1.113883.5.111')">
			<xsl:text>&#160;</xsl:text>
			<xsl:choose>
				<xsl:when test="$code/@code='FTH'">
					<xsl:text>(Tată)</xsl:text>
				</xsl:when>
				<xsl:when test="$code/@code='MTH'">
					<xsl:text>(Mamă)</xsl:text>
				</xsl:when>
				<xsl:when test="$code/@code='NPRN'">
					<xsl:text>(Părinte natural)</xsl:text>
				</xsl:when>
				<xsl:when test="$code/@code='STPPRN'">
					<xsl:text>(Părinte vitreg)</xsl:text>
				</xsl:when>
				<xsl:when test="$code/@code='SONC'">
					<xsl:text>(Fiu)</xsl:text>
				</xsl:when>
				<xsl:when test="$code/@code='DAUC'">
					<xsl:text>(Fiică)</xsl:text>
				</xsl:when>
				<xsl:when test="$code/@code='CHILD'">
					<xsl:text>(Copil)</xsl:text>
				</xsl:when>
				<xsl:when test="$code/@code='EXT'">
					<xsl:text>(Membru familie)</xsl:text>
				</xsl:when>
				<xsl:when test="$code/@code='NBOR'">
					<xsl:text>(Vecin)</xsl:text>
				</xsl:when>
				<xsl:when test="$code/@code='SIGOTHR'">
					<xsl:text>(Altele)</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>{$code/@code='</xsl:text>
					<xsl:value-of select="$code/@code"/>
					<xsl:text>'?}</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!-- show time -->
	<xsl:template name="show-time">
		<xsl:param name="datetime"/>
		<xsl:choose>
			<xsl:when test="not($datetime)">
				<xsl:call-template name="formatDateTime">
					<xsl:with-param name="date" select="@value"/>
				</xsl:call-template>
				<xsl:text>&#160;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="formatDateTime">
					<xsl:with-param name="date" select="$datetime/@value"/>
				</xsl:call-template>
				<xsl:text>&#160;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- paticipant facility and date -->
	<xsl:template name="facilityAndDates">
		<table class="header_table">
			<tbody>
				<!-- facility id -->
				<tr>
					<th width="20%">
						<xsl:text>ID unitate</xsl:text>
					</th>
					<td colspan="3">
						<xsl:choose>
							<xsl:when test="count(/n1:ClinicalDocument/n1:participant
                                      [@typeCode='LOC'][@contextControlCode='OP']
                                      /n1:associatedEntity[@classCode='SDLOC']/n1:id)&gt;0">
								<!-- change context node -->
								<xsl:for-each select="/n1:ClinicalDocument/n1:participant
                                      [@typeCode='LOC'][@contextControlCode='OP']
                                      /n1:associatedEntity[@classCode='SDLOC']/n1:id">
									<xsl:call-template name="show-id"/>
									<!-- change context node again, for the code -->
									<xsl:for-each select="../n1:code">
										<xsl:text>&#160;(</xsl:text>
										<xsl:call-template name="show-code">
											<xsl:with-param name="code" select="."/>
										</xsl:call-template>
										<xsl:text>)</xsl:text>
									</xsl:for-each>
								</xsl:for-each>
							</xsl:when>
							<xsl:otherwise>Nu e disponibil</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				<!-- Period reported -->
				<tr>
					<th width="20%">
						<xsl:text>Prima zi a perioadei raportate</xsl:text>
					</th>
					<td colspan="3">
						<xsl:call-template name="show-time">
							<xsl:with-param name="datetime" select="/n1:ClinicalDocument/n1:documentationOf
                                      /n1:serviceEvent/n1:effectiveTime/n1:low"/>
						</xsl:call-template>
					</td>
				</tr>
				<tr>
					<th width="20%">
						<xsl:text>Ultima zi a perioadei raportate</xsl:text>
					</th>
					<td colspan="3">
						<xsl:call-template name="show-time">
							<xsl:with-param name="datetime" select="/n1:ClinicalDocument/n1:documentationOf
                                      /n1:serviceEvent/n1:effectiveTime/n1:high"/>
						</xsl:call-template>
					</td>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<!-- show assignedEntity -->
	<xsl:template name="show-assignedEntity">
		<xsl:param name="asgnEntity"/>
		<xsl:choose>
			<xsl:when test="$asgnEntity/n1:assignedPerson/n1:name">
				<xsl:call-template name="show-name">
					<xsl:with-param name="name" select="$asgnEntity/n1:assignedPerson/n1:name"/>
				</xsl:call-template>
				<xsl:if test="$asgnEntity/n1:representedOrganization/n1:name">
					<xsl:text>&#160;al&#160;</xsl:text>
					<xsl:value-of select="$asgnEntity/n1:representedOrganization/n1:name"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$asgnEntity/n1:representedOrganization">
				<xsl:value-of select="$asgnEntity/n1:representedOrganization/n1:name"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$asgnEntity/n1:id">
					<xsl:call-template name="show-id"/>
					<xsl:choose>
						<xsl:when test="position()!=last()">
							<xsl:text>,&#160;</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<br/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- show relatedEntity -->
	<xsl:template name="show-relatedEntity">
		<xsl:param name="relatedEntity"/>
		<xsl:choose>
			<xsl:when test="$relatedEntity/n1:relatedPerson/n1:name">
				<xsl:call-template name="show-name">
					<xsl:with-param name="name" select="$relatedEntity/n1:relatedPerson/n1:name"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- show associatedEntity -->
	<xsl:template name="show-associatedEntity">
		<xsl:param name="assoEntity"/>
		<xsl:choose>
			<xsl:when test="$assoEntity/n1:associatedPerson">
				<xsl:for-each select="$assoEntity/n1:associatedPerson/n1:name">
					<xsl:call-template name="show-name">
						<xsl:with-param name="name" select="."/>
					</xsl:call-template>
					<br/>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$assoEntity/n1:scopingOrganization">
				<xsl:for-each select="$assoEntity/n1:scopingOrganization">
					<xsl:if test="n1:name">
						<xsl:call-template name="show-name">
							<xsl:with-param name="name" select="n1:name"/>
						</xsl:call-template>
						<br/>
					</xsl:if>
					<xsl:if test="n1:standardIndustryClassCode">
						<xsl:value-of select="n1:standardIndustryClassCode/@displayName"/>
						<xsl:text>cod:</xsl:text>
						<xsl:value-of select="n1:standardIndustryClassCode/@code"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$assoEntity/n1:code">
				<xsl:call-template name="show-code">
					<xsl:with-param name="code" select="$assoEntity/n1:code"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$assoEntity/n1:id">
				<xsl:value-of select="$assoEntity/n1:id/@extension"/>
				<xsl:text>&#160;</xsl:text>
				<xsl:value-of select="$assoEntity/n1:id/@root"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- show code (if originalText present, return it, otherwise, check and return attribute: display name) -->
	<xsl:template name="show-code">
		<xsl:param name="code"/>
		<xsl:variable name="this-codeSystem">
			<xsl:value-of select="$code/@codeSystem"/>
		</xsl:variable>
		<xsl:variable name="this-code">
			<xsl:value-of select="$code/@code"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$code/n1:originalText">
				<xsl:value-of select="$code/n1:originalText"/>
			</xsl:when>
			<xsl:when test="$code/@displayName">
				<xsl:value-of select="$code/@displayName"/>
			</xsl:when>
			<!--
      <xsl:when test="$the-valuesets/*/voc:system[@root=$this-codeSystem]/voc:code[@value=$this-code]/@displayName">
        <xsl:value-of select="$the-valuesets/*/voc:system[@root=$this-codeSystem]/voc:code[@value=$this-code]/@displayName"/>
      </xsl:when>
      -->
			<xsl:otherwise>
				<xsl:value-of select="$this-code"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- show classCode -->
	<xsl:template name="show-actClassCode">
		<xsl:param name="clsCode"/>
		<xsl:choose>
			<xsl:when test=" $clsCode = 'ACT' ">
				<xsl:text>serviciu medical</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'ACCM' ">
				<xsl:text>accommodation</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'ACCT' ">
				<xsl:text>account</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'ACSN' ">
				<xsl:text>accession</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'ADJUD' ">
				<xsl:text>adjudecare finaciară</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'CONS' ">
				<xsl:text>consimţământ</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'CONTREG' ">
				<xsl:text>înregistrare recipient</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'CTTEVENT' ">
				<xsl:text>clinical trial timepoint event</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'DISPACT' ">
				<xsl:text>acţiune disciplinară</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'ENC' ">
				<xsl:text>întâlnire</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'INC' ">
				<xsl:text>incident</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'INFRM' ">
				<xsl:text>informare</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'INVE' ">
				<xsl:text>articol facturat</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'LIST' ">
				<xsl:text>listă de lucru</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'MPROT' ">
				<xsl:text>program de monitorizare</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'PCPR' ">
				<xsl:text>îngrijire medicală</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'PROC' ">
				<xsl:text>procedură medicală</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'REG' ">
				<xsl:text>registratură</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'REV' ">
				<xsl:text>revizuire</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'SBADM' ">
				<xsl:text>administrare substanţe</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'SPCTRT' ">
				<xsl:text>tratament specificat</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'SUBST' ">
				<xsl:text>înlocuire</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'TRNS' ">
				<xsl:text>transport</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'VERIF' ">
				<xsl:text>verificare</xsl:text>
			</xsl:when>
			<xsl:when test=" $clsCode = 'XACT' ">
				<xsl:text>tranzacţie financiară</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- show participationType -->
	<xsl:template name="show-participationType">
		<xsl:param name="ptype"/>
		<xsl:choose>
			<xsl:when test=" $ptype='PPRF' ">
				<xsl:text>primary performer</xsl:text>
			</xsl:when>
			<xsl:when test=" $ptype='PRF' ">
				<xsl:text>performer</xsl:text>
			</xsl:when>
			<xsl:when test=" $ptype='VRF' ">
				<xsl:text>verifier</xsl:text>
			</xsl:when>
			<xsl:when test=" $ptype='SPRF' ">
				<xsl:text>secondary performer</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- show participationFunction -->
	<xsl:template name="show-participationFunction">
		<xsl:param name="pFunction"/>
		<xsl:choose>
			<!-- From the HL7 v3 ParticipationFunction code system -->
			<xsl:when test=" $pFunction = 'ADMPHYS' ">
				<xsl:text>(admitting physician)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'ANEST' ">
				<xsl:text>(anesthesist)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'ANRS' ">
				<xsl:text>(anesthesia nurse)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'ATTPHYS' ">
				<xsl:text>(attending physician)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'DISPHYS' ">
				<xsl:text>(discharging physician)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'FASST' ">
				<xsl:text>(first assistant surgeon)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'MDWF' ">
				<xsl:text>(midwife)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'NASST' ">
				<xsl:text>(nurse assistant)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'PCP' ">
				<xsl:text>(primary care physician)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'PRISURG' ">
				<xsl:text>(primary surgeon)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'RNDPHYS' ">
				<xsl:text>(rounding physician)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'SASST' ">
				<xsl:text>(second assistant surgeon)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'SNRS' ">
				<xsl:text>(scrub nurse)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'TASST' ">
				<xsl:text>(third assistant)</xsl:text>
			</xsl:when>
			<!-- From the HL7 v2 Provider Role code system (2.16.840.1.113883.12.443) which is used by HITSP -->
			<xsl:when test=" $pFunction = 'CP' ">
				<xsl:text>(consulting provider)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'PP' ">
				<xsl:text>(primary care provider)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'RP' ">
				<xsl:text>(referring provider)</xsl:text>
			</xsl:when>
			<xsl:when test=" $pFunction = 'MP' ">
				<xsl:text>(medical home provider)</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="formatDateTime">
		<xsl:param name="date"/>
		<!-- day -->
		<xsl:choose>
			<xsl:when test='substring ($date, 7, 1)="0"'>
				<xsl:value-of select="substring ($date, 8, 1)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring ($date, 7, 2)"/>
			</xsl:otherwise>
		</xsl:choose>
		<!-- month -->
		<xsl:variable name="month" select="substring ($date, 5, 2)"/>
		<xsl:choose>
			<xsl:when test="$month='01'">
				<xsl:text>&#160;ianuarie&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$month='02'">
				<xsl:text>&#160;februarie&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$month='03'">
				<xsl:text>&#160;martie&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$month='04'">
				<xsl:text>&#160;aprilie&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$month='05'">
				<xsl:text>&#160;mai&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$month='06'">
				<xsl:text>&#160;iunie&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$month='07'">
				<xsl:text>&#160;iulie&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$month='08'">
				<xsl:text>&#160;august&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$month='09'">
				<xsl:text>&#160;septembrie&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$month='10'">
				<xsl:text>&#160;octombrie&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$month='11'">
				<xsl:text>&#160;noiembrie&#160;</xsl:text>
			</xsl:when>
			<xsl:when test="$month='12'">
				<xsl:text>&#160;decembrie&#160;</xsl:text>
			</xsl:when>
		</xsl:choose>
		<!-- year -->
		<xsl:value-of select="substring ($date, 1, 4)"/>
		<!-- time and US timezone -->
		<xsl:if test="string-length($date) > 8">
			<xsl:text>,&#160;</xsl:text>
			<!-- time -->
			<xsl:variable name="time">
				<xsl:value-of select="substring($date,9,6)"/>
			</xsl:variable>
			<xsl:variable name="hh">
				<xsl:value-of select="substring($time,1,2)"/>
			</xsl:variable>
			<xsl:variable name="mm">
				<xsl:value-of select="substring($time,3,2)"/>
			</xsl:variable>
			<xsl:variable name="ss">
				<xsl:value-of select="substring($time,5,2)"/>
			</xsl:variable>
			<xsl:if test="string-length($hh)&gt;1">
				<xsl:value-of select="$hh"/>
				<xsl:if test="string-length($mm)&gt;1 and not(contains($mm,'-')) and not (contains($mm,'+'))">
					<xsl:text>:</xsl:text>
					<xsl:value-of select="$mm"/>
					<xsl:if test="string-length($ss)&gt;1 and not(contains($ss,'-')) and not (contains($ss,'+'))">
						<xsl:text>:</xsl:text>
						<xsl:value-of select="$ss"/>
					</xsl:if>
				</xsl:if>
			</xsl:if>
			<!-- time zone -->
			<xsl:variable name="tzon">
				<xsl:choose>
					<xsl:when test="contains($date,'+')">
						<xsl:text>+</xsl:text>
						<xsl:value-of select="substring-after($date, '+')"/>
					</xsl:when>
					<xsl:when test="contains($date,'-')">
						<xsl:text>-</xsl:text>
						<xsl:value-of select="substring-after($date, '-')"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:choose>
				<!-- reference: http://www.timeanddate.com/library/abbreviations/timezones/na/ -->
				<xsl:when test="$tzon = '-0500' ">
					<xsl:text>, EST</xsl:text>
				</xsl:when>
				<xsl:when test="$tzon = '-0600' ">
					<xsl:text>, CST</xsl:text>
				</xsl:when>
				<xsl:when test="$tzon = '-0700' ">
					<xsl:text>, MST</xsl:text>
				</xsl:when>
				<xsl:when test="$tzon = '-0800' ">
					<xsl:text>, PST</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>&#160;</xsl:text>
					<xsl:value-of select="$tzon"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<!-- convert to lower case -->
	<xsl:template name="caseDown">
		<xsl:param name="data"/>
		<xsl:if test="$data">
			<xsl:value-of select="translate($data, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
		</xsl:if>
	</xsl:template>
	<!-- convert to upper case -->
	<xsl:template name="caseUp">
		<xsl:param name="data"/>
		<xsl:if test="$data">
			<xsl:value-of select="translate($data,'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
		</xsl:if>
	</xsl:template>
	<!-- convert first character to upper case -->
	<xsl:template name="firstCharCaseUp">
		<xsl:param name="data"/>
		<xsl:if test="$data">
			<xsl:call-template name="caseUp">
				<xsl:with-param name="data" select="substring($data,1,1)"/>
			</xsl:call-template>
			<xsl:value-of select="substring($data,2)"/>
		</xsl:if>
	</xsl:template>
	<!-- show-noneFlavor -->
	<xsl:template name="show-noneFlavor">
		<xsl:param name="nf"/>
		<xsl:choose>
			<xsl:when test=" $nf = 'NI' ">
				<xsl:text>fără informaţii</xsl:text>
			</xsl:when>
			<xsl:when test=" $nf = 'INV' ">
				<xsl:text>incorect</xsl:text>
			</xsl:when>
			<xsl:when test=" $nf = 'MSK' ">
				<xsl:text>mascat</xsl:text>
			</xsl:when>
			<xsl:when test=" $nf = 'NA' ">
				<xsl:text>nu se aplică</xsl:text>
			</xsl:when>
			<xsl:when test=" $nf = 'UNK' ">
				<xsl:text>necunoscut</xsl:text>
			</xsl:when>
			<xsl:when test=" $nf = 'OTH' ">
				<xsl:text>altele</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="addCSS">
		<style type="text/css">
			<xsl:text>
body {
	color: #036;
	background-color: #fff;
	font-family: Verdana, Tahoma, sans-serif;
	font-size: 9pt;
}

hr{
	color: #036;
	width: 100%;
}

a {
	color: #036;
	background-color: #fff;
}

h1 {
	font-size: 13pt;
	font-weight: bold;
}

h2 {
	font-size: 11pt;
	font-weight: bold;
}

h3 {
	font-size: 10pt;
	font-weight: bold;
}

h1.title {
	text-align: center;
}

h2.section {
	text-align: center;
}

h2.toc {
	font-style: italic;
}

div {
	width: 100%;
}

table {
	font-size: 9pt;
	line-height: 11pt;
	width: 100%;
}

tr {
	background-color: #eef;
}

th {
	background-color: #dde;
	color: #013;
}

tbody tr th {
	font-weight: bold;
	text-align: left;
}

td {
	padding: 0.1cm 0.2cm;
	vertical-align: top;
}

.header_table {
	border: 1pt solid #000;
}

.body_table {
	border: 1pt solid #000;
}
			</xsl:text>
		</style>
	</xsl:template>
</xsl:stylesheet>