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
				                               limit:500},callback:this.successConstructor,scope:this})			
	},		
	
	successConstructor:function(rec,con,res){
		
		this.recColumnas = rec;
		console.log(rec,con,res)
		
		this.Atributos=[];
		this.fields=[];
		this.id_store='id_mediciones_mes'
		
		this.sortInfo={
			field: 'fecha',
			direction: 'ASC'
		};
		this.fields.push(this.id_store)
		this.fields.push('id_uni_cons')
		this.fields.push({name:'fecha', type: 'date', dateFormat:'Y-m-d'})
		this.fields.push('hora')
		
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
										fieldLabel: 'Fecha',
										allowBlank: false,
										anchor: '80%',
										format: 'd/m/Y',
										renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
								},
								type:'DateField',
								filters:{pfiltro:'fecha',type:'date'},
								grid:true,
								form:true 
						};
						
			this.Atributos[2]={
			//configuracion del componente
								config:{
										
										name: 'hora',
										fieldLabel: 'Hora',
										format:'H:i:s',
										allowBlank: false
								},
								type:'TimeField',
								grid:true,
								form:true 
						};
									
			var recText = this.id_store +'#integer@fecha#date@hora#time';			
				//console.log('this.id_store: ', this.id_store);		
			
			for (var i=0;i<rec.length;i++){
				var configDef={};
				
			var codigo_col = 'col_'+rec[i].data.key;
				
				this.fields.push(codigo_col);
				this.fields.push(codigo_col+'_key');
				
			    recText=recText+'@'+codigo_col+'#varchar'+'@'+codigo_col+'_key#integer'
				
				this.Atributos.push({config:{
									 name: codigo_col,
									 fieldLabel: rec[i].data.nombre_tipo_variable+ ' ['+rec[i].data.codigo_unidad_medida +']',
									 allowBlank: true,
									 anchor: '80%',
									 gwidth: 100,
									 maxLength:100
									},
									type:'NumberField',
									filters:{pfiltro:rec[i].data.codigo_columna,type:'string'},
									id_grupo:1,
									egrid:true,
									grid:true,
									form:true
							});
							
				
				
				this.Atributos.push({config:{
									 name: codigo_col+'_key',
									 inputType:'hidden'
									},
									type:'Field',
									form:true
							});
					
			}
			
			Phx.CP.loadingHide();
			Phx.vista.EquipoMedicionDinamico.superclass.constructor.call(this,this.config);
			this.argumentExtraSubmit={'id_uni_cons':this.config.id_uni_cons,'datos':recText};
		    
			
			//this.addButton('aSubirExcel',{text:'Subir archivo',iconCls: 'blist',disabled:false,handler:this.aSubirExcel,tooltip: '<b>Subir archivo</b><br/>Permite subir al sevidor un archivo CSV'});
		    //this.addButton('reporteHidro',{text:'Reporte',iconCls: 'blist',disabled:false,handler:this.reporteHidro,tooltip: '<b>Generar gráfica</b>'});
		    //this.addButton('promedios',{text:'Promedios',iconCls: 'blist',disabled:false,handler:this.promedios,tooltip: '<b>Obtener promedios</b>'});
		
		
			this.init();
			
			this.store.baseParams={'id_uni_cons':this.config.id_uni_cons,'datos':recText};			               
				                   
			this.load({params:{start:0, limit:500}})
			
		}
		
	},
	
	onButtonDel:function(){
		if(confirm('¿Está seguro de eliminar el registro?')){
			//recupera los registros seleccionados
			var filas=this.sm.getSelections();
			var data= {},aux={};
			//console.log(filas,i)
			
            //arma una matriz de los identificadores de registros que se van a eliminar
            this.agregarArgsExtraSubmit();
            console.log(this.recColulmanas)
            
			for(var i=0;i<this.sm.getCount();i++){
				
				aux={};
				aux[this.id_store]=filas[i].data[this.id_store];
				var keys ='';
				var j=0;
				for (j=0;j<this.recColumnas.length -1;j++){
					
					var codigo_col = 'col_'+this.recColumnas[j].data.key+'_key';
					
					keys=keys+filas[i].data[codigo_col]+',';
				}
				
				var codigo_col = 'col_'+this.recColumnas[j].data.key+'_key';
				keys=keys+filas[i].data[codigo_col];
				
				
				aux['keys'] = keys;
				
				
				
				data[i]=aux;
				data[i]._fila=this.store.indexOf(filas[i])+1
				//rac 22032012
				
				Ext.apply(data[i],this.argumentExtraSubmit);
				
				
			}
			
	
		
			Phx.CP.loadingShow();
			
			//llama el metodo en la capa de control para eliminación
			Ext.Ajax.request({
				url:this.ActDel,
				success:this.successDel,
				failure:this.conexionFailure,
				//params:this.id_store+"="+this.sm.getSelected().data[this.id_store],
				params:{_tipo:'matriz','row':Ext.util.JSON.encode(data)},
				//argument :{'foo':'xxx'},
				timeout:this.timeout,
				scope:this
			})
		}
	},
	
	
	
	title:'Tipo Sensor',
	ActSave:'../../sis_mantenimiento/control/EquipoMedicion/insertarEquipoMedicionDinamico',
	ActDel:'../../sis_mantenimiento/control/EquipoMedicion/eliminarEquipoMedicionDinamico',
	ActList:'../../sis_mantenimiento/control/EquipoMedicion/listarEquipoMedicionDinamico',
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
		this.store.baseParams={id_uni_cons:this.maestro.id_uni_cons};
		this.load({params:{start:0, limit:500}});			
	}
		
}
)
</script>
		
		