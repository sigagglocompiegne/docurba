<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>geo_p_info_surf_v2017</se:Name>
    <UserStyle>
      <se:Name>geo_p_info_surf_v2017</se:Name>
      <se:FeatureTypeStyle>
      
  
<!-- #####  INF 02  ##### -->        
        
        <se:Rule>
          <se:Name>Zone d'aménagement concerté</se:Name>
          <se:Description>
            <se:Title>Zone d'aménagement concerté</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typeinf</ogc:PropertyName>
              <ogc:Literal>02</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff0000</se:SvgParameter>
              <se:SvgParameter name="stroke-width">4</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">5 4</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Zone d'aménagement concerté</se:Name>
          <se:Description>
            <se:Title>Zone d'aménagement concerté</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typeinf</ogc:PropertyName>
              <ogc:Literal>02</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff0000</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.75</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">1 0.75</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>

     <!-- #####  INF 99 Zone de 40m spécifique commune de Bailly #####  -->
        
        <se:Rule>
          <se:Name>Zone de 40m</se:Name>
          <se:Description>
            <se:Title>Zone de 40m</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typeinf</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>l_nom</ogc:PropertyName>
                  <ogc:Literal>Zone de 40m</ogc:Literal>
                </ogc:PropertyIsEqualTo>
            </ogc:And> 
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1.5</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">round</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">0.5 2.5</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Zone de 40m</se:Name>
          <se:Description>
            <se:Title>Zone de 40m</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typeinf</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>l_nom</ogc:PropertyName>
                  <ogc:Literal>Zone de 40m</ogc:Literal>
                </ogc:PropertyIsEqualTo>
            </ogc:And> 
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">round</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">0.1 1</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>       
   

<!-- #####  INF 03  #####        
        
        <se:Rule>
          <se:Name>Zone de préemption dans un espace naturel et sensible</se:Name>
          <se:Description>
            <se:Title>Zone de préemption dans un espace naturel et sensible</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typeinf</ogc:PropertyName>
              <ogc:Literal>03</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#00ff00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1.5</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">round</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">0.5 2.5</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Zone de préemption dans un espace naturel et sensible</se:Name>
          <se:Description>
            <se:Title>Zone de préemption dans un espace naturel et sensible</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typeinf</ogc:PropertyName>
              <ogc:Literal>03</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#00ff00</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">round</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">0.1 1</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
-->        

<!-- #####  INF 04  #####        
        
        <se:Rule>
          <se:Name>Périmètre de droit de préemption urbain</se:Name>
          <se:Description>
            <se:Title>Périmètre de droit de préemption urbain</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typeinf</ogc:PropertyName>
              <ogc:Literal>04</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                   <se:WellKnownName>extshape://emicircle</se:WellKnownName>
                    <se:Fill>
                      <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
                    </se:Fill>
                    <se:Stroke>
                       <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>12</se:Size>
                  <se:Rotation>180.0</se:Rotation>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:PolygonSymbolizer>  
          <se:PolygonSymbolizer>
            <se:Stroke>
             <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
             <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Périmètre de droit de préemption urbain</se:Name>
          <se:Description>
            <se:Title>Périmètre de droit de préemption urbain</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typeinf</ogc:PropertyName>
              <ogc:Literal>04</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                   <se:WellKnownName>extshape://emicircle</se:WellKnownName>
                    <se:Fill>
                      <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
                    </se:Fill>
                    <se:Stroke>
                       <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>4</se:Size>
                  <se:Rotation>180.0</se:Rotation>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:PolygonSymbolizer>  
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
             <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
             <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>                          
-->

<!-- #####  INF 05  #####        
       
        <se:Rule>
          <se:Name>Zone d'aménagement différé</se:Name>
          <se:Description>
            <se:Title>Zone d'aménagement différé</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typeinf</ogc:PropertyName>
              <ogc:Literal>05</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff9999</se:SvgParameter>
              <se:SvgParameter name="stroke-width">2</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">2.5 2</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Zone d'aménagement différé</se:Name>
          <se:Description>
            <se:Title>Zone d'aménagement différé</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typeinf</ogc:PropertyName>
              <ogc:Literal>05</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff9999</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">0.75 0.5</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
-->        

<!-- #####  INF 14  #####        
        
        <se:Rule>
          <se:Name>Périmètre de voisinage de transport terrestre</se:Name>
          <se:Description>
            <se:Title>Périmètre de voisinage de transport terrestre</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typeinf</ogc:PropertyName>
              <ogc:Literal>14</ogc:Literal> 
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://backslash</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#808080</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>15</se:Size>
                  </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#808080</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
-->         
        
<!-- #####  INF 16  ##### 

        <se:Rule>
          <se:Name>Site archéologique</se:Name>
          <se:Description>
            <se:Title>Site archéologique</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typeinf</ogc:PropertyName>
                <ogc:Literal>16</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typeinf_16.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>15</se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#828200</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
-->        
        
<!-- #####  INF 19  #####      
       
        <se:Rule>
          <se:Name>Zone d'assainissement collectif/non collectif, eaux usées/eaux pluviales, schéma de réseaux eau et assainissement, systèmes d'élimination des déchets, emplacements traitements eaux et déchets</se:Name>
          <se:Description>
            <se:Title>Zone d'assainissement collectif/non collectif, eaux usées/eaux pluviales, schéma de réseaux eau et assainissement, systèmes d'élimination des déchets, emplacements traitements eaux et déchets</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typeinf</ogc:PropertyName>
              <ogc:Literal>19</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#55557f</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1.5</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">5 3 1 3</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Zone d'assainissement collectif/non collectif, eaux usées/eaux pluviales, schéma de réseaux eau et assainissement, systèmes d'élimination des déchets, emplacements traitements eaux et déchets</se:Name>
          <se:Description>
            <se:Title>Zone d'assainissement collectif/non collectif, eaux usées/eaux pluviales, schéma de réseaux eau et assainissement, systèmes d'élimination des déchets, emplacements traitements eaux et déchets</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typeinf</ogc:PropertyName>
              <ogc:Literal>19</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#55557f</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.4</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">2 1 0.5 1</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>                
-->

       
        
      

        
<!-- #####  INF 99 Périmètre de forêt domaniale / INF 37 Bois ou forêts relevant du régime forestier  #####        
        
        <se:Rule>
          <se:Name>Périmètre de forêt domaniale / Bois ou forêts relevant du régime forestier</se:Name>
          <se:Description>
            <se:Title>Périmètre de forêt domaniale / Bois ou forêts relevant du régime forestier</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typeinf</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typeinf</ogc:PropertyName>
                <ogc:Literal>37</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:Or>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Forêt domaniale</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Périmètre de forêt domaniale</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>   
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#33a02c</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1.5</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">5 3 1 3 1 3</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Périmètre de forêt domaniale / Bois ou forêts relevant du régime forestier</se:Name>
          <se:Description>
            <se:Title>Périmètre de forêt domaniale / Bois ou forêts relevant du régime forestier</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typeinf</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typeinf</ogc:PropertyName>
                <ogc:Literal>37</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:Or>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Forêt domaniale</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Périmètre de forêt domaniale</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>    
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#33a02c</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.4</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">2 1 0.5 1 0.5 1</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
-->

<!-- #####  INF 99 Installations classées - zones de protection  #####        
        
        <se:Rule>
          <se:Name>Installations classées - zones de protection</se:Name>
          <se:Description>
            <se:Title>Installations classées - zones de protection</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typeinf</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Zone de protection des installations classées</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Installations classées - Zones de protections</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Périmètre de protection des installations classées</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Risques technologiques</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>  
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#000000</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.8</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">4 2</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Installations classées - zones de protection</se:Name>
          <se:Description>
            <se:Title>Installations classées - zones de protection</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typeinf</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Zone de protection des installations classées</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Installations classées - Zones de protections</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Périmètre de protection des installations classées</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Risques technologiques</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>  
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#000000</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.3</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">1.5 0.75</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
-->
        
        
<!-- #####  INF 99 Autre périmètre, secteur, plan, document, site, projet, espace #####
        
        <se:Rule>
          <se:Name>Autre périmètre, secteur, plan, document, site, projet, espace</se:Name>
          <se:Description>
            <se:Title>Autre périmètre, secteur, plan, document, site, projet, espace</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typeinf</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Autre périmètre, secteur, plan, document, site, projet, espace</ogc:Literal>
                </ogc:PropertyIsEqualTo>
            </ogc:And> 
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1.5</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">round</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">0.5 2.5</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Autre périmètre, secteur, plan, document, site, projet, espace</se:Name>
          <se:Description>
            <se:Title>Autre périmètre, secteur, plan, document, site, projet, espace</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typeinf</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>libelle</ogc:PropertyName>
                  <ogc:Literal>Autre périmètre, secteur, plan, document, site, projet, espace</ogc:Literal>
                </ogc:PropertyIsEqualTo>
            </ogc:And> 
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#b2b2b2</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.5</se:SvgParameter>
              <se:SvgParameter name="stroke-linecap">round</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">0.1 1</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>        
-->        
        
            

        
        
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
