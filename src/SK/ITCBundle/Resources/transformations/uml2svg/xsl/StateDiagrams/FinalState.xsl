<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:UML="org.omg.xmi.namespace.UML">
	<xsl:import href="../Common/Styling.xsl" />
	<xsl:import href="../Common/StereotypeCompartment.xsl" />
	<xsl:import href="../Common/Name.xsl" />

	<xsl:output
		media-type="image/svg+xml"
		method="xml"
		indent="yes" />

	<!-- Final State -->
	<xsl:template name="FinalState">

		<xsl:variable
			name="SemanticID"
			select="UML:GraphElement.semanticModel/UML:Uml1SemanticModelBridge/UML:Uml1SemanticModelBridge.element/*/@xmi.idref" />

		<!-- Main FinalState group -->
		<g
			id="{@xmi.id}"
			transform="translate({UML:GraphElement.position/XMI.field[1]}, {UML:GraphElement.position/XMI.field[2]})">
			<xsl:apply-templates
				select="."
				mode="FontStyle" />
			<xsl:apply-templates
				select="."
				mode="StrokeStyle" />
			<xsl:apply-templates
				select="."
				mode="isVisible" />

			<title>
				<xsl:value-of select="key('xmi.id', $SemanticID)/@name" />
			</title>
			<desc>
				<xsl:text>FinalState</xsl:text>
			</desc>

			<!-- State outline variables -->
			<xsl:variable
				name="rx"
				select="UML:GraphNode.size/XMI.field[1] div 2" />
			<xsl:variable
				name="ry"
				select="UML:GraphNode.size/XMI.field[2] div 2" />

			<!-- The outline shape, a double circle -->
			<ellipse
				cx="{$rx}"
				cy="{$ry}"
				rx="{$rx}"
				ry="{$ry}">
				<xsl:apply-templates
					select="."
					mode="FillStyle" />
			</ellipse>
			<ellipse
				cx="{$rx}"
				cy="{$ry}"
				rx="{$rx * 0.75}"
				ry="{$ry * 0.75}"
				fill="black"
				stroke="none" />

			<!-- Contained nodes -->
			<xsl:for-each select="UML:GraphElement.contained/UML:GraphNode">
				<xsl:choose>
					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'StereotypeCompartment'">
						<!-- State stereotypes -->
						<xsl:call-template name="StereotypeCompartment" />
					</xsl:when>

					<xsl:when
						test="UML:GraphElement.semanticModel/UML:SimpleSemanticModelElement/@typeInfo = 'Name'">
						<!-- State name -->
						<xsl:call-template name="Name">
							<xsl:with-param
								name="OwnerSemanticID"
								select="$SemanticID" />
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</g>
	</xsl:template>
</xsl:stylesheet>
	