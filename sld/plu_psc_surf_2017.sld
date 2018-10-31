<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>geo_p_prescription_surf_v2017</se:Name>
    <UserStyle>
      <se:Name>geo_p_prescription_surf_v2017</se:Name>
      <se:FeatureTypeStyle>
      
<!-- #####  PSC 01  ##### --> 

        <se:Rule>
          <se:Name>Espace bois� class�</se:Name>
          <se:Description>
            <se:Title>Espace bois� class�</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typepsc</ogc:PropertyName>
              <ogc:Literal>01</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_01.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>12</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#55ff00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Espace bois� class�</se:Name>
          <se:Description>
            <se:Title>Espace bois� class�</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typepsc</ogc:PropertyName>
              <ogc:Literal>01</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_01.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>4</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#55ff00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>


<!-- #####  PSC 02  ##### --> 

        <se:Rule>
          <se:Name>Limitations de la constructibilit� pour des raisons environnementales, de risques, d'int�r�t g�n�ral</se:Name>
          <se:Description>
            <se:Title>Limitations de la constructibilit� pour des raisons environnementales, de risques, d'int�r�t g�n�ral</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>02</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Risque d'affaissement de terrain</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Zone de protection risque sanitaire</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ff0000</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>8</se:Size>
                  </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff0000</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
  
 <!-- #####  PSC 03  ##### -->        
        
        <se:Rule>
          <se:Name>Secteur avec disposition de reconstruction / d�molition</se:Name>
          <se:Description>
            <se:Title>Secteur avec disposition de reconstruction / d�molition</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typepsc</ogc:PropertyName>
              <ogc:Literal>03</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#990099</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">1.5 2</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
                 
<!-- #####  PSC 05_01  ##### --> 

        <se:Rule>
         <se:Name>Emplacement r�serv� aux voies publiques</se:Name>
          <se:Description>
            <se:Title>Emplacement r�serv� aux voies publiques</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>stypepsc</ogc:PropertyName>
                <ogc:Literal>01</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                 <se:Mark>
                    <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Fill/>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                    <se:Size>8</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
         <se:Name>Emplacement r�serv� aux voies publiques</se:Name>
          <se:Description>
            <se:Title>Emplacement r�serv� aux voies publiques</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>stypepsc</ogc:PropertyName>
                <ogc:Literal>01</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                 <se:Mark>
                    <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Fill/>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                    <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
<!-- #####  PSC 05_02-03  ##### --> 

        <se:Rule>
         <se:Name>Emplacement r�serv� aux ouvrages publics et installations d'int�r�t g�n�ral</se:Name>
          <se:Description>
            <se:Title>Emplacement r�serv� aux ouvrages publics et installations d'int�r�t g�n�ral</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>02</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>03</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                 <se:Mark>
                    <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Fill/>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                    <se:Size>8</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
         <se:Name>Emplacement r�serv� aux ouvrages publics et installations d'int�r�t g�n�ral</se:Name>
          <se:Description>
            <se:Title>Emplacement r�serv� aux ouvrages publics et installations d'int�r�t g�n�ral</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>02</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>03</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                 <se:Mark>
                    <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Fill/>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                    <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
<!-- #####  PSC 05_04  ##### --> 

        <se:Rule>
         <se:Name>Emplacement r�serv� aux espaces verts / continuit�s �cologiques</se:Name>
          <se:Description>
            <se:Title>Emplacement r�serv� aux espaces verts / continuit�s �cologiques</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>stypepsc</ogc:PropertyName>
                <ogc:Literal>04</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                 <se:Mark>
                    <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Fill/>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#0bb200</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                    <se:Size>8</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#0bb200</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
         <se:Name>Emplacement r�serv� aux espaces verts / continuit�s �cologiques</se:Name>
          <se:Description>
            <se:Title>Emplacement r�serv� aux espaces verts / continuit�s �cologiques</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>stypepsc</ogc:PropertyName>
                <ogc:Literal>04</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                 <se:Mark>
                    <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Fill/>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#0bb200</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                    <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#0bb200</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>        
        
        
<!-- #####  PSC 05_05  ##### --> 

        <se:Rule>
         <se:Name>Emplacement r�serv� logement social</se:Name>
          <se:Description>
            <se:Title>Emplacement r�serv� logement social</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>stypepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                 <se:Mark>
                    <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Fill/>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ffaa00</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                    <se:Size>8</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ffaa00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
         <se:Name>Emplacement r�serv� logement social</se:Name>
          <se:Description>
            <se:Title>Emplacement r�serv� logement social</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>stypepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                 <se:Mark>
                    <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Fill/>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ffaa00</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                    <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ffaa00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
       
<!-- #####  PSC 05_00-06-07  ##### --> 

        <se:Rule>
         <se:Name>Emplacement r�serv� sans objet / Servitude de localisation des voies, ouvrages publics, installations d'int�r�t g�n�ral et espaces verts en zone U ou AU / Secteur de projet en attente d'un projet d'am�nagement global</se:Name>
          <se:Description>
            <se:Title>Emplacement r�serv� sans objet / Servitude de localisation des voies, ouvrages publics, installations d'int�r�t g�n�ral et espaces verts en zone U ou AU / Secteur de projet en attente d'un projet d'am�nagement global</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>00</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>06</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>07</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                 <se:Mark>
                    <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Fill/>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#8282ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                    <se:Size>8</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#8282ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
         <se:Name>Emplacement r�serv� sans objet / Servitude de localisation des voies, ouvrages publics, installations d'int�r�t g�n�ral et espaces verts en zone U ou AU / Secteur de projet en attente d'un projet d'am�nagement global</se:Name>
          <se:Description>
            <se:Title>Emplacement r�serv� sans objet / Servitude de localisation des voies, ouvrages publics, installations d'int�r�t g�n�ral et espaces verts en zone U ou AU / Secteur de projet en attente d'un projet d'am�nagement global</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>00</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>06</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>07</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                 <se:Mark>
                    <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Fill/>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#8282ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                    <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#8282ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>                               


<!-- #####  PSC 07_00-02-03-04-05  ##### --> 

        <se:Rule>
          <se:Name>Patrimoine paysager � prot�ger</se:Name>
          <se:Description>
            <se:Title>Patrimoine paysager � prot�ger</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>07</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>00</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>02</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>03</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>04</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>05</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-00-02-03-04-05.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>8</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#4ce670</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Patrimoine paysager � prot�ger</se:Name>
          <se:Description>
            <se:Title>Patrimoine paysager � prot�ger</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>07</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>00</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>02</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>03</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>04</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>05</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-00-02-03-04-05_v2.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#4ce670</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>


<!-- #####  PSC 07_01  ##### --> 

        <se:Rule>
          <se:Name>Patrimoine b�ti � prot�ger</se:Name>
          <se:Description>
            <se:Title>Patrimoine b�ti � prot�ger</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>07</ogc:Literal>
              </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>01</ogc:Literal>
                </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-01.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>8</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Patrimoine b�ti � prot�ger</se:Name>
          <se:Description>
            <se:Title>Patrimoine b�ti � prot�ger</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>07</ogc:Literal>
              </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>01</ogc:Literal>
                </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-01_v2.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>


<!-- #####  PSC 08  ##### --> 

        <se:Rule>
          <se:Name>Terrain cultiv� � prot�ger en zone urbaine</se:Name>
          <se:Description>
            <se:Title>Terrain cultiv� � prot�ger en zone urbaine</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>08</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_08.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>8</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#087f00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Terrain cultiv� � prot�ger en zone urbaine</se:Name>
          <se:Description>
            <se:Title>Terrain cultiv� � prot�ger en zone urbaine</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>08</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_08.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#087f00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
<!-- #####  PSC 15_00  ##### -->        
        
        <se:Rule>
          <se:Name>R�gles d'implantation des constructions</se:Name>
          <se:Description>
            <se:Title>R�gles d'implantation des constructions</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>15</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>00</ogc:Literal>
              </ogc:PropertyIsEqualTo>
             </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">4 2</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>R�gles d'implantation des constructions</se:Name>
          <se:Description>
            <se:Title>R�gles d'implantation des constructions</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>15</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>00</ogc:Literal>
              </ogc:PropertyIsEqualTo>
             </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.4</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">1 0.5</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
<!-- #####  PSC 15_01-03  ##### -->        
        
        <se:Rule>
          <se:Name>R�gles d'implantation des constructions</se:Name>
          <se:Description>
            <se:Title>R�gles d'implantation des constructions</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>typepsc</ogc:PropertyName>
                  <ogc:Literal>15</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                   <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>01</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                   <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>03</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
             </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">12 4</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>R�gles d'implantation des constructions</se:Name>
          <se:Description>
            <se:Title>R�gles d'implantation des constructions</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>typepsc</ogc:PropertyName>
                  <ogc:Literal>15</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                   <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>01</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                   <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>03</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
             </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.4</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">3 1</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>        
        
             
<!-- #####  PSC 16_01  ##### --> 

        <se:Rule>
         <se:Name>B�timent susceptible de changer de destination</se:Name>
          <se:Description>
            <se:Title>B�timent susceptible de changer de destination</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
             <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>16</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>stypepsc</ogc:PropertyName>
                <ogc:Literal>01</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                 <se:Mark>
                    <se:WellKnownName>shape://slash</se:WellKnownName>
                    <se:Fill/>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                    <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>


 <!-- #####  PSC 17  ##### -->        
        
        <se:Rule>
          <se:Name>Secteur � programme de logements mixit� sociale en zone U et AU</se:Name>
          <se:Description>
            <se:Title>Secteur � programme de logements mixit� sociale en zone U et AU</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typepsc</ogc:PropertyName>
              <ogc:Literal>17</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ffaa00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">4 2</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Secteur � programme de logements mixit� sociale en zone U et AU</se:Name>
          <se:Description>
            <se:Title>Secteur � programme de logements mixit� sociale en zone U et AU</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typepsc</ogc:PropertyName>
              <ogc:Literal>17</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#ffaa00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.4</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">1 0.5</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
<!-- #####  PSC 18  ##### --> 

        <se:Rule>
          <se:Name>Orientations d'Am�nagement et de Programmation</se:Name>
          <se:Description>
            <se:Title>Orientations d'Am�nagement et de Programmation</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>18</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#00ffff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>12</se:Size>
                  </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#00ffff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://horline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#00ffff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>12</se:Size>
                  </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Orientations d'Am�nagement et de Programmation</se:Name>
          <se:Description>
            <se:Title>Orientations d'Am�nagement et de Programmation</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>18</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#00ffff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>3</se:Size>
                  </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#00ffff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://horline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#00ffff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>3</se:Size>
                  </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        

<!-- #####  PSC 19  ##### --> 

        <se:Rule>
          <se:Name>Secteur prot�g� en raison de la richesse du sol et du sous-sol</se:Name>
          <se:Description>
            <se:Title>Secteur prot�g� en raison de la richesse du sol et du sous-sol</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>19</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_19.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>10</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#98d998</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>        


<!-- #####  PSC 24  ##### --> 

        <se:Rule>
          <se:Name>Voies de circulation � cr�er, modifier ou conserver</se:Name>
          <se:Description>
            <se:Title>Voies de circulation � cr�er, modifier ou conserver</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>24</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_24.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>5</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
 <!--       <se:Rule>
          <se:Name>Voies de circulation � cr�er, modifier ou conserver</se:Name>
          <se:Description>
            <se:Title>Voies de circulation � cr�er, modifier ou conserver</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>24</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_24.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>1.5</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>        
 -->

<!-- #####  PSC 25  ##### --> 

        <se:Rule>
          <se:Name>El�ments de continuit� �cologique et trame verte et bleue</se:Name>
          <se:Description>
            <se:Title>El�ments de continuit� �cologique et trame verte et bleue</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>25</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_25.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>5</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#0082ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
<!--     <se:Rule>
          <se:Name>El�ments de continuit� �cologique et trame verte et bleue</se:Name>
          <se:Description>
            <se:Title>El�ments de continuit� �cologique et trame verte et bleue</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>25</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_25.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>1.5</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#0082ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>  
 -->

<!-- #####  PSC 31  ##### --> 

        <se:Rule>
          <se:Name>Marais, vasi�res, tourbi�res, plans d'eau, les zones humides et milieux temporairement immerg�s</se:Name>
          <se:Description>
            <se:Title>Marais, vasi�res, tourbi�res, plans d'eau, les zones humides et milieux temporairement immerg�s</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>31</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_31.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>20</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#0082ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>  


<!-- #####  PSC 99  ##### --> 

        <se:Rule>
          <se:Name>Autre</se:Name>
          <se:Description>
            <se:Title>Autre</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_99.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>8</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Autre</se:Name>
          <se:Description>
            <se:Title>Autre</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_99.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
 
 
<!-- #####  PSC 02_risque inondation important  ##### -->        
        
        <se:Rule>
          <se:Name>Risque Inondation : Zone rouge : Risque important</se:Name>
          <se:Description>
            <se:Title>Risque Inondation : Zone rouge : Risque important</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>02</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>libelle</ogc:PropertyName>
                <ogc:Literal>Risque Inondation : Zone rouge : Risque important</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
           <se:MinScaleDenominator>1</se:MinScaleDenominator>
           <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
         <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#ff0000</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.1</se:SvgParameter>
            </se:Fill>
         </se:PolygonSymbolizer> 
        </se:Rule>


<!-- #####  PSC 02_risque inondation mod�r�  ##### -->        
        
        <se:Rule>
          <se:Name>Risque Inondation : Zone bleue : Risque mod�r� � important</se:Name>
          <se:Description>
            <se:Title>Risque Inondation : Zone bleue : Risque mod�r� � important</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>02</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>libelle</ogc:PropertyName>
                <ogc:Literal>Risque Inondation : Zone bleue : Risque mod�r� � important</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
         <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#0082ff</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.1</se:SvgParameter>
            </se:Fill>
         </se:PolygonSymbolizer>
        </se:Rule>
        

<!-- #####  PSC 02_risque inondation nul  ##### -->
        
        <se:Rule>
          <se:Name>Risque Inondation : Zone blanche : Risque nul � mod�r�</se:Name>
          <se:Description>
            <se:Title>Risque Inondation : Zone blanche : Risque nul � mod�r�</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>02</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>libelle</ogc:PropertyName>
                <ogc:Literal>Risque Inondation : Zone blanche : Risque nul � mod�r�</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
         <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#000000</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.0</se:SvgParameter>
            </se:Fill>
         </se:PolygonSymbolizer>
        </se:Rule>

        
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
