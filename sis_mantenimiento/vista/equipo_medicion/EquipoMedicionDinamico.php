<?php
/**
*@package pXP
*@file gen-TipoSensor.php
*@author  (mflores)
*@date 15-03-2012 10:27:35
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/
header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.EquipoMedicionDinamico=Ext.extend(Phx.gridInterfaz,{
     constructor:function(config){
		//console.log(config,'config')
		
		this.configMaestro=config;
		this.config=config;
    	//llama al constructor de la clase padre
    	Phx.CP.loadingShow();
	    this.storeAtributos= new Ext.data.JsonStore({
          			url:'../../sis_mantenimiento/control/EquipoVariable/listarColumnasEquipoVariable',
				    id: 'id_equipo_variable',
   					root: 'datos',
   				    totalProperty: 'total',
   					fields: ['key','codigo_unidad_medida','id_unidad_medida','nombre_tipo_variable',
								{name:'id_equipo_variable', type: 'numeric'},
								{name:'valor_max', type: 'numeric'},
								{name:'id_uni_cons', type: 'numeric'},
								{name:'obs', type: 'string'},
								{name:'valor_min', type: 'numeric'},
								{name:'id_tipo_variable', type: 'numeric'}],
						sortInfo:{
							field: 'id_equipo_variable',
							direction: 'ASC'
						}});
			//evento de error
			this.storeAtributos.on('loadexception',this.conexionFailure);				
			
			this.storeAtributos.load({params:{
				                              "sort":"id_equipo_variable",
				                              "dir":"ASC",
				                              'id_uni_cons':config.id_uni_cons,
				                               start:0, 
				                               limit:50},callback:this.successConstructor,scope:this})			
	},		
	
	successConstructor:function(rec,con,res){
		console.log(rec,con,res)
		
		this.Atributos=[];
		this.fields=[];
		this.id_store='id_equipo_med_uni_cons'
		
		this.sortInfo={
			field: this.id_store,
			direction: 'ASC'
		};
		this.fields.push(this.id_store)
		this.fields.push('id_uni_cons')
		
		if(res)
		{
			this.Atributos[0]={
			//configuracion del componente
								config:{
										labelSeparator:'',
										inputType:'hidden',
										name: this.id_store
								},
								type:'Field',
								form:true 
						};
			
			this.Atributos[1]={
			//configuracion del componente
								config:{
										
										name: 'fecha',
										fieldLabel: 'Fecha'
								},
								type:'DateField',
								filters:{pfiltro:'fecha',type:'date'},
								grid:true,
								form:true 
						};
						;
						
			var recText = this.id_store +'#integer@fecha#date';			
				//console.log('this.id_store: ', this.id_store);		
			
			for (var i=0;i<rec.length;i++){
				var configDef={};
				
			var codigo_col = Ext.util.Format.trim(Ext.util.Format.lowercase(rec[i].data.nombre_tipo_variable))+'_'+rec[i].data.key;
				
				this.fields.push(codigo_col)
			    recText=recText+'@'+codigo_col+'#varchar'
				
				this.Atributos[i+2]={config:{
									 name: codigo_col,
									 fieldLabel: rec[i].data.nombre_tipo_variable+ ' ['+rec[i].data.codigo_unidad_medida +']',
									 allowBlank: true,
									 anchor: '80%',
									 gwidth: 100,
									 maxLength:100
									},
									type:'Field',
									filters:{pfiltro:rec[i].data.codigo_columna,type:'string'},
									id_grupo:1,
									egrid:true,
									grid:true,
									form:true
							};
					
			}
			
			Phx.CP.loadingHide();
			Phx.vista.EquipoMedicionDinamico.superclass.constructor.call(this,this.config);
			this.argumentExtraSubmit={'id_uni_cons':this.config.id_uni_cons,'datos':recText};
		    
			
			//this.addButton('aSubirExcel',{text:'Subir archivo',iconCls: 'blist',disabled:false,handler:this.aSubirExcel,tooltip: '<b>Subir archivo</b><br/>Permite subir al sevidor un archivo CSV'});
		    //this.addButton('reporteHidro',{text:'Reporte',iconCls: 'blist',disabled:false,handler:this.reporteHidro,tooltip: '<b>Generar gráfica</b>'});
		    //this.addButton('promedios',{text:'Promedios',iconCls: 'blist',disabled:false,handler:this.promedios,tooltip: '<b>Obtener promedios</b>'});
		
		
			this.init();
			
			this.store.baseParams={'id_uni_cons':this.config.id_uni_cons,'datos':recText};			               
				                   
			this.load({params:{start:0, limit:50}})
			
		}
		
	},
	
	
	promedios: function()
	{
		/*var datos = {
			id_sensor:this.config.id_sensor,
			tipo_sensor_codigo:this.config.tipo_sensor_codigo,
			id_tipo_sensor:this.config.id_tipo_sensor,
			tabla:this.id_store,
			}; 
		
		Phx.CP.loadWindows('../../../sis_hidrologia/vista/tipo_sensor_codigo/Promedios.php',
		'Promedio',
		{
			modal:true,
			width:500,
			height:300
	    },datos,this.idContenedor,'Promedios')*/
	},
	
	reporteHidro:function()
	{															
		var data = {
			id_sensor:this.config.id_sensor,
			tipo_sensor_codigo:this.config.tipo_sensor_codigo,
			id_tipo_sensor:this.config.id_tipo_sensor,
			tabla:this.id_store,
			};   
					
		Phx.CP.loadWindows('../../../sis_hidrologia/vista/tipo_sensor_codigo/RepHidro.php',
		'Reporte',
		{
			modal:true,
			width:500,
			height:300
	    },data,this.idContenedor,'RepHidro')			
	},
		
	aSubirExcel:function()
	{							
		Phx.CP.loadWindows('../../../sis_hidrologia/vista/tipo_sensor_codigo/SubirExcelDinamico.php',
		'Subir archivo',
		{
			modal:true,
			width:500,
			height:250
	    },{id_sensor:this.config.id_sensor,
	    	tipo_sensor_codigo:this.config.tipo_sensor_codigo,
	    	id_tipo_sensor:this.config.id_tipo_sensor},this.idContenedor,'SubirExcelDinamico')
	},
	
	title:'Tipo Sensor',
	ActSave:'../../sis_hidrologia/control/TipoSensorCodigo/insertarTipoSensorCodigo',
	ActDel:'../../sis_hidrologia/control/TipoSensorCodigo/eliminarTipoSensorCodigo',
	ActList:'../../sis_hidrologia/control/TipoSensorCodigo/listarTipoSensorCodigo',
	bdel:true,
	bsave:true,
	bnew:true,
	bedit:true,
	/* preparaMenu:function(tb){
			this.getBoton('generartable').enable();
            Phx.vista.EquipoMedicionDinamico.superclass.preparaMenu.call(this,tb)
			return tb
		},
	liberaMenu:function(tb){
			this.getBoton('generartable').disable();
			Phx.vista.EquipoMedicionDinamico.superclass.liberaMenu.call(this,tb)
			return tb
		},
	loadValoresIniciales:function()
	{
		Phx.vista.EquipoMedicionDinamico.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_sensor').setValue(this.config.id_sensor);	
			
	},*/
				
	onReloadPage:function(m)
	{
		this.maestro=m;						
		this.store.baseParams={id_sensor:this.maestro.id_sensor};
		this.load({params:{start:0, limit:50}});			
	}
		
}
)
</script>
		
		