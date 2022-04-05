<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>geo_p_prescription_pct_v2017</se:Name>
    <UserStyle>
      <se:Name>geo_p_prescription_pct_v2017</se:Name>
      <se:FeatureTypeStyle>

        <!-- #####  PSC 07_00  ##### --> 
          
        <se:Rule>
          <se:Name>Patrimoine bâti et paysager à protéger</se:Name>
          <se:Description>
            <se:Title>Patrimoine bâti et paysager à protéger</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>07</ogc:Literal>
              </ogc:PropertyIsEqualTo>

                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>00</ogc:Literal>
                </ogc:PropertyIsEqualTo>

            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PointSymbolizer>
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-00.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>18</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Patrimoine bâti et paysager à protéger</se:Name>
          <se:Description>
            <se:Title>Patrimoine bâti et paysager à protéger</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>07</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>00</ogc:Literal>
                </ogc:PropertyIsEqualTo>
     
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-00.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>5</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
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
          <se:PointSymbolizer>
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-01.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>18</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
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
          <se:PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-01.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>5</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>    
        
<!-- #####  PSC 07_02  ##### --> 
          
        <se:Rule>
          <se:Name>Patrimoine paysager à protéger pour des motifs architectural</se:Name>
          <se:Description>
            <se:Title>Patrimoine paysager à protéger pour des motifs architectural</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>07</ogc:Literal>
              </ogc:PropertyIsEqualTo>
             
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>02</ogc:Literal>
                </ogc:PropertyIsEqualTo>
          
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PointSymbolizer>
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-02.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>18</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Patrimoine paysager à protéger pour des motifs architectural</se:Name>
          <se:Description>
            <se:Title>Patrimoine paysager à protéger pour des motifs architectural</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>07</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>02</ogc:Literal>
                </ogc:PropertyIsEqualTo>
         
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-02.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>5</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>     

<!-- #####  PSC 07_03  ##### --> 
          
        <se:Rule>
          <se:Name>Patrimoine paysager espace boisé à protéger pour des motifs architectural</se:Name>
          <se:Description>
            <se:Title>Patrimoine paysager espace boisé à protéger pour des motifs architectural</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>07</ogc:Literal>
              </ogc:PropertyIsEqualTo>
             
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>03</ogc:Literal>
                </ogc:PropertyIsEqualTo>
          
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PointSymbolizer>
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-03.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>18</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Patrimoine paysager espace boisé à protéger pour des motifs architectural</se:Name>
          <se:Description>
            <se:Title>Patrimoine paysager espace boisé à protéger pour des motifs architectural</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>07</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>03</ogc:Literal>
                </ogc:PropertyIsEqualTo>
         
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-03.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>5</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule> 

<!-- #####  PSC 07_04  ##### --> 
          
        <se:Rule>
          <se:Name>Eléments de paysage (sites et secteurs)à protéger pour des motifs d'ordre écologique</se:Name>
          <se:Description>
            <se:Title>Eléments de paysage (sites et secteurs)à protéger pour des motifs d'ordre écologique</se:Title>
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
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PointSymbolizer>
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-04.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>18</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>Eléments de paysage (sites et secteurs)à protéger pour des motifs d'ordre écologique</se:Name>
          <se:Description>
            <se:Title>Eléments de paysage (sites et secteurs)à protéger pour des motifs d'ordre écologique</se:Title>
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
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-04.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>5</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule> 
        
<!-- #####  PSC 07_05  ##### --> 
          
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
             
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>05</ogc:Literal>
                </ogc:PropertyIsEqualTo>
          
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PointSymbolizer>
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-05.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>18</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
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
           
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>stypepsc</ogc:PropertyName>
                  <ogc:Literal>05</ogc:Literal>
                </ogc:PropertyIsEqualTo>
         
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_07-05.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>5</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
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
          <se:PointSymbolizer>
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_05-06-07.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>16</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
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
          <se:PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_05-06-07.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>4</se:Size>
              </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
                

<!-- #####  PSC 16_01  ##### --> 

        <se:Rule>
           <se:Name>Bâtiment susceptible de changer de destination</se:Name>
          <se:Description>
            <se:Title>Bâtiment susceptible de changer de destination</se:Title>
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
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PointSymbolizer>
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_16_41.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>15</se:Size>
               </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        
        <se:Rule>
           <se:Name>Bâtiment susceptible de changer de destination</se:Name>
          <se:Description>
            <se:Title>Bâtiment susceptible de changer de destination</se:Title>
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
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_16_41.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>3</se:Size>
               </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>

<!-- #####  PSC22-01  ##### --> 
<!--
        <se:Rule>
           <se:Name>Diversité commerciale</se:Name>
          <se:Description>
            <se:Title>Diversité commerciale</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>22</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PointSymbolizer>
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_22.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>18</se:Size>
               </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        
        <se:Rule>
           <se:Name>Diversité commerciale</se:Name>
          <se:Description>
            <se:Title>Diversité commerciale</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typepsc</ogc:PropertyName>
                <ogc:Literal>22</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000</se:MaxScaleDenominator>
          <se:PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_22.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>05</se:Size>
               </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>             
        
-->
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
          <se:PointSymbolizer>
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_39.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>18</se:Size>
               </se:Graphic>
          </se:PointSymbolizer>
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
          <se:PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_39.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>5</se:Size>
               </se:Graphic>
          </se:PointSymbolizer>
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
          <se:PointSymbolizer>
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_99_pct.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>15</se:Size>
               </se:Graphic>
          </se:PointSymbolizer>
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
          <se:PointSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
               <se:Graphic>
                  <se:ExternalGraphic>
                     <se:OnlineResource xlink:type="simple" xlink:href="docurba/typepsc_99_pct.svg"/>
                     <se:Format>image/svg+xml</se:Format>
                  </se:ExternalGraphic>
                  <se:Size>3</se:Size>
               </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule> 
        
        
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
