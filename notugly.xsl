<?xml version="1.0" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" 
    xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg">
<xsl:output method="xml" indent="yes"
    doctype-public="-//W3C//DTD SVG 1.0//EN"
    doctype-system="http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd"/>

<xsl:variable name="text-style">font-size:10px; font-family:sans-serif;</xsl:variable>

<!-- Used to generate unique gradient fills for colors given by hex value
     Search for generate-id to find where its used
-->
<xsl:key name="fills" match="*" use="@fill"/>

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy> 
</xsl:template>

<xsl:template match="svg:svg">
  <svg xmlns="http://www.w3.org/2000/svg">
    <!-- Order is important here, so the attributes below overrides the 
         originals, which are copied "wholesale" -->
    <xsl:apply-templates select="@*" />
 
    <defs>
      <linearGradient id="white" x1="0%" y1="0%" x2="0%" y2="0%">
         <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="black" x1="0%" y1="0%" x2="0%" y2="0%">
         <stop offset="0%" style="stop-color:rgb(0,0,0);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="aquamarine" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(127,255,212);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="azure" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(240,255,255);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="blue" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(0,0,255);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="blueviolet" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(138,43,226);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="brown" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(165,42,42);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="cadetblue" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(95,158,160);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="chocolate" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(210,105,30);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="cornflowerblue" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(100,149,237);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="crimson" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(220,20,60);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="cyan" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(0,255,255);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="darkgreen" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(0,100,0);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="darkorange" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(255,140,0);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="gold" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(255,215,0);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="gray" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(192,192,192);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="greenyellow" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(173,255,47);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="green" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(0,255,0);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="grey" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(192,192,192);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="hotpink" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(255,105,180);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="indianred" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(205,92,92);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="indigo" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(75,0,130);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="lavender" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(230,230,250);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="lightblue" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(173,216,230);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="lightgray" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(211,211,211);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="lightgrey" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(211,211,211);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="magenta" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(255,0,255);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="maroon" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(176,48,96);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="mediumblue" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(0,0,205);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="mediumpurple" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(147,112,219);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="orange" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(255,165,0);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="pink" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(255,192,203);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="purple" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(160,32,240);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="red" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(255,0,0);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="steelblue" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(70,130,180);stop-opacity:1"/>
      </linearGradient>
      
      <linearGradient id="violet" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(238,130,238);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="yellow" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(255,255,0);stop-opacity:1"/>
      </linearGradient>

      <linearGradient id="none" x1="0%" y1="0%" x2="100%" y2="100%">
        <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
        <stop offset="100%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
      </linearGradient>

    <xsl:for-each select="*//*[generate-id() = generate-id(key('fills',@fill)[1])][substring(@fill,1,1)='#']">
      <linearGradient x1="0%" y1="0%" x2="100%" y2="100%">
        <xsl:attribute name="id">fill-<xsl:value-of select="substring(@fill,2,6)"/></xsl:attribute>
         <stop offset="0%" style="stop-color:rgb(255,255,255);stop-opacity:1"/>
         <stop offset="100%">
           <xsl:attribute name="style">stop-color:<xsl:value-of select="@fill" />;stop-opacity:1</xsl:attribute>
         </stop>
      </linearGradient>
    </xsl:for-each>

    </defs>


    <xsl:apply-templates />
  </svg>
</xsl:template>

<!-- Match the top most "g" -->
<xsl:template match="/svg:svg/svg:g"> 
  <g>
    <xsl:apply-templates select="@*"/>
    <!-- Graphviz uses a polygon as the background. Don't want a gradient there -->
    <xsl:for-each select="svg:polygon">
      <xsl:copy><xsl:apply-templates select="@*" /></xsl:copy>
    </xsl:for-each>
    <xsl:apply-templates select="svg:title|svg:g" />
  </g>
</xsl:template> 
 

<xsl:template match="svg:text">
  <text>
    <xsl:apply-templates select="@*" />
    <xsl:if test="not(@font-family) and not(@font-size)">
      <xsl:attribute name="style"><xsl:value-of select="$text-style" /></xsl:attribute>
    </xsl:if>
    <xsl:apply-templates select="text()"/>
  </text>
</xsl:template> 


<xsl:template match="svg:g">
  <xsl:copy>
    <xsl:apply-templates select="@*" />
    <xsl:choose>
      <!-- Handle linked groups. -->
      <xsl:when test="svg:a">
        <xsl:for-each select="svg:a">
          <xsl:copy>
            <xsl:apply-templates select="@*" />
            <xsl:call-template name="group">
              <xsl:with-param name="class" select="../@class"/>
            </xsl:call-template>
          </xsl:copy>
        </xsl:for-each>
      </xsl:when>
      <!-- Handle bare groups. -->
      <xsl:otherwise>
        <xsl:call-template name="group"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:copy>
</xsl:template>


<xsl:template name="group">
  <xsl:param name="class" select="@class"/>

  <xsl:for-each select="svg:polygon|svg:ellipse">
    <xsl:call-template name="poly-shadow" />
  </xsl:for-each>

  <xsl:choose>
    <!-- Rewrite node outlines. -->
    <xsl:when test="$class='node' and svg:path|svg:polyline">
      <xsl:call-template name="node-outline">
        <xsl:with-param name="current" select="*[1]"/>
        <xsl:with-param name="style">shadow</xsl:with-param>
        <xsl:with-param name="first" select="true()"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:for-each select="svg:path">
        <xsl:call-template name="path-shadow-edge" />
      </xsl:for-each>
    </xsl:otherwise>
  </xsl:choose>

  <xsl:for-each select="svg:polygon|svg:ellipse">
    <xsl:sort select="@ry" order="descending" />
    <xsl:call-template name="poly-main" />
  </xsl:for-each>

  <xsl:choose>
    <!-- Rewrite node outlines. -->
    <xsl:when test="$class='node' and svg:path">
      <xsl:for-each select="svg:path">
        <xsl:call-template name="node-outline">
          <xsl:with-param name="current" select="."/>
          <xsl:with-param name="first" select="true()"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:when>
    <xsl:when test="$class='node' and svg:polyline">
      <xsl:for-each select="svg:polyline">
        <xsl:call-template name="node-outline">
          <xsl:with-param name="current" select="."/>
          <xsl:with-param name="first" select="true()"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
      <xsl:for-each select="svg:path">
        <path><xsl:apply-templates select="@*" /></path>
      </xsl:for-each>
    </xsl:otherwise>
  </xsl:choose>

  <xsl:apply-templates select="svg:text" />
</xsl:template>

<xsl:template name="node-outline">
  <xsl:param name="path-so-far"/>
  <xsl:param name="current"/>
  <xsl:param name="style"/>
  <xsl:param name="first" select="false()"/>

  <xsl:choose>
    <!-- Visit each child element, collecting the path details. -->
    <xsl:when test="$current">
      <xsl:choose>
        <xsl:when test="local-name($current) = 'path'">
          <xsl:call-template name="filter-path">
            <xsl:with-param name="path-so-far" select="$path-so-far"/>
            <xsl:with-param name="point" select="substring-before($current/@d, 'C')"/>
            <xsl:with-param name="points" select="concat('C', substring-after($current/@d, 'C'))"/>
            <xsl:with-param name="current" select="$current"/>
            <xsl:with-param name="style" select="$style"/>
            <xsl:with-param name="include" select="$first"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="local-name($current) = 'polyline'">
          <xsl:call-template name="polyline-to-path">
            <xsl:with-param name="path-so-far" select="$path-so-far"/>
            <xsl:with-param name="point" select="concat('M', substring-before($current/@points, ' '))"/>
            <xsl:with-param name="points" select="substring-after($current/@points, ' ')"/>
            <xsl:with-param name="current" select="$current"/>
            <xsl:with-param name="style" select="$style"/>
            <xsl:with-param name="include" select="$first"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="node-outline">
            <xsl:with-param name="path-so-far" select="$path-so-far"/>
            <xsl:with-param name="current" select="$current/following-sibling::*[1]"/>
            <xsl:with-param name="style" select="$style"/>
            <xsl:with-param name="first" select="$first"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <!-- With no more elements to visit, generate the path. -->
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$style = 'shadow'">
          <path style="fill: black; stroke: none; fill-opacity:0.15" transform="translate(3,3)"
                d="{$path-so-far}"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- Provide the path attributes using dynamic colour discoveries. -->
          <xsl:element name="path">
            <xsl:attribute name="d"><xsl:value-of select="$path-so-far"/></xsl:attribute>
            <xsl:call-template name="make-style-attribute">
              <xsl:with-param name="fill"
                              select="normalize-space(substring-after(substring-before(ancestor::*[svg:polygon]/svg:polygon[1]/@style,';'),'fill:'))"/>
              <xsl:with-param name="fill-explicit"
                              select="@fill"/>
              <xsl:with-param name="stroke"
                              select="normalize-space(substring-after(substring-before(ancestor::*[svg:polygon]/svg:polygon[1]/@style,';'),'stroke:'))"/>
              <xsl:with-param name="stroke-explicit">black</xsl:with-param>
              <xsl:with-param name="none-is-transparent" select="true()"/>
            </xsl:call-template>
          </xsl:element>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="filter-path">
  <xsl:param name="path-so-far"/>
  <xsl:param name="point"/>
  <xsl:param name="points"/>
  <xsl:param name="current"/>
  <xsl:param name="style"/>
  <xsl:param name="include" select="true()"/>

  <xsl:variable name="next" select="substring-before($points, ' ')"/>
  <xsl:variable name="remaining" select="substring-after($points, ' ')"/>

  <xsl:choose>
    <!-- With path points remaining, include the current point if appropriate
         and visit those remaining. -->
    <xsl:when test="$remaining">
      <xsl:choose>
        <xsl:when test="$include">
          <xsl:call-template name="filter-path">
            <xsl:with-param name="path-so-far" select="concat($path-so-far, ' ', $point)"/>
            <xsl:with-param name="point" select="$next"/>
            <xsl:with-param name="points" select="$remaining"/>
            <xsl:with-param name="current" select="$current"/>
            <xsl:with-param name="style" select="$style"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="filter-path">
            <xsl:with-param name="path-so-far" select="$path-so-far"/>
            <xsl:with-param name="point" select="$next"/>
            <xsl:with-param name="points" select="$remaining"/>
            <xsl:with-param name="current" select="$current"/>
            <xsl:with-param name="style" select="$style"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <!-- With up to one remaining after this point, include the current point,
         if appropriate, and the one remaining. -->
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$include">
          <xsl:call-template name="node-outline">
            <xsl:with-param name="path-so-far" select="concat($path-so-far, ' ', $point, ' ', $points)"/>
            <xsl:with-param name="current" select="$current/following-sibling::*[1]"/>
            <xsl:with-param name="style" select="$style"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="node-outline">
            <xsl:with-param name="path-so-far" select="concat($path-so-far, ' ', $points)"/>
            <xsl:with-param name="current" select="$current/following-sibling::*[1]"/>
            <xsl:with-param name="style" select="$style"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="polyline-to-path">
  <xsl:param name="path-so-far"/>
  <xsl:param name="point"/>
  <xsl:param name="points"/>
  <xsl:param name="current"/>
  <xsl:param name="style"/>
  <xsl:param name="include" select="true()"/>

  <xsl:variable name="next" select="substring-before($points, ' ')"/>
  <xsl:variable name="remaining" select="substring-after($points, ' ')"/>

  <xsl:choose>
    <!-- With path points remaining, include the current point if appropriate
         and visit those remaining. -->
    <xsl:when test="$remaining">
      <xsl:choose>
        <xsl:when test="$include">
          <xsl:call-template name="polyline-to-path">
            <xsl:with-param name="path-so-far" select="concat($path-so-far, ' ', $point)"/>
            <xsl:with-param name="point" select="concat('L', $next)"/>
            <xsl:with-param name="points" select="$remaining"/>
            <xsl:with-param name="current" select="$current"/>
            <xsl:with-param name="style" select="$style"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="polyline-to-path">
            <xsl:with-param name="path-so-far" select="$path-so-far"/>
            <xsl:with-param name="point" select="concat('L', $next)"/>
            <xsl:with-param name="points" select="$remaining"/>
            <xsl:with-param name="current" select="$current"/>
            <xsl:with-param name="style" select="$style"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <!-- With up to one remaining after this point, include the current point,
         if appropriate, and the one remaining. -->
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$include">
          <xsl:call-template name="node-outline">
            <xsl:with-param name="path-so-far" select="concat($path-so-far, ' ', $point, ' L', $points)"/>
            <xsl:with-param name="current" select="$current/following-sibling::*[2]"/>
            <xsl:with-param name="style" select="$style"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="node-outline">
            <xsl:with-param name="path-so-far" select="concat($path-so-far, ' L', $points)"/>
            <xsl:with-param name="current" select="$current/following-sibling::*[1]"/>
            <xsl:with-param name="style" select="$style"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="poly-shadow">
  <xsl:element name="{name()}">
    <xsl:apply-templates select="@*"/>
    <xsl:attribute name="style">fill: black; stroke: none; fill-opacity:0.3</xsl:attribute>
    <xsl:attribute name="transform">translate(3,3)</xsl:attribute>
  </xsl:element>
</xsl:template>

<xsl:template name="path-shadow-edge">
  <xsl:element name="{name()}">
    <xsl:apply-templates select="@*"/>
    <xsl:attribute name="style">fill: none; stroke: black; stroke-opacity:0.3</xsl:attribute>
    <xsl:attribute name="transform">translate(3,3)</xsl:attribute>
  </xsl:element>
</xsl:template>

<xsl:template name="poly-main">
  <xsl:element name="{name()}">
    <xsl:apply-templates select="@*" />
    <xsl:call-template name="make-style-attribute">
      <xsl:with-param name="fill"
                      select="normalize-space(substring-after(substring-before(@style,';'),'fill:'))"/>
      <xsl:with-param name="fill-explicit"
                      select="@fill"/>
      <xsl:with-param name="stroke"
                      select="normalize-space(substring-after(substring-after(@style,';'),'stroke:'))"/>
      <xsl:with-param name="stroke-explicit"
                      select="@stroke"/>
    </xsl:call-template>
  </xsl:element>
</xsl:template>

<xsl:template name="path-main">
  <path>
    <xsl:apply-templates select="@*" />
    <!-- This is somewhat broken - the gradient is set based on the position/size of the element it is used with; as a result it doesn't line up properly with the main polygon -->
    <xsl:call-template name="make-style-attribute">
      <xsl:with-param name="fill"
                      select="normalize-space(substring-after(substring-before(ancestor::*[svg:polygon]/svg:polygon[1]/@style,';'),'fill:'))"/>
      <xsl:with-param name="fill-explicit"
                      select="ancestor::*[svg:polygon]/svg:polygon[1]/@fill"/>
      <xsl:with-param name="stroke"
                      select="normalize-space(substring-after(substring-before(ancestor::*[svg:polygon]/svg:polygon[1]/@style,';'),'stroke:'))"/>
      <xsl:with-param name="stroke-explicit">black</xsl:with-param>
    </xsl:call-template>
  </path>
</xsl:template>

<xsl:template name="make-style-attribute">
  <xsl:param name="fill"/>
  <xsl:param name="fill-explicit"/>
  <xsl:param name="stroke"/>
  <xsl:param name="stroke-explicit"/>
  <xsl:param name="none-is-transparent" select="false()"/>

  <xsl:attribute name="style">
    <xsl:choose>
      <xsl:when test="$fill and (not($none-is-transparent) or $fill != 'none')">
        <xsl:call-template name="make-style-fill">
          <xsl:with-param name="fill" select="$fill"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$fill-explicit and (not($none-is-transparent) or $fill-explicit != 'none')">
        <xsl:choose>
          <xsl:when test="starts-with($fill-explicit, '#')">
            <xsl:call-template name="make-style-fill">
              <xsl:with-param name="fill" select="$fill-explicit"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>fill: url(#<xsl:value-of select="$fill-explicit"/>);</xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>fill: none;</xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
      <xsl:when test="$stroke">stroke: <xsl:value-of select="$stroke"/>;</xsl:when>
      <xsl:when test="$stroke-explicit">stroke: <xsl:value-of select="$stroke-explicit"/>;</xsl:when>
      <xsl:otherwise>stroke: black;</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
</xsl:template>

<xsl:template name="make-style-fill">
  <xsl:param name="fill"/>
  <xsl:choose>
    <xsl:when test="substring($fill,1,1) = '#'">fill: url(#fill-<xsl:value-of select="substring($fill,2,6)"/>);</xsl:when>
    <xsl:otherwise>fill: url(#<xsl:value-of select="$fill"/>);</xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
