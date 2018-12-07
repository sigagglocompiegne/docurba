<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>geo_p_zone_urba_v2017</se:Name>
    <UserStyle>
      <se:Name>geo_p_zone_urba_v2017</se:Name>
      <se:FeatureTypeStyle>
      
      
        <se:Rule>
          <se:Name>Agricole</se:Name>
          <se:Description>
            <se:Title>Agricole</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typezone</ogc:PropertyName>
              <ogc:Literal>A</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#ffff7f</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.24</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>Agricole</se:Name>
          <se:Description>
            <se:Title>Agricole</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typezone</ogc:PropertyName>
              <ogc:Literal>A</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#ffff7f</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.24</se:SvgParameter>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
                
        
        <se:Rule>
          <se:Name>Naturel</se:Name>
          <se:Description>
            <se:Title>Naturel</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typezone</ogc:PropertyName>
              <ogc:Literal>N</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#55ff00</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.24</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>Naturel</se:Name>
          <se:Description>
            <se:Title>Naturel</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>typezone</ogc:PropertyName>
              <ogc:Literal>N</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#55ff00</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.24</se:SvgParameter>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
                
        
        <se:Rule>
          <se:Name>Urbanisé (habitat)</se:Name>
          <se:Description>
            <se:Title>Urbanisé (habitat)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>U</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>01</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#ff5500</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>Urbanisé (habitat)</se:Name>
          <se:Description>
            <se:Title>Urbanisé (habitat)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>U</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>01</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#ff5500</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>Urbanisé (activité)</se:Name>
          <se:Description>
            <se:Title>Urbanisé (activité)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>U</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>02</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#aa55ff</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>Urbanisé (activité)</se:Name>
          <se:Description>
            <se:Title>Urbanisé (activité)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>U</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>02</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#aa55ff</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>Urbanisé (mixte)</se:Name>
          <se:Description>
            <se:Title>Urbanisé (mixte)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>U</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>03</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#ff5500</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>Urbanisé (mixte)</se:Name>
          <se:Description>
            <se:Title>Urbanisé (mixte)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>U</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>03</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#ff5500</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>Urbanisé (équipements)</se:Name>
          <se:Description>
            <se:Title>Urbanisé (équipements)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>U</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                  <ogc:Literal>04</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                  <ogc:Literal>05</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#23ffc8</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>Urbanisé (équipements)</se:Name>
          <se:Description>
            <se:Title>Urbanisé (équipements)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>U</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                  <ogc:Literal>04</ogc:Literal>
                </ogc:PropertyIsEqualTo>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                  <ogc:Literal>05</ogc:Literal>
                </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#23ffc8</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>Urbanisé (autre)</se:Name>
          <se:Description>
            <se:Title>Urbanisé (autre)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>U</ogc:Literal>
              </ogc:PropertyIsEqualTo>
             <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>00</ogc:Literal>
              </ogc:PropertyIsEqualTo>
             </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#a2939b</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>Urbanisé (autre)</se:Name>
          <se:Description>
            <se:Title>Urbanisé (autre)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>U</ogc:Literal>
              </ogc:PropertyIsEqualTo>
             <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>00</ogc:Literal>
              </ogc:PropertyIsEqualTo>
             </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#a2939b</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
 
               
        <se:Rule>
          <se:Name>A urbaniser alternatif (habitat)</se:Name>
          <se:Description>
            <se:Title>A urbaniser alternatif (habitat)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
               <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUc</ogc:Literal>
               </ogc:PropertyIsEqualTo>
               <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>01</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ff5500</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
                
        <se:Rule>
          <se:Name>A urbaniser alternatif (habitat)</se:Name>
          <se:Description>
            <se:Title>A urbaniser alternatif (habitat)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
               <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUc</ogc:Literal>
               </ogc:PropertyIsEqualTo>
               <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>01</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ff5500</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>A urbaniser alternatif (activité)</se:Name>
          <se:Description>
            <se:Title>A urbaniser alternatif (activité)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUc</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>02</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#aa55ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
                
        <se:Rule>
          <se:Name>A urbaniser alternatif (activité)</se:Name>
          <se:Description>
            <se:Title>A urbaniser alternatif (activité)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUc</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>02</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#aa55ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        <se:Rule>
          <se:Name>A urbaniser alternatif (mixte)</se:Name>
          <se:Description>
            <se:Title>A urbaniser alternatif (mixte)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUc</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>03</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ff5500</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
                
        <se:Rule>
          <se:Name>A urbaniser alternatif (mixte)</se:Name>
          <se:Description>
            <se:Title>A urbaniser alternatif (mixte)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUc</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>03</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ff5500</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>

        
        <se:Rule>
          <se:Name>A urbaniser alternatif (équipement)</se:Name>
          <se:Description>
            <se:Title>A urbaniser alternatif (équipement)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUc</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>04</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#23ffc8</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
                
        <se:Rule>
          <se:Name>A urbaniser alternatif (équipement)</se:Name>
          <se:Description>
            <se:Title>A urbaniser alternatif (équipement)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUc</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>04</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#23ffc8</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>A urbaniser bloqué (habitat)</se:Name>
          <se:Description>
            <se:Title>A urbaniser bloqué (habitat)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
               <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUs</ogc:Literal>
               </ogc:PropertyIsEqualTo>
               <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>01</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ff5500</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
                
        <se:Rule>
          <se:Name>A urbaniser bloqué (habitat)</se:Name>
          <se:Description>
            <se:Title>A urbaniser bloqué (habitat)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
               <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUs</ogc:Literal>
               </ogc:PropertyIsEqualTo>
               <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>01</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ff5500</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
    
        
        <se:Rule>
          <se:Name>A urbaniser bloqué (activité)</se:Name>
          <se:Description>
            <se:Title>A urbaniser bloqué (activité)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUs</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>02</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#aa55ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule> 
        
               
        <se:Rule>
          <se:Name>A urbaniser bloqué (activité)</se:Name>
          <se:Description>
            <se:Title>A urbaniser bloqué (activité)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUs</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>02</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#aa55ff</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>A urbaniser bloqué (mixte)</se:Name>
          <se:Description>
            <se:Title>A urbaniser bloqué (mixte)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUs</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>03</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ff5500</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule> 
        
               
        <se:Rule>
          <se:Name>A urbaniser bloqué (mixte)</se:Name>
          <se:Description>
            <se:Title>A urbaniser bloqué (mixte)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUs</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>03</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#ff5500</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>

        
        <se:Rule>
          <se:Name>A urbaniser bloqué (équipement)</se:Name>
          <se:Description>
            <se:Title>A urbaniser bloqué (équipement)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUs</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>04</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#23ffc8</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
                
        <se:Rule>
          <se:Name>A urbaniser bloqué (équipement)</se:Name>
          <se:Description>
            <se:Title>A urbaniser bloqué (équipement)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUs</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>04</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>05</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:Or>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#23ffc8</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        

        <se:Rule>
          <se:Name>A urbaniser (non déterminé)</se:Name>
          <se:Description>
            <se:Title>A urbaniser (non déterminé)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
            <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUs</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUc</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>00</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#646464</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule> 
        
               
        <se:Rule>
          <se:Name>A urbaniser (non déterminé)</se:Name>
          <se:Description>
            <se:Title>A urbaniser (non déterminé)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
            <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUs</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typezone</ogc:PropertyName>
                <ogc:Literal>AUc</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              </ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>l_destdomi</ogc:PropertyName>
                <ogc:Literal>00</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
              <se:GraphicFill>
                <se:Graphic>
                  <se:Mark>
                    <se:WellKnownName>shape://vertline</se:WellKnownName>
                    <se:Stroke>
                      <se:SvgParameter name="stroke">#646464</se:SvgParameter>
                      <se:SvgParameter name="stroke-width">4.0</se:SvgParameter>
                      <se:SvgParameter name="stroke-opacity">0.40</se:SvgParameter>
                    </se:Stroke>
                  </se:Mark>
                  <se:Size>
                    <ogc:Literal>8.0</ogc:Literal>
                  </se:Size>
                </se:Graphic>
              </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
         <se:Rule>
          <se:Name>RNU (carte communale)</se:Name>
           <se:Description>
            <se:Title>RNU (carte communale)</se:Title>
           </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typesect</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:MinScaleDenominator>25001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>1000000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#e6e6e6</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
        <se:Rule>
          <se:Name>RNU (carte communale)</se:Name>
          <se:Description>
            <se:Title>RNU (carte communale)</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>typesect</ogc:PropertyName>
                <ogc:Literal>99</ogc:Literal>
              </ogc:PropertyIsEqualTo>
          </ogc:Filter>
           <se:MinScaleDenominator>5001</se:MinScaleDenominator>
           <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Fill>
              <se:SvgParameter name="fill">#e6e6e6</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">0.40</se:SvgParameter>
            </se:Fill>
            <se:Stroke>
              <se:SvgParameter name="stroke">#646464</se:SvgParameter>
              <se:SvgParameter name="stroke-width">0.46</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
        
        
         <se:Rule>
          <se:Name>zone</se:Name>
          <se:Description>
            <se:Title>zone</se:Title>
          </se:Description>
          <se:MinScaleDenominator>1</se:MinScaleDenominator>
          <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geom</ogc:PropertyName>
            </se:Geometry>
            <se:Stroke>
              <se:SvgParameter name="stroke">#000000</se:SvgParameter>
              <se:SvgParameter name="stroke-width">2.00</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
            </se:Stroke>
          </se:PolygonSymbolizer>
        </se:Rule>
                      
        
        <se:Rule>
          <se:Name>étiquette libelle zone</se:Name>
          <se:Description>
            <se:Title>étiquette libelle zone</se:Title>
          </se:Description>
          <se:MinScaleDenominator>5001</se:MinScaleDenominator>
          <se:MaxScaleDenominator>25000</se:MaxScaleDenominator>
          <se:TextSymbolizer>
         <se:Label>
           <ogc:PropertyName>libelle</ogc:PropertyName>
         </se:Label>
         <se:Font>
           <se:SvgParameter name="font-family">Arial</se:SvgParameter>
           <se:SvgParameter name="font-size">10</se:SvgParameter>
           <se:SvgParameter name="font-style">normal</se:SvgParameter>
           <se:SvgParameter name="font-weight">bold</se:SvgParameter>
         </se:Font>
          <se:Halo>
             <se:Radius>2</se:Radius>
             <se:Fill>
             <se:SvgParameter name="fill">#FFFFFF</se:SvgParameter>
             </se:Fill>
          </se:Halo>
         <se:Fill>
           <se:SvgParameter name="fill">#000000</se:SvgParameter>
         </se:Fill>
          <se:VendorOption name="labelAllGroup">true</se:VendorOption>
          <se:VendorOption name="spaceAround">10</se:VendorOption>
          <se:VendorOption name="autoWrap">50</se:VendorOption>
          </se:TextSymbolizer>
        </se:Rule>


      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
