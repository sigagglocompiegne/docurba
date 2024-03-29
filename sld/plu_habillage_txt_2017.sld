<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>geo_p_habillage_txt</se:Name>
    <UserStyle>
      <se:Name>geo_p_habillage_txt</se:Name>
      <se:FeatureTypeStyle> 
      
      
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette Zonage</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>natecr</ogc:PropertyName>
                <ogc:Literal>ZONE_URBA</ogc:Literal>
              </ogc:PropertyIsEqualTo>
        </ogc:Filter>
    <se:MinScaleDenominator>2490</se:MinScaleDenominator>
    <se:MaxScaleDenominator>5001</se:MaxScaleDenominator>        
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
      	 <se:SvgParameter name="font-family">Arial</se:SvgParameter>
         <se:SvgParameter name="font-size">19</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">normal</se:SvgParameter>
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
         <se:Halo>
           <se:Radius>1</se:Radius>
           <se:Fill>
             <se:SvgParameter name="fill">#FFFFFF</se:SvgParameter>
           </se:Fill>
        </se:Halo> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette Zonage</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>natecr</ogc:PropertyName>
                <ogc:Literal>ZONE_URBA</ogc:Literal>
              </ogc:PropertyIsEqualTo>
        </ogc:Filter>
    <se:MinScaleDenominator>1</se:MinScaleDenominator>
    <se:MaxScaleDenominator>2489</se:MaxScaleDenominator>        
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
      	 <se:SvgParameter name="font-family">Arial</se:SvgParameter>
         <se:SvgParameter name="font-size">13</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">normal</se:SvgParameter>
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
         <se:Halo>
           <se:Radius>1</se:Radius>
           <se:Fill>
             <se:SvgParameter name="fill">#FFFFFF</se:SvgParameter>
           </se:Fill>
        </se:Halo> 
      </se:TextSymbolizer>
    </se:Rule>
    
<!-- AUTRE QUE ZONAGE -->
        
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette autre que le zonage</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
  
              <ogc:PropertyIsNotEqualTo>
                <ogc:PropertyName>natecr</ogc:PropertyName>
                <ogc:Literal>ZONE_URBA</ogc:Literal>
              </ogc:PropertyIsNotEqualTo>

        </ogc:Filter>
    <se:MinScaleDenominator>2490</se:MinScaleDenominator>
    <se:MaxScaleDenominator>5001</se:MaxScaleDenominator>        
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
      	<se:SvgParameter  name="font-family">
		<ogc:PropertyName>police</ogc:PropertyName>
		</se:SvgParameter >
		<se:SvgParameter  name="font-size">
		<ogc:PropertyName>taille</ogc:PropertyName>
		</se:SvgParameter >
        <se:SvgParameter  name="font-style">
		<ogc:PropertyName>style</ogc:PropertyName>
		</se:SvgParameter >
		<se:SvgParameter  name="font-weight">normal</se:SvgParameter >
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
         <se:Halo>
           <se:Radius>1</se:Radius>
           <se:Fill>
             <se:SvgParameter name="fill">#FFFFFF</se:SvgParameter>
           </se:Fill>
        </se:Halo>
      <se:Fill>
        <se:SvgParameter name="fill">
		<ogc:PropertyName>l_couleur</ogc:PropertyName>
		</se:SvgParameter>
      </se:Fill> 
     </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette autre que le zonage</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
          <ogc:PropertyIsNotEqualTo>
                <ogc:PropertyName>natecr</ogc:PropertyName>
                <ogc:Literal>ZONE_URBA</ogc:Literal>
           </ogc:PropertyIsNotEqualTo>  
        </ogc:Filter>
    <se:MinScaleDenominator>1</se:MinScaleDenominator>
    <se:MaxScaleDenominator>2489</se:MaxScaleDenominator>        
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
      	<se:SvgParameter  name="font-family">
		<ogc:PropertyName>police</ogc:PropertyName>
		</se:SvgParameter >
		<se:SvgParameter  name="font-size">
		<ogc:PropertyName>taille</ogc:PropertyName>
		</se:SvgParameter >
        <se:SvgParameter  name="font-style">
		<ogc:PropertyName>style</ogc:PropertyName>
		</se:SvgParameter >
		<se:SvgParameter  name="font-weight">normal</se:SvgParameter >
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
         <se:Halo>
           <se:Radius>1</se:Radius>
           <se:Fill>
             <se:SvgParameter name="fill">#FFFFFF</se:SvgParameter>
           </se:Fill>
        </se:Halo>
      <se:Fill>
         <se:SvgParameter name="fill">
		<ogc:PropertyName>l_couleur</ogc:PropertyName>
		</se:SvgParameter>
      </se:Fill> 
     </se:TextSymbolizer>
    </se:Rule>
    

      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
