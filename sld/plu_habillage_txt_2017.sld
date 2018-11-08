<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>geo_p_habillage_txt_v20017</se:Name>
    <UserStyle>
      <se:Name>geo_p_habillage_txt_v2017</se:Name>
      <se:FeatureTypeStyle> 
      
      
    <se:Rule>
    <se:MinScaleDenominator>1</se:MinScaleDenominator>
    <se:MaxScaleDenominator>5000</se:MaxScaleDenominator>        
    <se:TextSymbolizer uom="http://www.opengeospatial.org/se/units/metre">
      <se:Geometry>
        <ogc:Function name="startPoint">
          <ogc:PropertyName>geom</ogc:PropertyName>
        </ogc:Function>
      </se:Geometry>
      <se:Label>
        <ogc:PropertyName>txt</ogc:PropertyName>
      </se:Label>     
      <se:Font>
       <se:SvgParameter name="font-family">
         <ogc:PropertyName>police</ogc:PropertyName>
       </se:SvgParameter>
       <se:SvgParameter name="font-size">
         <ogc:PropertyName>taille</ogc:PropertyName>
       </se:SvgParameter>
        <se:SvgParameter name="font-style">
         <ogc:PropertyName>style</ogc:PropertyName>
       </se:SvgParameter>
      </se:Font>
      <se:LabelPlacement>
       <se:PointPlacement>
         <se:AnchorPoint>
            <se:AnchorPointX>0</se:AnchorPointX>
            <se:AnchorPointY>0</se:AnchorPointY>
         </se:AnchorPoint>
        <se:Rotation>         
              <ogc:Mul>
              <ogc:Literal>-1</ogc:Literal>
              <ogc:PropertyName>angle</ogc:PropertyName>
                </ogc:Mul>     
              </se:Rotation>                  
       </se:PointPlacement>
      </se:LabelPlacement>
 <!--     <se:Fill>
        <se:SvgParameter name="fill">#FFFFFF</se:SvgParameter>
      </se:Fill>
      <se:VendorOption name="spaceAround">10</se:VendorOption>
      <se:VendorOption name="autoWrap">85</se:VendorOption>
      <se:VendorOption name="group">yes</se:VendorOption>    -->
         <se:Halo>
           <se:Radius>1</se:Radius>
           <se:Fill>
             <se:SvgParameter name="fill">#FFFFFF</se:SvgParameter>
           </se:Fill>
        </se:Halo> 
      </se:TextSymbolizer>
    </se:Rule>


        
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
