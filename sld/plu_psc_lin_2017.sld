<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>geo_p_prescription_lin_v2017</se:Name>
    <UserStyle>
      <se:Name>geo_p_prescription_lin_v2017</se:Name>
      <se:FeatureTypeStyle>

        
<!-- #####  PSC 05_01  ##### --> 
          
        <se:Rule>
          <se:Name>Emplacement réservé aux voies publiques</se:Name>
          <se:Description>
            <se:Title>Emplacement réservé aux voies publiques</se:Title>
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
          <se:LineSymbolizer>          
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                   <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Stroke>
                       <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>6</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Emplacement réservé aux voies publiques</se:Name>
          <se:Description>
            <se:Title>Emplacement réservé aux voies publiques</se:Title>
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
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">          
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                   <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Stroke>
                       <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>1.5</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>                        


<!-- #####  PSC 05_04  ##### --> 
          
        <se:Rule>
          <se:Name>Emplacement réservé aux espaces verts / continuités écologiques</se:Name>
          <se:Description>
            <se:Title>Emplacement réservé aux espaces verts / continuités écologiques</se:Title>
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
          <se:LineSymbolizer>          
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                   <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Stroke>
                       <se:SvgParameter name="stroke">#0bb200</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>6</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Emplacement réservé aux espaces verts / continuités écologiques</se:Name>
          <se:Description>
            <se:Title>Emplacement réservé aux espaces verts / continuités écologiques</se:Title>
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
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">          
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                   <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Stroke>
                       <se:SvgParameter name="stroke">#0bb200</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>1.5</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>                             


<!-- #####  PSC 05_06  ##### --> 
          
        <se:Rule>
          <se:Name>Servitude de localisation des voies, ouvrages publics, installations d'intérêt général et espaces verts en zone U et AU</se:Name>
          <se:Description>
            <se:Title>Servitude de localisation des voies, ouvrages publics, installations d'intérêt général et espaces verts en zone U et AU</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>stypepsc</ogc:PropertyName>
                <ogc:Literal>06</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:LineSymbolizer>          
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                   <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Stroke>
                       <se:SvgParameter name="stroke">#8282ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>6</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Servitude de localisation des voies, ouvrages publics, installations d'intérêt général et espaces verts en zone U et AU</se:Name>
          <se:Description>
            <se:Title>Servitude de localisation des voies, ouvrages publics, installations d'intérêt général et espaces verts en zone U et AU</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>stypepsc</ogc:PropertyName>
                <ogc:Literal>06</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">          
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                   <se:WellKnownName>shape://times</se:WellKnownName>
                    <se:Stroke>
                       <se:SvgParameter name="stroke">#8282ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>1.5</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>                 


<!-- #####  PSC 07_00-02-03-05  ##### --> 
          
        <se:Rule>
          <se:Name>Patrimoine paysager ou éléments de paysage à protéger</se:Name>
          <se:Description>
            <se:Title>Patrimoine paysager ou éléments de paysage à protéger</se:Title>
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
                  <ogc:Literal>05</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-00-02-03-04-05.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>7</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Patrimoine paysager ou éléments de paysage à protéger</se:Name>
          <se:Description>
            <se:Title>Patrimoine paysager ou éléments de paysage à protéger</se:Title>
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
                  <ogc:Literal>05</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-00-02-03-04-05_v2.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        
<!-- #####  PSC 07_01  ##### --> 
          
        <se:Rule>
          <se:Name>Patrimoine bâti à protéger</se:Name>
          <se:Description>
            <se:Title>Patrimoine bâti à protéger</se:Title>
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
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-01.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>7</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Patrimoine bâti à protéger</se:Name>
          <se:Description>
            <se:Title>Patrimoine bâti à protéger</se:Title>
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
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-01_v2.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>2</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>


<!-- #####  PSC 07_04  ##### --> 
          
        <se:Rule>
          <se:Name>Eléments de paysages (sites et secteurs) à préserver</se:Name>
          <se:Description>
            <se:Title>Eléments de paysages (sites et secteurs) à préserver</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>07</ogc:Literal>
              </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>04</ogc:Literal>
                </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
         <se:PointSymbolizer>
                 <se:Geometry>
                    <ogc:Function name="startPoint">
                        <ogc:PropertyName>geom</ogc:PropertyName>
                    </ogc:Function>
                </se:Geometry>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://carrow</se:WellKnownName>
                    <se:Fill>
                      <se:SvgParameter name="fill">#4ce670</se:SvgParameter>
                    </se:Fill>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#4ce670</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>20</se:Size>
                   <se:Rotation>
                    <ogc:Add>
                    <ogc:Function name="startAngle">
                        <ogc:PropertyName>geom</ogc:PropertyName>
                    </ogc:Function>
                    <ogc:Literal>180.0</ogc:Literal> 
                    </ogc:Add>                   
                  </se:Rotation>
                </se:Graphic>
           </se:PointSymbolizer>
            <se:PointSymbolizer>
                 <se:Geometry>
                    <ogc:Function name="endPoint">
                        <ogc:PropertyName>geom</ogc:PropertyName>
                    </ogc:Function>
                </se:Geometry>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://carrow</se:WellKnownName>
                    <se:Fill>
                      <se:SvgParameter name="fill">#4ce670</se:SvgParameter>
                    </se:Fill>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#4ce670</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>20</se:Size>
                   <se:Rotation>
                    <ogc:Function name="endAngle">
                        <ogc:PropertyName>geom</ogc:PropertyName>
                    </ogc:Function>
                  </se:Rotation>
                </se:Graphic>
           </se:PointSymbolizer>
           <se:LineSymbolizer>
            <se:Stroke>
               <se:SvgParameter name="stroke">#4ce670</se:SvgParameter>
               <se:SvgParameter name="stroke-width">0.8</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>


<!-- #####  PSC 15_00  ##### -->        
        
        <se:Rule>
          <se:Name>Règles d'implantation des constructions</se:Name>
          <se:Description>
            <se:Title>Règles d'implantation des constructions</se:Title>
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
          <se:LineSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">4 2</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Règles d'implantation des constructions</se:Name>
          <se:Description>
            <se:Title>Règles d'implantation des constructions</se:Title>
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
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.4</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">1 0.5</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
                

<!-- #####  PSC 15_01-03  ##### -->        
        
        <se:Rule>
          <se:Name>Règles d'implantation des constructions</se:Name>
          <se:Description>
            <se:Title>Règles d'implantation des constructions</se:Title>
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
          <se:LineSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">12 4</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Règles d'implantation des constructions</se:Name>
          <se:Description>
            <se:Title>Règles d'implantation des constructions</se:Title>
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
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:SvgParameter name="stroke">#ff00ff</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.4</se:SvgParameter>
              <se:SvgParameter name="stroke-dasharray">3 1</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        
<!-- #####  PSC 24  ##### --> 

        <se:Rule>
          <se:Name>Voies de circulation à créer, modifier ou conserver</se:Name>
          <se:Description>
            <se:Title>Voies de circulation à créer, modifier ou conserver</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>24</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_24.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>6</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Voies de circulation à créer, modifier ou conserver</se:Name>
          <se:Description>
            <se:Title>Voies de circulation à créer, modifier ou conserver</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>24</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_24.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>1.5</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>        


<!-- #####  PSC 25  ##### --> 

        <se:Rule>
          <se:Name>Eléments de continuité écologique et trame verte et bleue</se:Name>
          <se:Description>
            <se:Title>Eléments de continuité écologique et trame verte et bleue</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>25</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_25.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>6</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Eléments de continuité écologique et trame verte et bleue</se:Name>
          <se:Description>
            <se:Title>Eléments de continuité écologique et trame verte et bleue</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>25</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_25.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>1.5</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>        


<!-- #####  PSC 39  ##### --> 

        <se:Rule>
          <se:Name>Hauteur</se:Name>
          <se:Description>
            <se:Title>Hauteur</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>39</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:LineSymbolizer>          
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                   <se:WellKnownName>extshape://triangle</se:WellKnownName>
                    <se:Fill>
                      <se:SvgParameter name="fill">#996c2d</se:SvgParameter>
                    </se:Fill>
                    <se:Stroke>
                       <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>11</se:Size>
                  <se:Rotation>180.0</se:Rotation>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
          <se:LineSymbolizer>          
            <se:Stroke>
             <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
             <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Hauteur</se:Name>
          <se:Description>
            <se:Title>Hauteur</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>39</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">          
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                   <se:WellKnownName>extshape://triangle</se:WellKnownName>
                    <se:Fill>
                      <se:SvgParameter name="fill">#996c2d</se:SvgParameter>
                    </se:Fill>
                    <se:Stroke>
                       <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">0.1</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>3.5</se:Size>
                  <se:Rotation>180.0</se:Rotation>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">          
            <se:Stroke>
             <se:SvgParameter name="stroke">#996c2d</se:SvgParameter>
             <se:SvgParameter name="stroke-width">0.15</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        
<!-- #####  PSC 41  ##### --> 

        <se:Rule>
          <se:Name>Aspect extérieur des façades, toitures et clôtures</se:Name>
          <se:Description>
            <se:Title>Aspect extérieur des façades, toitures et clôtures</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>41</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_16_41.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>7</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Aspect extérieur des façades, toitures et clôtures</se:Name>
          <se:Description>
            <se:Title>Aspect extérieur des façades, toitures et clôtures</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>41</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_16_41.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>1.5</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        
<!-- #####  PSC 43  ##### --> 

        <se:Rule>
          <se:Name>Réalisation d'espaces libres, plantations, aires de jeux et de loisir</se:Name>
          <se:Description>
            <se:Title>Réalisation d'espaces libres, plantations, aires de jeux et de loisir</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>43</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_43_v2.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>7</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Réalisation d'espaces libres, plantations, aires de jeux et de loisir</se:Name>
          <se:Description>
            <se:Title>Réalisation d'espaces libres, plantations, aires de jeux et de loisir</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>43</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_43_v2.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>1.5</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
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
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_99.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>11</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
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
          <se:LineSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_99.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>3</se:Size>
                </se:Graphic>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule> 
                                   
        
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
