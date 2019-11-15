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
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette ER 05_01</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>255,0,255</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">12</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
          <se:SvgParameter name="fill">#FF00FF</se:SvgParameter>
       </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette ER 05_01</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>255,0,255</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">8</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
        <se:SvgParameter name="fill">#FF00FF</se:SvgParameter>
      </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette ER 05_02-03</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>153,108,45</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">12</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
          <se:SvgParameter name="fill">#996C2D</se:SvgParameter>
       </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette ER 05_02-03</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>153,108,45</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">8</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
        <se:SvgParameter name="fill">#996C2D</se:SvgParameter>
      </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette ER 05_04</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>11,178,0</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">12</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
          <se:SvgParameter name="fill">#0BB200</se:SvgParameter>
       </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette ER 05_04</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>11,178,0</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">8</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
        <se:SvgParameter name="fill">#0BB200</se:SvgParameter>
      </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette ER 05_05</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>255,170,0</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">12</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
          <se:SvgParameter name="fill">#FFAA00</se:SvgParameter>
       </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette ER 05_05</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>255,170,0</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">8</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
        <se:SvgParameter name="fill">#FFAA00</se:SvgParameter>
      </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette ER 05_00-06-07</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>130,130,255</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">12</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
          <se:SvgParameter name="fill">#8282FF</se:SvgParameter>
       </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette ER 05_00-06-07</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>130,130,255</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">8</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
        <se:SvgParameter name="fill">#8282FF</se:SvgParameter>
      </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette OAP 18</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>0,255,255</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">12</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
          <se:SvgParameter name="fill">#00FFFF</se:SvgParameter>
       </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette OAP 18</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>12</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>0,255,255</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">8</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
        <se:SvgParameter name="fill">#00FFFF</se:SvgParameter>
      </se:Fill> 
      </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette Patrimoine 07_01</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>10</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>153,108,45</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">10</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
        <se:SvgParameter name="fill">#996C2D</se:SvgParameter>
      </se:Fill> 
     </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette Patrimoine 07_01</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>10</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>153,108,45</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">7</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
        <se:SvgParameter name="fill">#996C2D</se:SvgParameter>
      </se:Fill> 
     </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette Patrimoine 07_00-02-03-04-05</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>10</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>76,230,112</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">10</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
        <se:SvgParameter name="fill">#4CE670</se:SvgParameter>
      </se:Fill> 
     </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette Patrimoine 07_00-02-03-04-05</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>10</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>couleur</ogc:PropertyName>
                <ogc:Literal>76,230,112</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">7</se:SvgParameter>
         <se:SvgParameter name="font-style">normal</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
        <se:SvgParameter name="fill">#4CE670</se:SvgParameter>
      </se:Fill> 
     </se:TextSymbolizer>
    </se:Rule>
    
    
    <se:Rule>
      <se:Description>
            <se:Title>Etiquette ZAC</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>21</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">21</se:SvgParameter>
         <se:SvgParameter name="font-style">italic</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
            <se:Title>Etiquette ZAC</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>21</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Gras</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-style">italic</se:SvgParameter>
         <se:SvgParameter name="font-weight">bold</se:SvgParameter>
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
            <se:Title>Etiquette recul</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>8</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Normal</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">10</se:SvgParameter>
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
            <se:Title>Etiquette recul</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>8</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Normal</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">6</se:SvgParameter>
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
            <se:Title>Etiquette infos</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>9</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Normal</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">10</se:SvgParameter>
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
            <se:Title>Etiquette infos</se:Title>
      </se:Description>
      <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
           <ogc:And>   
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>taille</ogc:PropertyName>
                <ogc:Literal>9</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>style</ogc:PropertyName>
                <ogc:Literal>Normal</ogc:Literal>
              </ogc:PropertyIsEqualTo>
           </ogc:And>   
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
         <se:SvgParameter name="font-size">7</se:SvgParameter>
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

        
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
