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
Phx.vista.EquipoMedicionDinamicoLoc=Ext.extend(Phx.gridInterfaz,{
     constructor:function(config){
		this.configMaestro=config;
		this.config=config;
    	//llama al constructor de la clase padre
    	Phx.CP.loadingShow();
	    this.storeAtributos= new Ext.data.JsonStore({
          			url:'../../sis_mantenimiento/control/EquipoVariable/listarColumnasEquipoVariableLoc',
				    id: 'id_equipo_variable',
   					root: 'datos',
   				    totalProperty: 'total',
   					fields: ['key','codigo_unidad_medida','id_unidad_medida','nombre_tipo_variable',
								//{name:'id_equipo_variable', type: 'numeric'},
								{name:'valor_max', type: 'numeric'},
								{name:'id_uni_cons', type: 'numeric'},
								{name:'obs', type: 'string'},
								{name:'valor_min', type: 'numeric'},
								{name:'id_tipo_variable', type: 'numeric'}],
						sortInfo:{
							field: 'id_tipo_variable',
							direction: 'ASC'
						}});
			//evento de error
			this.storeAtributos.on('loadexception',this.conexionFailure);				

			this.storeAtributos.load({params:{
				                              "sort":"id_tipo_variable",
				                              "dir":"ASC",
				                              'id_localizacion': config.id_localizacion,
				                              id_uni_cons: config.id_uni_cons,
				                              //'id_uni_cons':config.id_uni_cons,
				                               start:0, 
				                               limit:500
				                     	},callback:this.successConstructor,
				                     	scope:this
			})
	},		
	
	successConstructor:function(rec,con,res){
		this.recColumnas = rec;
		this.Atributos=[];
		this.fields=[];
		this.id_store='id_mediciones_mes'
		
		this.sortInfo={
			field: 'fecha,ucons.codigo',
			direction: 'ASC'
		};
		this.fields.push(this.id_store)
		this.fields.push('id_localizacion')
		this.fields.push('id_uni_cons')
		this.fields.push({name:'fecha', type: 'date', dateFormat:'Y-m-d'})
		this.fields.push('hora')
		this.fields.push('observaciones')
		this.fields.push('equipo')
		
		if(res){
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
										name: 'equipo',
										fieldLabel: 'Equipo',
										allowBlank: false,
										anchor: '100%',
										gwidth:200
								},
								type:'TextField',
								//filters:{pfiltro:'fecha',type:'date'},
								grid:true,
								form:false 
						};
			
			this.Atributos[2]={
			//configuracion del componente
								config:{
										
										name: 'fecha',
										fieldLabel: 'Fecha',
										allowBlank: false,
										anchor: '100%',
										format: 'd/m/Y',
										renderer:function (value,p,record){return value?value.dateFormat('d/m/Y'):''}
								},
								type:'DateField',
								filters:{pfiltro:'fecha',type:'date'},
								grid:true,
								form:true 
						};
						
			this.Atributos[3]={
			//configuracion del componente
								config:{
										
										name: 'hora',
										fieldLabel: 'Hora',
										format:'H:i:s',
										anchor: '100%',
										allowBlank: false
								},
								type:'TimeField',
								grid:true,
								form:true 
						};
			this.Atributos[4]={
			//configuracion del componente
								config:{
										
										name: 'observaciones',
										fieldLabel: 'Observaciones',
										anchor: '100%',
										allowBlank: true
								},
								type:'TextArea',
								grid:true,
								form:true 
						};
									
			var recText = 'equipo#varchar@id_uni_cons#integer@'+this.id_store +'#integer@fecha#date@hora#time@observaciones#varchar';			
			
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
			Phx.vista.EquipoMedicionDinamicoLoc.superclass.constructor.call(this,this.config);
			this.argumentExtraSubmit={
				'id_localizacion':this.config.id_localizacion,
				'id_uni_cons':this.config.id_uni_cons,
			'datos':recText};
		    
			
			//this.addButton('aSubirExcel',{text:'Subir archivo',iconCls: 'blist',disabled:false,handler:this.aSubirExcel,tooltip: '<b>Subir archivo</b><br/>Permite subir al sevidor un archivo CSV'});
		    //this.addButton('reporteHidro',{text:'Reporte',iconCls: 'blist',disabled:false,handler:this.reporteHidro,tooltip: '<b>Generar gráfica</b>'});
		    //this.addButton('promedios',{text:'Promedios',iconCls: 'blist',disabled:false,handler:this.promedios,tooltip: '<b>Obtener promedios</b>'});
		    
		    //Agrega eventos a los componentes creados
		this.cmb_caract.on('select',function (combo, record, index){
			//Verifica que el campo de texto tenga algun valor
			if(Ext.util.Format.trim(this.txt_caract.getValue())!=''){
				this.store.baseParams.nombre_caract=Vcmb_caract.getValue();
				this.store.baseParams.valor_caract=Vtxt_caract.getValue();	
				this.store.load({params:{start:0, limit:this.tam_pag}});	
			} else{
				this.store.baseParams.nombre_caract='';
				this.store.baseParams.valor_caract='';
				this.store.load({params:{start:0, limit:this.tam_pag}});
			}
		},this);
		
		this.cmb_caract.store.on('exception', this.conexionFailure);
		
		this.txt_caract.on('blur',function (combo, record, index){
			//Verifica que el campo de texto tenga algun valor
			if(Ext.util.Format.trim(this.cmb_caract.getValue())!=''){
				this.store.baseParams.nombre_caract=this.cmb_caract.getValue();
				this.store.baseParams.valor_caract=this.txt_caract.getValue();	
				this.store.load({params:{start:0, limit:this.tam_pag}});
			} else{
				this.store.baseParams.nombre_caract='';
				this.store.baseParams.valor_caract='';
				this.store.load({params:{start:0, limit:this.tam_pag}});
			}
		},this);

		    this.tbar.add('Desde: ',this.dateFechaIni);
		    this.tbar.add('Hasta: ',this.dateFechaFin);
		    this.tbar.add('Limite: ',this.cmbLimit);
		    //Agrega los botones a la barra de herramientas
			this.tbar.add(this.cmb_caract);
			this.tbar.add(this.txt_caract);
		    
		
		    this.addButton('btnGrafica',{
            text : 'Graficar',
            iconCls : 'bgraph',
            disabled : false,
            handler : this.onButtonGrafica,
            tooltip : '<b>Gráfica</b><br/><b>Genera gráfica (La ordenación de los resultados afecta la gráfica)</b>'
             });
        
		
			this.init();
			
					                   
			var milisegundos=parseInt(7*24*60*60*1000);
			var fechaActual = new Date();
			var fechaini  = new Date();
			fechaini.setTime(parseInt(fechaActual.getTime()-milisegundos));
 
           
			this.dateFechaIni.setValue(fechaini);
			this.dateFechaFin.setValue(fechaActual);
			
			this.store.baseParams={
				'id_localizacion':this.config.id_localizacion,
				'id_uni_cons':this.config.id_uni_cons,
			'datos':recText,fecha_ini:this.dateFechaIni.getValue().dateFormat('d/m/Y'),fecha_fin:this.dateFechaFin.getValue().dateFormat('d/m/Y') };			               
		
            this.load();
		}
		
	},
	onButtonGrafica:function(){
		
		var rec = this.store.data.items;
	
		if(google&&google.visualization){
			var data = new google.visualization.DataTable();
			//adciona columnas
			//data.addColumn('string', 'nombre');
			data.addColumn('datetime', 'Fecha');
			//data.addColumn('timeofday', 'Hora');
			for (j=0;j<this.recColumnas.length ;j++){
				data.addColumn('number', this.recColumnas[j].data.nombre_tipo_variable);
						
			}
			for (var i=0;i<rec.length;i++){
				var fila = [];
			    
			   // fila[0]='prueba';
			    //fila[0]=rec[i].data['fecha'].dateFormat('d/m/Y')+' '+rec[i].data['hora']
			    var time=rec[i].data['hora'].split(":");
			    rec[i].data['fecha'].setHours(time[0],time[1],time[2],0);
			    
			    fila[0]=rec[i].data['fecha'];
			   
			
			    
			    for (j=0;j<this.recColumnas.length;j++){
			        var codigo_col = 'col_'+this.recColumnas[j].data.key;
				    var aux = parseFloat(rec[i].data[codigo_col]);
				    fila[j+1]=aux?aux:0;
			      }
			     data.addRow(fila);
			  }
			  var pagIndicadores =  Phx.CP.getPagina(this.idContenedor+'-east');
			  if(pagIndicadores){
			     pagIndicadores.setDatachart(data);
		      }
	     }
	},
	
	onButtonAct:function(){
		if(this.dateFechaIni.isValid() && this.dateFechaFin.isValid())
		{
			this.store.baseParams=Ext.apply(this.store.baseParams,{fecha_ini:this.dateFechaIni.getValue().dateFormat('d/m/Y'),fecha_fin:this.dateFechaFin.getValue().dateFormat('d/m/Y')   })
			
			
			this.limit = this.cmbLimit.getValue();
			if(this.store.lastOptions){
			 //Phx.vista.EquipoMedicionDinamico.superclass.onButtonAct.call(this);
			 
			 this.load({params:{start:0, limit:this.limit},callback:this.successReloadGrid,scope:this})
			}
			else{
				this.load({params:{start:0, limit:this.limit},callback:this.successReloadGrid,scope:this})
			}
			
		}
		
	},
	
	successReloadGrid:function(rec,con,res){

		
	},
	
	onButtonDel:function(){
		
	},
	
	
	
	title:'Detalle Consolidación de Mediciones por Localización',
	ActSave:'../../sis_mantenimiento/control/EquipoMedicion/insertarEquipoMedicionDinamico',
	ActDel:'../../sis_mantenimiento/control/EquipoMedicion/eliminarEquipoMedicionDinamico',
	ActList:'../../sis_mantenimiento/control/EquipoMedicion/listarLocalizacionEquipoMedicionDinamico',
	bdel:false,
	bsave:false,
	bnew:false,
	bedit:false,
	fwidth: 450,
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
	
	
					       		
	cmbLimit:new Ext.form.ComboBox({
	        store:[100,200,500,1000,5000,10000,20000,50000],
	        value:1000,
	        typeAhead: true,
	        mode: 'local',
	        triggerAction: 'all',
	        emptyText:'Tipo..',
	        selectOnFocus:true,
	        width:135
	    }),
				
	onReloadPage:function(m)
	{
		this.maestro=m;	
		this.limit = this.cmbLimit.getValue();					
		this.store.baseParams={
			id_localizacion:this.maestro.id_localizacion,
			id_uni_cons:this.maestro.id_uni_cons
			};
		this.load({params:{start:0, limit:this.limit}});			
	},
	dateFechaIni:new Ext.form.DateField({
		      
	          vtype: 'daterange',
	          name:  'startdt',
	          format: 'd/m/Y',
	          allowBlank: false,
             id: 'startdt'+this.idContenedor,
              endDateField: 'enddt'+this.idContenedor
	         	
	    }),
	 dateFechaFin:new Ext.form.DateField({
		    
	         vtype: 'daterange',
	         name: 'enddt',
	         format: 'd/m/Y',
	         allowBlank: false,
             id: 'enddt'+this.idContenedor,
             startDateField: 'startdt'+this.idContenedor
	         	
	    }),  
	 east:{
		  url:'../../../sis_mantenimiento/vista/equipo_medicion/IndicadoresMediciones.php',
		  title:'Indicadores', 
		  //height:'50%',	//altura de la ventana hijo
		  width:'50%',		//ancho de la ventana hjo
		  cls:'IndicadoresMediciones'
	}, 
	//Aumenta campos para filtro por caracteristicas
	cmb_caract: new Ext.form.ComboBox({
			name:'cmb_caract',
			fieldLabel:'Características',
			allowBlank:true,
			emptyText:'Elija una característica...',
			store: new Ext.data.JsonStore({
  			url: '../../sis_mantenimiento/control/UniConsDet/listarCaract',
				id: 'id_uni_cons_det',
				root: 'datos',
				sortInfo:{
					field: 'nombre',
					direction: 'ASC'
				},
				totalProperty: 'total',
				fields: ['nombre'],
				// turn on remote sorting
				remoteSort: true,
				baseParams:{par_filtro:'nombre'}
			}),
			valueField: 'nombre',
			displayField: 'nombre',
			forceSelection:true,
			typeAhead: false,
			triggerAction: 'all',
			lazyRender:true,
			mode:'remote',
			pageSize:10,
			queryDelay:1000,
			minChars:2,
			width:180,
			listWidth:300
		}),
		txt_caract: new Ext.form.TextField({
			name: 'txt_caract',
			fieldLabel: 'Valor',
			allowBlank:true,
			emptyText:'Defina el valor de la característica...',
			width: 200
		}),
		south:{
			  url:'../../../sis_mantenimiento/vista/uni_cons_det/UniConsDet.php',
			  title:'Atributos del Equipo', 
			  height:200,
			  cls:'UniConsDet'
		 },
    codReporte:'S/C',
	codSistema:'GEM',
	pdfOrientacion:'L'
		
})
</script>
		
		